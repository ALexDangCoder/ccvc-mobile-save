import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:flutter/material.dart';

class ThongTinXuLyPhanAnh extends StatefulWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const ThongTinXuLyPhanAnh({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThongTinXuLyPhanAnhState createState() => _ThongTinXuLyPhanAnhState();
}

class _ThongTinXuLyPhanAnhState extends State<ThongTinXuLyPhanAnh> {
  @override
  Widget build(BuildContext context) {
    final data = widget.cubit.getMapDataThongTinXuLy();
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 16),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: bgDropDown),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ItemRow(
            title: data[index].title,
            content: data[index].content,
          );
        },
      ),
    );
  }
}
