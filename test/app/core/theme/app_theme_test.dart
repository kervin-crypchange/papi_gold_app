import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/box_enum.dart';
import 'package:papi_gold/app/core/constants/status_color.dart';
import 'package:papi_gold/app/core/theme/app_theme.dart';
import 'package:papi_gold/app/core/theme/colors.dart';

void main() {
  late Directory hiveDirectory;
  late Box config;

  setUpAll(() async {
    hiveDirectory = await Directory.systemTemp.createTemp(
      'papi_gold_theme_test_',
    );
    Hive.init(hiveDirectory.path);
    config = await Hive.openBox(BoxEnum.config.name);
  });

  setUp(() async {
    await config.clear();
    AppThemes.themeModeNotifier.value = AppThemes.defaultThemeMode;
  });

  tearDownAll(() async {
    await config.close();
    await Hive.close();
    await hiveDirectory.delete(recursive: true);
  });

  test('defaults to dark mode when no preference has been stored', () async {
    await AppThemes.loadThemeMode();

    expect(AppThemes.themeModeNotifier.value, ThemeMode.dark);
  });

  test('restores the saved theme before building the app', () async {
    await config.put(BoxEnum.config.themeMode, ThemeMode.light.name);

    await AppThemes.loadThemeMode();

    expect(AppThemes.themeModeNotifier.value, ThemeMode.light);
  });

  test(
    'saves a theme selection and updates the notifier immediately',
    () async {
      await AppThemes.setThemeMode(ThemeMode.light);

      expect(AppThemes.themeModeNotifier.value, ThemeMode.light);
      expect(config.get(BoxEnum.config.themeMode), ThemeMode.light.name);
    },
  );

  testWidgets('updates MaterialApp theme when the selection changes', (
    tester,
  ) async {
    await tester.pumpWidget(_buildThemedApp());
    expect(find.text('Brightness.dark'), findsOneWidget);

    AppThemes.themeModeNotifier.value = ThemeMode.light;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Brightness.light'), findsOneWidget);
  });

  test('system bar icon brightness follows the active theme', () {
    final darkStyle = AppThemes.systemUiOverlayStyle(ThemeMode.dark);
    final lightStyle = AppThemes.systemUiOverlayStyle(ThemeMode.light);

    expect(darkStyle.statusBarIconBrightness, Brightness.light);
    expect(darkStyle.statusBarBrightness, Brightness.dark);
    expect(darkStyle.systemNavigationBarIconBrightness, Brightness.light);
    expect(lightStyle.statusBarIconBrightness, Brightness.dark);
    expect(lightStyle.statusBarBrightness, Brightness.light);
    expect(lightStyle.systemNavigationBarIconBrightness, Brightness.dark);
  });

  test('theme text and control colors meet their contrast thresholds', () {
    for (final theme in [AppThemes.lightTheme, AppThemes.darkTheme]) {
      final colorScheme = theme.colorScheme;
      expect(
        _contrastRatio(colorScheme.onSurface, colorScheme.surface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrastRatio(colorScheme.onPrimary, colorScheme.primary),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrastRatio(colorScheme.outline, colorScheme.surface),
        greaterThanOrEqualTo(3),
      );
      final textAccent = theme.brightness == Brightness.dark
          ? AppColors.secondary
          : colorScheme.primary;
      expect(
        _contrastRatio(textAccent, colorScheme.surface),
        greaterThanOrEqualTo(4.5),
      );
      final badgeColor = AppColors.secondary.withValues(alpha: 0.2);
      final badgeSurface = Color.alphaBlend(badgeColor, colorScheme.surface);
      expect(
        _contrastRatio(
          AppColors.contrastingForeground(
            badgeColor,
            surface: colorScheme.surface,
          ),
          badgeSurface,
        ),
        greaterThanOrEqualTo(4.5),
      );
    }
  });

  test('semantic snackbar colors receive readable foreground colors', () {
    for (final background in [
      AppColors.error,
      AppColors.success,
      AppColors.warning,
      AppColors.secondary,
      AppThemes.lightTheme.colorScheme.primary,
    ]) {
      expect(
        _contrastRatio(AppColors.contrastingForeground(background), background),
        greaterThanOrEqualTo(4.5),
      );
    }
  });

  test('order statuses meet text contrast in both themes', () {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      final surface = brightness == Brightness.dark
          ? AppThemes.darkTheme.colorScheme.surface
          : AppThemes.lightTheme.colorScheme.surface;
      for (final status in [
        'warning',
        'info',
        'primary',
        'danger',
        'gray',
        'success',
      ]) {
        expect(
          _contrastRatio(StatusColor.color(status, brightness), surface),
          greaterThanOrEqualTo(4.5),
          reason: '$status on $brightness',
        );
      }
    }
  });
}

Widget _buildThemedApp() {
  return ValueListenableBuilder<ThemeMode>(
    valueListenable: AppThemes.themeModeNotifier,
    builder: (context, mode, _) {
      return MaterialApp(
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: mode,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(child: Text(Theme.of(context).brightness.toString())),
          ),
        ),
      );
    },
  );
}

double _contrastRatio(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}
