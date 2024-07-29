import 'dart:core';
import 'package:equatable/equatable.dart';

/// Represents a product item stored in the database.
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
    this.createdAt,
  });

  /// Creates a [DbProductItem] instance from a JSON object.
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

/// Represents the metadata of a product stored in the database.
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
    this.createdAt,
  });

  /// Creates a [DbProductMeta] instance from a JSON object.
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

/// Represents a product.
class Product extends Equatable {
  final int id;
  final String barcode;
  final String name;
  final String description;
  final int priceInCents;
  final String image;
  final DateTime expiredAt;

  /// Returns `true` if the product is expired, `false` otherwise.
  bool get isExpired => DateTime.now().isAfter(expiredAt);

  const Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.description,
    required this.priceInCents,
    required this.image,
    required this.expiredAt,
  });

  @override
  List<Object?> get props =>
      [name, barcode, description, priceInCents, image, expiredAt];
}
