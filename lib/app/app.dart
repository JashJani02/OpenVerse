import 'package:flutter/material.dart';

import 'shell.dart';
import 'theme.dart';

class OpenVerseApp extends StatelessWidget {
  const OpenVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenVerse',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      home: const AppShell(),
    );
  }
}