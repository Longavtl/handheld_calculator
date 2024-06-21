import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatefulWidget {
  const CustomDropDownWidget({
    super.key,
    this.list,
    this.onValueChanged,
    this.itemBuilder,
    this.selectedValue,
    this.hintText,
  });

  final List<T>? list;
  final void Function(T?)? onValueChanged;
  final String Function(T)? itemBuilder;
  final T? selectedValue;
  final String? hintText;

  @override
  State<CustomDropDownWidget<T>> createState() => _CustomDropDownWidgetState<T>();
}

class _CustomDropDownWidgetState<T> extends State<CustomDropDownWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Text(
            widget.hintText ?? 'Chọn',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: _addDividersAfterItems(widget.list!),
          value: widget.selectedValue,
          onChanged: widget.onValueChanged,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            width: 140,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          iconStyleData: const IconStyleData(
            openMenuIcon: Icon(Icons.keyboard_arrow_up, size: 16),
            icon: Icon(Icons.keyboard_arrow_down_sharp, size: 16),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _addDividersAfterItems(List<T> items) {
    final List<DropdownMenuItem<T>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      final T item = items[i];
      menuItems.add(
        DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.itemBuilder!(item) ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }
    return menuItems;
  }
}
