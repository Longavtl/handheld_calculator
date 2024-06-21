
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../Component/skins/color_skin.dart';
import '../../Component/style/typo_skin.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  LoadingOverlay();

  static void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => ColoredBox(
          color: const Color(0x80000000).withOpacity(0.6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 252, 252)
                        .withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
              ),
              const Center(
                child: CupertinoActivityIndicator(
                    radius: 20.0, color: FColorSkin.teraChartNam),
              ),
            ],
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
      // Future.delayed(const Duration(seconds: 3), hide);
    }
  }

  static void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}

class CustomDialog {
  /*static const String pendingIconPath = "assets/icons/infor_pending_ic.svg";
  static const String alertIconPath = "assets/icons/alert_infor_ic.svg";*/

  static void showCustomDialog(BuildContext context, String title,
      String content, /*String iconPath,*/ String buttonTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            width: MediaQuery.of(context).size.width * 3 / 4,
            constraints: const BoxConstraints(maxHeight: 500),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /*SvgPicture.asset(iconPath),*/
                const SizedBox(height: 16.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    //context.router.maybePop();
                    Navigator.maybePop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: FColorSkin.teraChartNam,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Center(
                      child: Text(
                        buttonTitle,
                        style: FTypoSkin.title5
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

