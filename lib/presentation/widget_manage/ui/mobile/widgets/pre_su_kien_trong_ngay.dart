import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreSuKienTrongNgay extends StatelessWidget {
  final String sourceImg;

  const PreSuKienTrongNgay({Key? key, required this.sourceImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(sourceImg),
      ],
    );
  }
}
