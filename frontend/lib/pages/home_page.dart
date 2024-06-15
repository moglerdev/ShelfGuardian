import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_guardian/views/product_view.dart';

// final iconStyle = ButtonStyle(
//   shape: WidgetStatePropertyAll(
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
//   backgroundColor: const WidgetStatePropertyAll(Color(0xFF8367C7)),
//   iconColor: const WidgetStatePropertyAll(Color(0xFFFFFFFF)),
// );

// class CustomIconBtn extends StatelessWidget {
//   final IconData icon;
//   final void Function() onPressed;
//   final double size;

//   const CustomIconBtn(
//       {super.key, required this.icon, required this.onPressed, this.size = 35});

//   @override
//   Widget build(BuildContext context) {
//     var style = iconStyle.copyWith(
//         fixedSize: WidgetStateProperty.all(Size(size + 20, size + 20)));
//     return IconButton(
//       iconSize: size,
//       style: style,
//       icon: FaIcon(
//         icon,
//         shadows: const [
//           Shadow(
//             color: Color.fromARGB(110, 0, 0, 0),
//             offset: Offset(0, 2),
//             blurRadius: 10,
//           )
//         ],
//       ),
//       onPressed: onPressed,
//     );
//   }
// }

// class HomePageAction extends StatelessWidget {
//   final ScrollController scrollController;

//   const HomePageAction({super.key, required this.scrollController});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
//       List<Widget> leftBtns = [
//         CustomIconBtn(
//             icon: FontAwesomeIcons.gear,
//             onPressed: () {
//               context.go("/setting");
//             }),
//         const SizedBox(width: 10),
//         CustomIconBtn(
//           icon: FontAwesomeIcons.filter,
//           onPressed: () {
//             // TODO Implement filter page
//             print("TODO: Implement filter page");
//           },
//         ),
//         const SizedBox(width: 10),
//       ];
//       Widget mainBtn;
//       List<Widget> rightBtns = [const SizedBox(width: 10)];
//       if (state is ProductSelectedState) {
//         rightBtns.add(CustomIconBtn(
//           icon: FontAwesomeIcons.rectangleXmark,
//           onPressed: () {
//             context.read<ProductBloc>().add(UnselectAllProductsEvent());
//           },
//         ));
//         mainBtn = CustomIconBtn(
//           size: 50,
//           icon: FontAwesomeIcons.trash,
//           onPressed: () {
//             context.read<ProductBloc>().add(const RemoveSelectedProductEvent());
//           },
//         );
//       } else {
//         rightBtns.add(CustomIconBtn(
//           icon: FontAwesomeIcons.checkToSlot,
//           onPressed: () {
//             context.read<ProductBloc>().add(SelectAllProductsEvent());
//           },
//         ));
//         mainBtn = CustomIconBtn(
//           size: 50,
//           icon: FontAwesomeIcons.plus,
//           onPressed: () {
//             context.go("/scanner");
//           },
//         );
//       }
//       rightBtns.add(const SizedBox(width: 10));
//       rightBtns.add(CustomIconBtn(
//         icon: FontAwesomeIcons.magnifyingGlass,
//         onPressed: () {
//           // TODO Implement search page
//           print("TODO: Implement search page");
//         },
//       ));
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [...leftBtns, mainBtn, ...rightBtns],
//       );
//     });
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Home Page");
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Shelf Guardian'),
    //     ),
    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //     floatingActionButton:
    //         HomePageAction(scrollController: _scrollController),
    //     body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
    //       if (state is ProductInitialState) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (state is ProductLoadedState) {
    //         final products = state.products;
    //         return ProductListView(
    //             scrollController: _scrollController,
    //             products: products,
    //             onSelected: (product, selected) {
    //               context.read<ProductBloc>().add(SelectProductEvent(product));
    //             },
    //             selectedProducts: const []);
    //       }
    //       if (state is ProductSelectedState) {
    //         final products = state.products;
    //         return ProductListView(
    //             scrollController: _scrollController,
    //             products: products,
    //             onSelected: (product, selected) {
    //               context.read<ProductBloc>().add(SelectProductEvent(product));
    //             },
    //             selectedProducts: state.selectedProducts);
    //       }
    //       return const Center(
    //         child: Text('Unknown state'),
    //       );
    //     }));
  }
}
