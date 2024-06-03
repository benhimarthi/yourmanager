import 'package:equatable/equatable.dart';

class Notifications extends Equatable {
  final String id;
  final String title;
  final String message;
  final String link;
  final DateTime time;
  final bool viewed;
  const Notifications({
    required this.id,
    required this.title,
    required this.message,
    required this.link,
    required this.time,
    required this.viewed,
  });

  @override
  List<Object?> get props => [id];
}
