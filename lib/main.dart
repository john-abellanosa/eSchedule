import 'package:escheduler/features/crew/dashboard/crew_dashboard.dart';
import 'package:escheduler/features/auth/forgot_password.dart';
import 'package:escheduler/features/auth/login_page.dart';
import 'package:escheduler/features/manager/manager_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const eSchedule());
}

class eSchedule extends StatelessWidget {
  const eSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/ForgotPassword': (context) => ForgotPassword(),
        '/CrewDashboard': (context) => CrewDashboard(),
        '/ManagerDashboard': (context) => ManagerDashboard(),
      },
    );
  }
}
