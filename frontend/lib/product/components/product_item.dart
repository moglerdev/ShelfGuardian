import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final void Function(bool) onSelectChanged;
  final void Function() onTap;
  final bool isSelected;

  const ProductItem(
      {super.key,
      required this.product,
      required this.onSelectChanged,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return GestureDetector(
      onLongPress: () {
        onSelectChanged(!isSelected);
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
            Checkbox(
                value: isSelected,
                onChanged: (selected) {
                  onSelectChanged(!isSelected);
                })
          ])),
    );
  }
}
