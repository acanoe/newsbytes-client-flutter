import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/pages.dart';
import 'services/db.dart';

class NewsBytesApp extends StatelessWidget {
  const NewsBytesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DbService().settings.listenable(keys: ['darkMode']),
      builder: (context, box, widget) {
        // get system dark mode settings
        final String darkMode = box.get('darkMode', defaultValue: "system");
        ThemeMode themeMode;
        Brightness foregroundBrightness;

        switch (darkMode) {
          case "light":
            themeMode = ThemeMode.light;
            foregroundBrightness = Brightness.dark;
            break;
          case "dark":
            themeMode = ThemeMode.dark;
            foregroundBrightness = Brightness.light;
            break;
          default:
            themeMode = ThemeMode.system;
            foregroundBrightness =
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark;
        }

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: foregroundBrightness,
            statusBarIconBrightness: foregroundBrightness,
            systemNavigationBarIconBrightness: foregroundBrightness,
          ),
          child: DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              ColorScheme lightColorScheme;
              ColorScheme darkColorScheme;

              if (lightDynamic != null && darkDynamic != null) {
                lightColorScheme = lightDynamic.harmonized();
                darkColorScheme = darkDynamic.harmonized();
              } else {
                // Otherwise, use fallback schemes.
                lightColorScheme = ColorScheme.fromSeed(
                  seedColor: Colors.green,
                );
                darkColorScheme = ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.dark,
                );
              }

              return GetMaterialApp(
                title: 'NewsBytes',
                debugShowCheckedModeBanner: false,
                themeMode: themeMode,
                theme: ThemeData(
                  colorScheme: lightColorScheme,
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme,
                  useMaterial3: true,
                ),
                defaultTransition: Transition.cupertino,
                popGesture: true,
                initialRoute: MainPage.routeName,
                getPages: appPages,
              );
            },
          ),
        );
      },
    );
  }
}
