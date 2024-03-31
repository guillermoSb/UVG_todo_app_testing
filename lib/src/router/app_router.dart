import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:todo_app/src/features/todo/presentation/todo_list/todo_list_screen.dart';
import 'package:todo_app/src/router/go_router_refresh_stream.dart';
part 'app_router.g.dart';

enum AppRoute { home, signIn }

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    redirect: (context, state) {
      final user = ref.read(authRepositoryProvider).currentUser;
      final path = state.uri.path;
      final loggedIn = user != null;
      if (loggedIn) {
        if (path == '/signIn') {
          return '/';
        }
      } else {
        if (path != '/signIn') {
          return '/signIn';
        }
      }
      return null;
    },
    routes: [
      // Home
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: TodoListScreen());
        },
      ),
      // Sign In
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInScreen());
        },
      )
    ],
  );
}
