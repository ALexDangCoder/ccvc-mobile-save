import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:flutter/material.dart';
class NguoiGanRowWidget extends StatelessWidget {
  final String inforNguoiGan;
  final Function(String infoCanBo) ontapItem;
  const NguoiGanRowWidget({Key? key, required this.inforNguoiGan, required this.ontapItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(top: 16,left: 16),
        margin: const EdgeInsets.only(top: 16,left: 16),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(inforNguoiGan, style: textNormalCustom(
              color:infoColor,
              fontWeight: FontWeight.w400,
            ),),
            const SizedBox(height: 16,),
            Divider(color:borderColor.withOpacity(0.5),height: 1,),
          ],
        ),
      ),
      onTap: (){
        ontapItem(
            inforNguoiGan,
        );
        },
    );
  }
}

