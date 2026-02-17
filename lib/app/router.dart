import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvolt/features/generate/presentation/screens/generate_screen.dart';
import 'package:scanvolt/features/history/presentation/screens/history_screen.dart';
import 'package:scanvolt/features/scan/presentation/screens/scan_screen.dart';
import 'package:scanvolt/features/settings/presentation/screens/settings_screen.dart';
import 'package:scanvolt/shared/widgets/main_shell.dart';

/// アプリ全体のルーティング定義。
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/scan',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scan',
                builder: (context, state) => const ScanScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/generate',
                builder: (context, state) => const GenerateScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
