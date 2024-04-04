import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:todo_app/src/features/todo/data/fake_todo_repository.dart';
import 'package:todo_app/src/features/todo/data/todo_repository.dart';
import 'package:todo_app/src/router/app_router.dart';

void main() {
  runApp(ProviderScope(
    overrides: [
      authRepositoryProvider
          .overrideWithValue(FakeAuthRepository(addDelay: true)),
      todoRepositoryProvider
          .overrideWithValue(FakeTodoRepository(addDelay: true))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
