import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:flutter/material.dart';

class KetQuaXuLyScreen extends StatefulWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const KetQuaXuLyScreen(
      {Key? key,required this.cubit,})
      : super(key: key);

  @override
  _KetQuaXuLyScreenState createState() => _KetQuaXuLyScreenState();
}

class _KetQuaXuLyScreenState extends State<KetQuaXuLyScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder <List<List<ListRowYKND>>>(
      stream: widget.cubit.ketQuaXuLyRowData,
      builder: (context, snapshot){
        final data= snapshot.data??[];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, indexItem){
            return  Container(
              padding: const EdgeInsets.only(left: 16, top: 16),
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: bgDropDown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: bgDropDown),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data[indexItem].length,
                itemBuilder: (context, index) {
                  return ListItemRow(
                    title: data[indexItem][index].title,
                    content: data[indexItem][index].content,
                  );
                },
              ),
            );
          } ,
        );
      },

    );
  }
}
