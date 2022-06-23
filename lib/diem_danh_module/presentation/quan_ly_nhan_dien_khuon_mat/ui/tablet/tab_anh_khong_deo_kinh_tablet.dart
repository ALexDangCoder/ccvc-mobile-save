import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_image.dart';
import 'package:flutter/material.dart';

class TabAnhKhongDeoKinhTablet extends StatefulWidget {
  final DiemDanhCubit cubit;

  const TabAnhKhongDeoKinhTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<TabAnhKhongDeoKinhTablet> createState() =>
      _TabAnhKhongDeoKinhTabletState();
}

class _TabAnhKhongDeoKinhTabletState extends State<TabAnhKhongDeoKinhTablet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 28,
        mainAxisSpacing: 28,
        childAspectRatio: 1.1,
        children: widget.cubit.listDataKhongDeoKinh
            .map(
              (e) => ItemImageWidget(
                image: e.image,
                title: e.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
