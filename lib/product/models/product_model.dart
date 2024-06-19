import 'dart:core';
import 'package:equatable/equatable.dart';

class DbProductItem {
  final int? id;
  final int? metaId;
  final int? priceInCents;
  final DateTime? expiredAt;
  final DateTime? createdAt;

  const DbProductItem({
    required this.id,
    required this.metaId,
    required this.priceInCents,
    required this.expiredAt,
    required this.createdAt,
  });

  static DbProductItem fromJson(Map<String, dynamic> json) {
    return DbProductItem(
      id: json['id'] == null ? null : json['id'] as int,
      metaId: json['meta_id'] == null ? null : json['meta_id'] as int,
      priceInCents:
          json['price_in_cents'] == null ? null : json['price_in_cents'] as int,
      expiredAt: json['expired_at'] == null
          ? null
          : DateTime.parse(json['expired_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }
}

class DbProductMeta {
  final int? id;
  final String? barcode;
  final String? name;
  final String? description;
  final DateTime? createdAt;

  const DbProductMeta({
    required this.id,
    required this.barcode,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  static DbProductMeta fromJson(Map<String, dynamic> json) {
    return DbProductMeta(
      id: json['id'] == null ? null : json['id'] as int,
      barcode: json['barcode'] == null ? null : json['barcode'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      description:
          json['description'] == null ? null : json['description'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }
}

class Product extends Equatable {
  final String name;
  final String description;
  final int priceInCents;
  final String image;
  final DateTime expiredAt;

  bool get isExpired => DateTime.now().isAfter(expiredAt);

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
}

  // static List<Product> products = [
  //   Product(
  //     name: 'Käse',
  //     description: 'Description 1',
  //     priceInCents: 100,
  //     image: 'assets/images/product1.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: -365)),
  //   ),
  //   Product(
  //     name: 'Frischmilch',
  //     description: 'Description 2',
  //     priceInCents: 200,
  //     image: 'assets/images/product2.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: -2)),
  //   ),
  //   Product(
  //     name: 'Eier',
  //     description: 'Description 3',
  //     priceInCents: 300,
  //     image: 'assets/images/product3.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 2)),
  //   ),
  //   Product(
  //     name: 'Joghurt',
  //     description: 'Description 4',
  //     priceInCents: 400,
  //     image: 'assets/images/product4.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 2)),
  //   ),
  //   Product(
  //     name: 'Pizza',
  //     description: 'Description 4',
  //     priceInCents: 400,
  //     image: 'assets/images/product4.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 6)),
  //   ),
  //   Product(
  //     name: 'Hackfleisch',
  //     description: 'Description 5',
  //     priceInCents: 500,
  //     image: 'assets/images/product5.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 8)),
  //   ),
  //   Product(
  //     name: 'Gemüse',
  //     description: 'Description 5',
  //     priceInCents: 500,
  //     image: 'assets/images/product5.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 32)),
  //   ),
  //   Product(
  //     name: 'Apfel Saft',
  //     description: 'Description 5',
  //     priceInCents: 500,
  //     image: 'assets/images/product5.jpg',
  //     expiredAt: DateTime.now().add(const Duration(days: 365)),
  //   ),
  // ];