import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/models/product_model.dart';

class ProductView extends StatelessWidget {
  final Product product;
  final void Function(bool?) onSelected;
  final void Function() onTap;
  final bool isSelected;

  const ProductView(
      {super.key,
      required this.product,
      required this.onSelected,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return GestureDetector(
      onLongPress: () {
        onSelected(!isSelected);
      },
      onTap: () {
        onTap();
      },
      child: Container(
          // height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: product.isExpired
                ? ShelfGuardianColors.secondary
                : ShelfGuardianColors.primary,
          ),
          padding: const EdgeInsets.all(10),
          // color: item.isExpired ? Color(0xFFAD0392) : Color(0xFF5603AD),
          child: Row(children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const FaIcon(
                FontAwesomeIcons.cheese,
                color: ShelfGuardianColors.icon,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: ShelfGuardianTextStyles.header1,
                ),
                Text(
                  product.expiredAt.toMoment().fromNow(),
                  style: ShelfGuardianTextStyles.body1,
                ),
              ],
            )),
            Checkbox(value: isSelected, onChanged: onSelected)
          ])),
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final List<Product> selectedProducts;
  final void Function(Product, bool?) onSelected;
  final ScrollController scrollController;

  const ProductListView(
      {super.key,
      required this.products,
      required this.onSelected,
      required this.selectedProducts,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
            controller: scrollController,
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              if (index == products.length) {
                return const SizedBox(height: 100);
              }
              final product = products[index];
              final isSelected = selectedProducts.contains(product);
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ProductView(
                      product: product,
                      isSelected: isSelected,
                      onTap: () {
                        if (selectedProducts.isNotEmpty) {
                          onSelected(product, !isSelected);
                          return;
                        }
                      },
                      onSelected: (selected) {
                        onSelected(product, selected);
                      }));
            }));
  }
}
