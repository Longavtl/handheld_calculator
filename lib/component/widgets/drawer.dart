import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'icon.dart';
import 'icon_data.dart';

class FDropdown extends StatefulWidget {
  FDropdown(this.list, {this.title});
  final List<String> list;
  final String? title;
  @override
  State<FDropdown> createState() => _FDropdownState();
}

class _FDropdownState extends State<FDropdown> {

  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (widget.list.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.grey,width: 0.3)
        ),
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              widget.title??'Chọn',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: _addDividersAfterItems(widget.list),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 140,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              customHeights: _getCustomItemsHeights(),
            ),
            iconStyleData:  const IconStyleData(
              openMenuIcon: Icon(Icons.keyboard_arrow_right,size: 16,),
              icon:Icon(Icons.keyboard_arrow_down_sharp,size: 16,)
            ),
          ),
        ),
    );
  }
}