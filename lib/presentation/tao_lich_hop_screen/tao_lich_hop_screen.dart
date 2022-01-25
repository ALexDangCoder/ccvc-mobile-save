import 'dart:developer';

import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/them_don_vi_widget.dart';
import 'package:flutter/material.dart';

class TaoLichHopScreen extends StatefulWidget {
  const TaoLichHopScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopScreen> {
  List<Node<DonViModel>> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          ThemDonViWidget(
            listSelectNode: list,
            onChange: (value) {

            },
          ),
          Column(
            children: List.generate(
              list.length,
              (index){
                final data = list[index];
                return Row(
                  children: [Text(data.value.name),
                  GestureDetector(
                    onTap: (){
                      data.isCheck.isCheck=false;
                      list.removeAt(index);
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.red,
                    ),
                  )],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
