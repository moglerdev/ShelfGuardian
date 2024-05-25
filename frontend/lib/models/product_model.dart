import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String description;
  final int priceInCents;
  final String image;
  final DateTime expiredAt;

  get isExpired => DateTime.now().isAfter(expiredAt);

  const Product({
    required this.name,
    required this.description,
    required this.priceInCents,
    required this.image,
    required this.expiredAt,
  });

  @override
  List<Object?> get props =>
      [name, description, priceInCents, image, expiredAt];

  static List<Product> products = [
    Product(
      name: 'Käse',
      description: 'Description 1',
      priceInCents: 100,
      image: 'assets/images/product1.jpg',
      expiredAt: DateTime.now().add(const Duration(days: -365)),
    ),
    Product(
      name: 'Frischmilch',
      description: 'Description 2',
      priceInCents: 200,
      image: 'assets/images/product2.jpg',
      expiredAt: DateTime.now().add(const Duration(days: -2)),
    ),
    Product(
      name: 'Eier',
      description: 'Description 3',
      priceInCents: 300,
      image: 'assets/images/product3.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 2)),
    ),
    Product(
      name: 'Joghurt',
      description: 'Description 4',
      priceInCents: 400,
      image: 'assets/images/product4.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 2)),
    ),
    Product(
      name: 'Pizza',
      description: 'Description 4',
      priceInCents: 400,
      image: 'assets/images/product4.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 6)),
    ),
    Product(
      name: 'Hackfleisch',
      description: 'Description 5',
      priceInCents: 500,
      image: 'assets/images/product5.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 8)),
    ),
    Product(
      name: 'Gemüse',
      description: 'Description 5',
      priceInCents: 500,
      image: 'assets/images/product5.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 32)),
    ),
    Product(
      name: 'Apfel Saft',
      description: 'Description 5',
      priceInCents: 500,
      image: 'assets/images/product5.jpg',
      expiredAt: DateTime.now().add(const Duration(days: 365)),
    ),
  ];
}
