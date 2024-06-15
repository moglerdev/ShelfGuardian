import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/controller/product_controller.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shelf Guardian'),
        ),
        body: BlocBuilder<ProductControllerCubit, ProductListState>(
            builder: (context, state) {
          if (state is ProductListLoaded) {
            final products = state.products;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    onTap: () {
                      context
                          .read<ProductControllerCubit>()
                          .selectProduct(product);
                    },
                  );
                });
          }
          if (state is ProductListSelected) {
            final products = state.products;
            final selectedProducts = state.selectedProducts;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    onTap: () {
                      context
                          .read<ProductControllerCubit>()
                          .selectProduct(product);
                    },
                    trailing: selectedProducts.contains(product)
                        ? const Icon(Icons.check)
                        : null,
                  );
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
