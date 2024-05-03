import 'package:equatable/equatable.dart';

class Representation extends Equatable {
  final String path;
  const Representation({required this.path});
  @override
  List<Object?> get props => [path];
}
