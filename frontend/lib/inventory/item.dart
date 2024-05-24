import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelf_guardian/inventory/checkbox.dart';
import 'package:shelf_guardian/models/inventory.dart';

class InventoryItemWidget extends StatelessWidget {
  final InventoryItem item;
  final CheckBoxWidget checkBoxWidget;

  const InventoryItemWidget(
      {super.key, required this.item, required this.checkBoxWidget});

  @override
  Widget build(BuildContext context) {
    // when still good 5603AD
    // when expired AD0392
    // Text Color FFFFFF

    return Container(
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            item.isExpired ? const Color(0xFFAD0392) : const Color(0xFF5603AD),
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
              item.name,
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              item.fromNow,
              style: const TextStyle(color: Color(0xFFFFFFFF)),
            ),
          ],
        )),
        Column(
          children: [
            checkBoxWidget,
          ],
        )
      ]),
    );
  }
}
