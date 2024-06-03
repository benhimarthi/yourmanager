import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final String expirationDate;
  final String barcode;
  final double price;
  final double stockPrice;
  final double discount;
  final String image;

  const Product({
    required this.expirationDate,
    required this.barcode,
    required this.discount,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.stockPrice,
    required this.image,
  });

  @override
  List<Object?> get props => [id];
}
