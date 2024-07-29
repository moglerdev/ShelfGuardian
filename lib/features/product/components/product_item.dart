import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:shelf_guardian/common/theme.dart';
import 'package:shelf_guardian/features/product/bloc/product_controller.dart';
import 'package:shelf_guardian/features/product/bloc/product_state.dart';
import 'package:shelf_guardian/features/product/models/product_model.dart';
import 'package:shelf_guardian/components/checkbox.dart';

/// A widget that represents a single product item.
class ProductItem extends StatelessWidget {
  final Product product;
  final void Function(bool) onSelectChanged;
  final void Function() onTap;
  final bool isSelected;

  /// Constructs a [ProductItem].
  ///
  /// The [product] parameter is required and represents the product to display.
  /// The [onSelectChanged] parameter is required and is called when the selection state changes.
  /// The [onTap] parameter is required and is called when the item is tapped.
  /// The [isSelected] parameter is required and indicates whether the item is selected.
  const ProductItem({
    super.key,
    required this.product,
    required this.onSelectChanged,
    required this.isSelected,
    required this.onTap,
  });

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: product.isExpired
              ? ShelfGuardianColors.secondary
              : ShelfGuardianColors.primary,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
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
              ),
            ),
            if (context.read<ProductControllerCubit>().state
                is! ProductSearchedList)
              SGCheckBox(
                onSelectChanged: (selected) {
                  onSelectChanged(selected);
                },
                isSelected: isSelected,
              ),
          ],
        ),
      ),
    );
  }
}
