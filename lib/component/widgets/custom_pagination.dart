
import 'package:flutter/material.dart';

import '../../config/theme/skins/color_skin.dart';

class FPaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  FPaginationControls({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons() {
      List<Widget> buttons = [];
      int startPage = currentPage - 1;
      if (startPage < 1) startPage = 1;
      int endPage = startPage + 2;
      if (endPage > totalPages) {
        endPage = totalPages;
        startPage = endPage - 2;
        if (startPage < 1) startPage = 1;
      }

      for (int i = startPage; i <= endPage; i++) {
        buttons.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GestureDetector(
              onTap: () {
                onPageChanged(i);
              },
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: i == currentPage ? FColorSkin.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color:i == currentPage ? Colors.transparent : Colors.black38,width: 1 )
                ),
                child: Text(
                  '$i',
                  style: TextStyle(color: i == currentPage ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        );
      }
      return buttons;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GestureDetector(
            onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                // color: currentPage > 1 ? FColorSkin.primary : Colors.grey,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black38,width: 1)
              ),
              child: const Icon(Icons.chevron_left),
            ),
          ),
        ),
        ...pageButtons(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GestureDetector(
            onTap: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black38,width: 1)
              ),
              child: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}
