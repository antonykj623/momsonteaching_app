import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'logic/auth_provider.dart';
import 'logic/student_provider.dart';
import 'logic/session_provider.dart';
import 'logic/homework_provider.dart';
import 'views/auth/login_screen.dart';
import 'views/teacher/teacher_shell.dart';
import 'views/parent/parent_shell.dart';
import 'views/admin/admin_shell.dart';
import 'data/models/user_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => HomeworkProvider()),
      ],
      child: const MomsOnTeachingApp(),
    ),
  );
}

class MomsOnTeachingApp extends StatelessWidget {
  const MomsOnTeachingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moms On Teaching',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isAuthenticated || auth.currentUser == null) {
      return const LoginScreen();
    }

    switch (auth.currentUser!.role) {
      case UserRole.teacher:
        return const TeacherShell();
      case UserRole.parent:
        return const ParentShell();
      case UserRole.admin:
      case UserRole.superAdmin:
        return const AdminShell();
    }
  }
}
