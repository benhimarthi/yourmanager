import 'package:flutter/material.dart';
import 'package:yourmanager/features/notifications/presentation/pages/notification_view_small_screen.dart';

class NotificationMainView extends StatefulWidget {
  const NotificationMainView({super.key});

  @override
  State<NotificationMainView> createState() => _NotificationMainViewState();
}

class _NotificationMainViewState extends State<NotificationMainView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const NotificationViewSmallScreen();
      } else {
        return Container();
      }
    });
  }
}
