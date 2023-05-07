import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:towarito/core/app/app_scaffold_messager.dart';

import '../../injection_container.dart';
import '../navigation/app_router.dart';
import '../theme/color_schemes.g.dart';
import '../theme/custom_color.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return MaterialApp.router(
          scaffoldMessengerKey:
              sl<AppScaffoldMessager>().rootScaffoldMessengerKey,
          title: 'Towarito',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            extensions: [lightCustomColors],
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
            extensions: [darkCustomColors],
          ),
          routerConfig: sl<AppRouter>().config(),
        );
      },
    );
  }
}
