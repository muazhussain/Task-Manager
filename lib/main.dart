import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/email_verification_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatefulWidget {
  TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/emailVerification': (context) => const EmailVerification(),
        '/mainBottomNavBar': (context) => const MainBottomNavBar(),
        '/addNewTask': (context) => const AddNewTaskScreen(),
        '/updateProfile': (context) => const UpdateProfileScreen(),
      },
      navigatorKey: TaskManagerApp.globalKey,
      home: const SplashScreen(),
    );
  }
}
