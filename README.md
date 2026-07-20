# papi_gold_app
Aplicación mobile iOS / Android, complementaria al website de papigol.io.


#### Cuenta de prueba temporal
> - deivy.quintero@crypchange.com
> - 1597530Dk#

### Generate Icon Launcher
El icon laucher de la app esta generado por el paquete [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons).

#### 1.- Run the following command to create a new config automatically:
```
dart run flutter_launcher_icons:generate
```
#### 2.- After setting up the configuration, all that is left to do is run the package.
```
flutter pub get
dart run flutter_launcher_icons
```

### Generate Splash Screen
El splash screen de la app, esta generado por [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons). al generar el launcher icon, pero puede ser personalizado con el paquete [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash).

#### 1.- Setting Splash Screen
Customize the following settings and add to your project's pubspec.yaml file or place in a new file in your root project folder named flutter_native_splash.yaml.  El ejemplo esta en la web del paquete.

#### 2.- Run the package
```
dart run flutter_native_splash:create
```
#### 3.-  Set up app initialization (optional)
By default, the splash screen will be removed when Flutter has drawn the first frame. If you would like the splash screen to remain while your app initializes, you can use the preserve() and remove() methods together. Pass the preserve() method the value returned from WidgetsFlutterBinding.ensureInitialized() to keep the splash on screen. Later, when your app has initialized, make a call to remove() to remove the splash screen.