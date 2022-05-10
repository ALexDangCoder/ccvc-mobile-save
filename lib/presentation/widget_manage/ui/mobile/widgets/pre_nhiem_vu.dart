import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PreNhiemVu extends StatelessWidget {
  final String sourceImg;
  const PreNhiemVu({Key? key, required this.sourceImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(sourceImg),
      ],
    );
  }
}
