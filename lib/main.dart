import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/task.dart';
// ignore: unused_import
import 'providers/task_provider.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox('tasksBox');
  await Hive.openBox('settingsBox');

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(),
    );
  }
}
