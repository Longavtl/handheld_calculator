import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../config/theme/widgets/icon.dart';
import '../core/routes.dart';

class FDiaLog extends StatelessWidget {
  String? Title;
  String? subTitle;
  String? titleCancel;
  String? titleConfirm;
  VoidCallback? onTapCancel;
  FIcon? iconCancel;
  FIcon? iconConfirm;
  VoidCallback? onTapConfirm;
  Widget? iconMain;

  FDiaLog(
      {this.Title,
      this.subTitle,
      this.titleCancel,
      this.titleConfirm,
      this.onTapConfirm,
      this.onTapCancel,
      this.iconCancel,
      this.iconConfirm,
      this.iconMain});

  void handelBack() {
    Navigator.pop(CoreRoutes.navigatorKey.currentContext!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          /* border: Border.all(width: 0.8),*/
        ),
        height: 220,
        width: 345,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    Title ?? 'Xác nhận',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    highlightColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 72,
                    width: 72,
                    child: iconMain ??
                        Image.asset(
                          'assets/images/ph_warning.png',
                        )),
                const Gap(10),
                Expanded(
                  child: Text(
                    subTitle ?? 'Bạn có chắc chắn muốn đăng xuất không?',
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            const Gap(19),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onTapCancel ?? Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: const Color(0xFFFF4D4F), width: 1.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconCancel ??
                              Image.asset(
                                'assets/icon/icon_wrapper.png',
                                color: const Color(0xFFFF4D4F),
                              ),
                          const Gap(8),
                          Text(
                            titleCancel ?? 'Hủy',
                            style: const TextStyle(
                                color: Color(0xFFFF4D4F),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(28),
                Expanded(
                  child: InkWell(
                      onTap: () => onTapConfirm!(),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFF4D4F),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: const Color(0xFFFF4D4F), width: 1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icon/vuesax_outline_login.png'),
                            const Gap(8),
                            const Text(
                              /*titleConfirm??'Xóa'*/ 'Đăng xuất',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
