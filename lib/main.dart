import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';
import 'screens/onboarding_screen.dart';
//import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox('tasksBox');
  await Hive.openBox('settingsBox');  

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final settingsBox = Hive.box('settingsBox');
   // bool onboardingComplete = settingsBox.get('onboardingComplete', defaultValue: false);

    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  OnboardingScreen(),
    );
  }
}
