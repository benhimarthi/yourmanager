import 'package:flutter/material.dart';
import 'package:yourmanager/features/authentication/presentation/pages/login_page/login_page_small_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const LoginS();
      } else {
        return Container();
      }
    }));
  }
}
