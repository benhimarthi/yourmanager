import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String categoryName;
  final DateTime date;
  const Category({
    required this.id,
    required this.categoryName,
    required this.date,
  });
  @override
  List<Object?> get props => [id];
}
