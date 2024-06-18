import 'package:flutter/material.dart';
import 'package:yourmanager/features/authentication/presentation/pages/profile/profile_view_small_screen.dart';

class ProfileMainPage extends StatefulWidget {
  final String userUid;
  const ProfileMainPage({super.key, required this.userUid});

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return ProfileViewSmallScreen(
          userUid: widget.userUid,
        );
      } else {
        return Container();
      }
    });
  }
}
