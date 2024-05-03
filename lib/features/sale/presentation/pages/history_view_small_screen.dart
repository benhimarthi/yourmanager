import 'package:flutter/material.dart';
import 'package:yourmanager/core/widgets/history_item.dart';
import 'package:yourmanager/core/widgets/list_view_widgets.dart';

class HistoryViewSmallScreen extends StatefulWidget {
  const HistoryViewSmallScreen({super.key});
  @override
  State<HistoryViewSmallScreen> createState() => _HistoryViewSmallScreenState();
}

class _HistoryViewSmallScreenState extends State<HistoryViewSmallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("History"),
        elevation: 0,
      ),
      body: ListViewWidget(
        [
          historyItem(DateTime.now()),
          historyItem(DateTime.now()),
          historyItem(DateTime.now())
        ],
        10,
      ),
    );
  }
}
