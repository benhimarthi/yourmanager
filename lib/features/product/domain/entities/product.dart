import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double stockPrice;
  final List<String> images;
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.stockPrice,
    required this.images,
  });

  Product.empty()
      : this(
          id: "_empty.id",
          title: "_empty.title",
          description: "_empty.description",
          category: "_empty.category",
          price: -1,
          stockPrice: -1,
          images: [],
        );

  @override
  List<Object?> get props => [id];
}
