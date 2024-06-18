import 'package:flutter/material.dart';

class HistoryViewSmallScreen extends StatefulWidget {
  final dynamic historic;
  const HistoryViewSmallScreen({super.key, this.historic});
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
      body: widget.historic,
    );
  }
}
