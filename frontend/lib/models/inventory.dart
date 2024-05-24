import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';

@immutable
class InventoryItem {
  final String name;
  final DateTime expire;

  get isExpired => expire.isBefore(DateTime.now());
  get fromNow => expire.toMoment().fromNow();

  const InventoryItem({required this.name, required this.expire});
}

@immutable
class InventoryItemWithIcon extends InventoryItem {
  final FaIcon icon;

  const InventoryItemWithIcon(
      {required super.name, required super.expire, required this.icon});
}

@immutable
class InventoryItemWithImage extends InventoryItem {
  final String imageUrl;

  const InventoryItemWithImage(
      {required super.name, required super.expire, required this.imageUrl});
}
