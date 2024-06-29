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
  final int id;
  final String barcode;
  final String name;
  final String description;
  final int priceInCents;
  final String image;
  final DateTime expiredAt;

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
