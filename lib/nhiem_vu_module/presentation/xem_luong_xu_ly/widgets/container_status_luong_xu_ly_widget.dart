import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';

class ContainerStatusLuongXuLyWidget extends StatelessWidget {
  final Widget child;
  final Color colorBorder;
  const ContainerStatusLuongXuLyWidget(
      {Key? key, required this.child, this.colorBorder = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     constraints: const BoxConstraints(
       maxWidth: 160
     ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: colorDBDFEF,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: double.infinity,
            color: colorBorder,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 10),
            child: child,
          )
        ],
      ),
    );
  }
}
