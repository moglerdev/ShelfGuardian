import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/components/icon_button.dart';
import 'package:shelf_guardian/features/product/bloc/product_controller.dart';
import 'package:shelf_guardian/features/product/bloc/product_state.dart';
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
          disabled: state is ProductSearchedList,
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
          bool toggleAllowed =
              context.read<ProductControllerCubit>().toggleSearchState();
          if (state is ProductSearchedList) {
            context.read<ProductControllerCubit>().state.disposeListener();
          }
          if (!toggleAllowed) {
            final sm = ScaffoldMessenger.of(context);
            sm.showSnackBar(
              const SnackBar(content: Text('Ich kann gerade nichts suchen!')),
            );
          }
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
