import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/app/router.dart';
import 'package:scanvolt/app/theme.dart';

/// ScanVolt アプリのルートウィジェット。
class ScanVoltApp extends ConsumerWidget {
  /// [ScanVoltApp] を生成する。
  const ScanVoltApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'ScanVolt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
