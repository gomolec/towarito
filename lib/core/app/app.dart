import 'package:flutter/material.dart';
import 'package:towarito/core/navigation/router.dart';
import 'package:towarito/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Towarito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: sl<AppRouter>().config(),
    );
  }
}
