import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:flutter/material.dart';
class NguoiGanRowWidget extends StatelessWidget {
  final NguoiGanModel nguoiGan;
  final Function(String infoCanBo) ontapItem;
  const NguoiGanRowWidget({Key? key, required this.nguoiGan, required this.ontapItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text('${nguoiGan.text1}-'),
                Text('${nguoiGan.text2}-'),
                Text(nguoiGan.text3),
              ],
            ),
            const SizedBox(height: 16,),
            const Divider(color: Colors.red,height: 3,),
          ],
        ),

      ),
      onTap: (){
        ontapItem(
            nguoiGan.text1,
        );
        },
    );
  }
}

