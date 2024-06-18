import 'package:flutter/material.dart';
import 'package:yourmanager/core/widgets/list_view_widgets.dart';

import '../../../../core/widgets/notification_item.dart';

class NotificationViewSmallScreen extends StatefulWidget {
  const NotificationViewSmallScreen({super.key});

  @override
  State<NotificationViewSmallScreen> createState() =>
      _NotificationViewSmallScreenState();
}

class _NotificationViewSmallScreenState
    extends State<NotificationViewSmallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: listViewWidget([notificationItem(DateTime.now())], 10),
    );
  }
}
