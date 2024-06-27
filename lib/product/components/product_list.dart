import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/product/components/product_item.dart';
import 'package:shelf_guardian/product/models/product_model.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final List<Product> selectedProducts;
  final void Function(Product, bool) onSelectChanged;

  const ProductList({
    super.key,
    required this.products,
    required this.onSelectChanged,
    required this.selectedProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: RefreshIndicator(
          onRefresh: context.read<ProductControllerCubit>().initProducts,
          child: ListView.builder(
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return const SizedBox(height: 100);
                }
                final product = products[index];
                final isSelected = selectedProducts.contains(product);
                return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ProductItem(
                        product: product,
                        isSelected: isSelected,
                        onTap: () {
                          if (selectedProducts.isNotEmpty) {
                            onSelectChanged(product, !isSelected);
                            return;
                          }
                        },
                        onSelectChanged: (selected) {
                          onSelectChanged(product, selected);
                        }));
              }),
        ));
  }
}
