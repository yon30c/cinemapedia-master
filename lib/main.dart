import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/config.dart';

Future<void> main() async {
  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
