import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    required Color color,
    required Function() onTap,
    super.duration = const Duration(seconds: 2),
  }) : super(
          backgroundColor: color,
          content: SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 30,
                  child: GestureDetector(
                    onTap: () {
                      onTap();
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
}
