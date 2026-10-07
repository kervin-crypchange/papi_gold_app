enum BoxEnum {
  config(
    name: 'PAPI_GOLD',
    token: 'PAPI_GOLD_TOKEN',
    refreshToken: 'PAPI_GOLD_REFRESH_TOKEN',
    userLogged: 'PAPI_GOLD_LOGGED',
    isLogged: 'PAPI_GOLD_IS_LOGGED',
    themeMode: 'PAPI_GOLD_THEME_MODE',
    lastMapPosition: 'PAPI_GOLD_LAST_MAP_POSITION',
  );

  final String name;
  final String token;
  final String refreshToken;
  final String userLogged;
  final String isLogged;
  final String themeMode;
  final String lastMapPosition;

  const BoxEnum({
    required this.name,
    required this.token,
    required this.refreshToken,
    required this.userLogged,
    required this.isLogged,
    required this.themeMode,
    required this.lastMapPosition,
  });
}
