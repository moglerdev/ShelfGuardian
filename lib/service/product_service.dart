import 'dart:async';

import 'package:shelf_guardian/product/models/product_model.dart';
import 'package:shelf_guardian/supabase.dart';

abstract class ProductService {
  Future<List<Product>> getProducts();
  Future<bool> addProduct(Product product);
  Future<bool> removeProduct(Product product);
  Future<Product?> getProduct(int id);
  Future<Product?> getProductByBarcode(String barcode);

  static ProductService create() {
    return ProductServiceSupabase();
  }
}

class ProductServiceSupabase implements ProductService {
  @override
  Future<List<Product>> getProducts() async {
    // TODO: read filter options from local storage (Service Filter)
    var result = await SBClient.supabaseClient
        .from("products_items")
        .select(
            "id, meta_id, price_in_cents, expired_at, created_at, products_meta(id, barcode, name, description, created_at)")
        .order("expired_at", ascending: true);
    if (result.isEmpty) {
      return [];
    } else {
      return result.map((e) {
        var meta =
            DbProductMeta.fromJson(e["products_meta"] as Map<String, dynamic>);
        var item = DbProductItem.fromJson(e);
        return Product(
            id: item.id ?? 0,
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
    var result = await SBClient.supabaseClient.from("products_items").upsert({
      "meta_id": product.id,
      "price_in_cents": product.priceInCents,
      "expired_at": product.expiredAt
    });
    return result.error == null;
  }

  @override
  Future<bool> removeProduct(Product product) async {
    var result = await SBClient.supabaseClient
        .from("products_items")
        .delete()
        .eq("meta_id", product.id);
    return result.error == null;
  }

  @override
  Future<Product?> getProduct(int id) async {
    var result = await SBClient.supabaseClient
        .from("products_items")
        .select(
            "id, meta_id, price_in_cents, expired_at, created_at, products_meta(id, barcode, name, description, created_at)")
        .eq("meta_id", id);
    if (result.isEmpty) {
      return null;
    } else {
      var meta = DbProductMeta.fromJson(
          result[0]["products_meta"] as Map<String, dynamic>);
      var item = DbProductItem.fromJson(result[0]);
      return Product(
          id: item.id ?? 0,
          name: meta.name ?? "Unknown",
          description: meta.description ?? "Unknown",
          priceInCents: item.priceInCents ?? 0,
          image: "https://via.placeholder.com/150",
          expiredAt: item.expiredAt ?? DateTime.now());
    }
  }

  Future<Product?> getProductByBarcode(String barcode) async {
    var result = await SBClient.supabaseClient
        .from("products_meta")
        .select("id, barcode, name, description, created_at")
        .eq("barcode", barcode);
    if (result.isEmpty) {
      return null;
    } else {
      var meta = DbProductMeta.fromJson(result[0]);
      return Product(
          id: meta.id ?? 0,
          name: meta.name ?? "Unknown",
          description: meta.description ?? "Unknown",
          priceInCents: 0,
          image: "https://via.placeholder.com/150",
          expiredAt: DateTime.now());
    }
  }
}
