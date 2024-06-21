import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../base_component.dart';

class FIcon extends StatelessWidget {
  const FIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
    this.colorFilter,
  })  : primaryColor = null,
        secondaryColor = null,
        super(key: key);

  const FIcon.twoTone({
    Key? key,
    required this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.size,
    this.colorFilter,
  })  : color = null,
        super(key: key);

  /// string icon thông qua static field của class FIcons
  final String icon;

  /// tone màu icon thứ nhất [twotone]
  final Color? primaryColor;

  /// tone màu icon thứ 2 [twotone]
  final Color? secondaryColor;

  /// màu icon mặc định là màu grey10
  final Color? color;

  final ColorFilter? colorFilter;

  /// size icon, mặc định là 24
  final double? size;

  @override
  Widget build(BuildContext context) {
    final _defaultIconStyle = FDefaultIconStyle.of(context);

    final _effectiveColor = color ?? _defaultIconStyle?.color ?? FColors.grey10;
    final _effectiveSize = size ?? _defaultIconStyle?.size ?? 24;

    return SvgPicture.asset(icon,
        height: _effectiveSize,
        width: _effectiveSize,
        colorFilter: ColorFilter.mode(_effectiveColor, BlendMode.srcIn)
    );
  }
}
