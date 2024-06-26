import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/button.dart';
import 'package:shelf_guardian/product/bloc/product_controller.dart';
import 'package:shelf_guardian/product/bloc/product_state.dart';
import 'package:shelf_guardian/common/routes_service.dart';

class ProductActionButton extends StatelessWidget {
  const ProductActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductControllerCubit, ProductListState>(
        builder: (context, state) {
      final controller = context.read<ProductControllerCubit>();
      List<Widget> leftBtns = [
        SGIconButton(
            icon: FontAwesomeIcons.gear,
            onPressed: () {
              context.push(NavigationServiceRoutes.settingsRouteUri);
            }),
        const SizedBox(width: 10),
        SGIconButton(
          icon: FontAwesomeIcons.filter,
          onPressed: () {
            context.push(NavigationServiceRoutes.filterRouteUri);
          },
        ),
        const SizedBox(width: 10),
      ];
      Widget mainBtn;
      List<Widget> rightBtns = [const SizedBox(width: 10)];
      if (state is ProductListSelected) {
        rightBtns.add(SGIconButton(
          icon: FontAwesomeIcons.rectangleXmark,
          onPressed: () {
            controller.deselectAllProducts();
          },
        ));
        mainBtn = SGIconButton(
          size: 50,
          icon: FontAwesomeIcons.trash,
          onPressed: () {
            controller.removeSelectedProducts();
          },
        );
      } else {
        rightBtns.add(SGIconButton(
          icon: FontAwesomeIcons.checkToSlot,
          onPressed: () {
            controller.selectAllProducts();
          },
        ));
        mainBtn = SGIconButton(
          size: 50,
          icon: FontAwesomeIcons.plus,
          onPressed: () {
            context.push(NavigationServiceRoutes.scannerRouteUri);
          },
        );
      }
      rightBtns.add(const SizedBox(width: 10));
      rightBtns.add(SGIconButton(
        icon: FontAwesomeIcons.magnifyingGlass,
        onPressed: () {
          context.read<ProductControllerCubit>().toggleSearchState();
          // TODO Implement search page
          print("TODO: Implement search page");
        },
      ));
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [...leftBtns, mainBtn, ...rightBtns],
      );
    });
  }
}
