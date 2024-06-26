import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/product/components/product_list.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/components/input_field.dart';

class ProductPageView extends StatelessWidget {
  const ProductPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductControllerCubit, ProductListState>(
        builder: (context, state) {
      if (state is ProductListFilled) {
        final products = state.products;
        return ProductList(
            products: products,
            onSelectChanged: (product, selected) {
              context.read<ProductControllerCubit>().selectProduct(product);
            },
            selectedProducts: const []);
      } else if (state is ProductListSelected) {
        final products = state.products;
        final selectedProducts = state.selectedProducts;
        return ProductList(
            products: products,
            onSelectChanged: (product, selected) {
              if (selected) {
                context.read<ProductControllerCubit>().selectProduct(product);
              } else {
                context.read<ProductControllerCubit>().deselectProduct(product);
              }
            },
            selectedProducts: selectedProducts);
      } else if (state is ProductSearchedList) {
        final products = state.products;
        final search = state.search;
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InputField(
              name: "Suche",
              value: search,
              icon: FontAwesomeIcons.squareXmark,
              onIconTap: () {}),
          Expanded(
              child: ProductList(
                  products: products,
                  onSelectChanged: (product, selected) {
                    context
                        .read<ProductControllerCubit>()
                        .selectProduct(product);
                  },
                  selectedProducts: state.products))
        ]);
      } else if (state is ProductListEmpty) {
        return const Center(
          child: Text('No products found'),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
