import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    this.currentIndex,
    required this.path,
    this.color,
    this.width,
    this.height,
  });

  final int? currentIndex;
  final Color? color;
  final String path;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      height: height,
      width: width,
    );
  }
}
