import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
class BoxStatusVanBan extends StatelessWidget {
  final Color color;
  final int value;
  final String  statusName;
  final Function() onTap;
  const BoxStatusVanBan({Key? key,required this.color,
   this.value=0,required this.onTap,required this.statusName,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(
            Radius.circular(6),
          ),
          color: radioUnfocusColor.withOpacity(0.1),
          border: Border.all(color: radioUnfocusColor),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  value.toString(),
                  style:  titleText(
                    fontSize: 28,
                    color: color,
                  ),),
              ),
               const SizedBox(
                 height: 4,
               ),
               FittedBox(
                 child: Text(
                  statusName,
                   style: textNormal(
                     color,14,
                   ),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}


