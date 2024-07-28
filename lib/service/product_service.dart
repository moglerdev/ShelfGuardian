import 'dart:async';

import 'package:shelf_guardian/features/filter/services/filter_service.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class ProductService {
  Future<List<Product>> getProducts();
  Future<bool> addProduct(Product product);
  Future<bool> removeProduct(Product product);
  Future<bool> removeProducts(List<Product> products);
  Future<Product?> getProduct(int id);
  Future<Product?> getProductByBarcode(String barcode);
  Future<Product?> saveProduct(Product product);
  Future<int> getSummaryValue();
  Future<int> getCount();

  static ProductService create() {
    return ProductServiceSupabase();
  }
}

class ProductServiceSupabase implements ProductService {
  final client = Api.client;
  final channel = Api.client.channel("products_items");
  final filter = FilterService.create();

  @override
  Future<List<Product>> getProducts() async {
    final f = await filter.load();
    final from = f.dateFrom;
    final to = f.dateTo;

    var select = client.from("products_items").select(
        "id, meta_id, price_in_cents, expired_at, created_at, products_meta(id, barcode, name, description, created_at)");

    select = from != null ? select.gte("expired_at", from) : select;
    select = to != null ? select.lte("expired_at", to) : select;

    final result = await select.order(f.filterOption?.name ?? "expired_at",
        ascending: f.isAscending != null ? f.isAscending! : true);

    if (result.isEmpty) {
      return [];
    } else {
      return result.map((e) {
        var meta =
            DbProductMeta.fromJson(e["products_meta"] as Map<String, dynamic>);
        var item = DbProductItem.fromJson(e);
        return Product(
            id: item.id ?? 0,
            barcode: meta.barcode ?? "",
            name: meta.name ?? "Unknown",
            description: meta.description ?? "Unknown",
            priceInCents: item.priceInCents ?? 0,
            image: "https://via.placeholder.com/150",
            expiredAt: item.expiredAt ?? DateTime.now());
      }).toList();
    }
  }

  @override
  Future<bool> addProduct(Product product) async {
    var result = await client.from("products_items").upsert({
      "id": product.id,
      "price_in_cents": product.priceInCents,
      "expired_at": product.expiredAt
    });
    return result.error == null;
  }

  @override
  Future<bool> removeProduct(Product product) async {
    var result =
        await client.from("products_items").delete().eq("id", product.id);
    return result.error == null;
  }

  @override
  Future<bool> removeProducts(List<Product> products) async {
    var result = await client
        .from("products_items")
        .delete()
        .inFilter("id", products.map((e) => e.id).toList());
    return result == null;
  }

  @override
  Future<int> getSummaryValue() async {
    var result = await client.from("products_items").select("price_in_cents");
    if (result.isEmpty) {
      return 0;
    }
    return result
        .map((e) => e["price_in_cents"] as int)
        .reduce((value, element) {
      return value + element;
    });
  }

  @override
  Future<int> getCount() async {
    return await client.from("products_items").count();
  }

  @override
  Future<Product?> getProduct(int id) async {
    var result = await client
        .from("products_items")
        .select(
            "id, price_in_cents, expired_at, created_at, products_meta(id, barcode, name, description, created_at)")
        .eq("id", id);
    if (result.isEmpty) {
      return null;
    } else {
      var meta = DbProductMeta.fromJson(
          result[0]["products_meta"] as Map<String, dynamic>);
      var item = DbProductItem.fromJson(result[0]);
      return Product(
          id: item.id ?? 0,
          barcode: meta.barcode ?? "",
          name: meta.name ?? "Unknown",
          description: meta.description ?? "Unknown",
          priceInCents: item.priceInCents ?? 0,
          image: "https://via.placeholder.com/150",
          expiredAt: item.expiredAt ?? DateTime.now());
    }
  }

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
    var result = await client
        .from("products_meta")
        .select("id, barcode, name, description, created_at")
        .eq("barcode", barcode);
    if (result.isEmpty) {
      return null;
    } else {
      var meta = DbProductMeta.fromJson(result[0]);
      return Product(
          id: meta.id ?? 0,
          barcode: meta.barcode ?? "",
          name: meta.name ?? "Unknown",
          description: meta.description ?? "Unknown",
          priceInCents: 0,
          image: "https://via.placeholder.com/150",
          expiredAt: DateTime.now());
    }
  }

  @override
  Future<Product?> saveProduct(Product product) async {
    var meta = await saveProductMeta(product);
    if (meta == null) {
      return null;
    }
    var item = await saveProductItem(product, meta);
    if (item == null) {
      return null;
    }
    return Product(
        id: item.id ?? product.id,
        barcode: meta.barcode ?? product.barcode,
        name: meta.name ?? product.name,
        description: meta.description ?? product.description,
        priceInCents: item.priceInCents ?? product.priceInCents,
        image: "https://via.placeholder.com/150",
        expiredAt: item.expiredAt ?? product.expiredAt);
  }

  Future<DbProductMeta?> saveProductMeta(Product product) async {
    var exist = await getProductByBarcode(product.barcode);
    if (exist != null) {
      // Update Barcode and Name
      var result = await client.from("products_meta").upsert(
          {"id": exist.id, "barcode": product.barcode, "name": product.name});
      if (result != null) {
        return null;
      }
      return DbProductMeta(
          id: exist.id,
          barcode: product.barcode,
          name: product.name,
          description: product.description);
    } else {
      // Create new Barcode and Name
      var result = await client
          .from("products_meta")
          .insert({"barcode": product.barcode, "name": product.name}).select();
      if (result.isEmpty) {
        return null;
      }
      return DbProductMeta(
          id: result.first["id"] as int,
          barcode: product.barcode,
          name: product.name,
          description: product.description);
    }
  }

  Future<DbProductItem?> saveProductItem(
      Product product, DbProductMeta meta) async {
    var exist = await getProduct(product.id);
    if (exist != null) {
      // Update Price and ExpiredAt
      var result = await client.from("products_items").upsert({
        "id": exist.id,
        "meta_id": meta.id,
        "price_in_cents": product.priceInCents,
        "expired_at": product.expiredAt.toIso8601String()
      });
      if (result != null) {
        return null;
      }
      return DbProductItem(
          id: exist.id,
          metaId: meta.id,
          priceInCents: product.priceInCents,
          expiredAt: product.expiredAt);
    } else {
      // Create new Price and ExpiredAt
      var result = await client.from("products_items").insert({
        "meta_id": meta.id,
        "price_in_cents": product.priceInCents,
        "expired_at": product.expiredAt.toIso8601String()
      }).select();
      if (result.isEmpty) {
        return null;
      }
      return DbProductItem(
          id: result.first["id"] as int,
          metaId: meta.id,
          priceInCents: product.priceInCents,
          expiredAt: product.expiredAt,
          createdAt: DateTime.now());
    }
  }
}
