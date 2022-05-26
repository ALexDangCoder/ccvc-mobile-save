import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrePAKNDonVi extends StatelessWidget {
  final String sourceImg;

  const PrePAKNDonVi({Key? key, required this.sourceImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(sourceImg),
      ],
    );
  }
}
