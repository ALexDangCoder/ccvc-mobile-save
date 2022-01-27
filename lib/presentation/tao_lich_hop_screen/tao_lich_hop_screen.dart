import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/material.dart';

class TaoLichHopScreen extends StatefulWidget {
  const TaoLichHopScreen({Key? key}) : super(key: key);

  @override
  _TaoLichHopScreenState createState() => _TaoLichHopScreenState();
}

class _TaoLichHopScreenState extends State<TaoLichHopScreen> {
  List<DonViModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  ThanhPhanThamGiaWidget(
                    isPhuongThucNhan: true,
                    onChange: (value) {
                      list = value;
                    },
                    phuongThucNhan: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
