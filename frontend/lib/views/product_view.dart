import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/models/product_model.dart';

class ProductView extends StatelessWidget {
  final Product product;
  final Function(bool?) onSelected;
  final bool isSelected;

  const ProductView(
      {super.key,
      required this.product,
      required this.onSelected,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return Container(
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: product.isExpired
            ? const Color(0xFFAD0392)
            : const Color(0xFF5603AD),
      ),
      padding: const EdgeInsets.all(10),
      // color: item.isExpired ? Color(0xFFAD0392) : Color(0xFF5603AD),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const FaIcon(
            FontAwesomeIcons.cheese,
            color: Color(0xFFFFFFFF),
          ),
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              product.isExpired
                  ? 'Expired at ${product.expiredAt}'
                  : 'Expires at ${product.expiredAt}',
              style: const TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ],
        )),
        Checkbox(value: isSelected, onChanged: onSelected)
      ]),
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final List<Product> selectedProducts;
  final Function(Product, bool?) onSelected;
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
                      onSelected: (selected) {
                        onSelected(product, selected);
                      }));
            }));
  }
}
