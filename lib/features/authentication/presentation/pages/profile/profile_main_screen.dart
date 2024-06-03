import 'package:flutter/material.dart';
import 'package:yourmanager/features/authentication/presentation/pages/profile/profile_view_small_screen.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({super.key});

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const ProfileViewSmallScreen();
      } else {
        return Container();
      }
    });
  }
}
