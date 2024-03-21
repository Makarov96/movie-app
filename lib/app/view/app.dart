import 'package:flutter/material.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      home: Container(
        child: Text(context.texts.home.title),
      ),
    );
  }
}
