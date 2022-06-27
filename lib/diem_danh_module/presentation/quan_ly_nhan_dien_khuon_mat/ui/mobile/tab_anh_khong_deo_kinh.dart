import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_image.dart';
import 'package:flutter/material.dart';

class TabAnhKhongDeoKinh extends StatefulWidget {
  final DiemDanhCubit cubit;

  const TabAnhKhongDeoKinh({Key? key, required this.cubit}) : super(key: key);

  @override
  State<TabAnhKhongDeoKinh> createState() => _TabAnhKhongDeoKinhState();
}

class _TabAnhKhongDeoKinhState extends State<TabAnhKhongDeoKinh> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.cubit.listDataKhongDeoKinh
            .map(
              (e) => ItemImageWidget(
                image: e.image,
                title: e.title, cubit: widget.cubit,
              ),
            )
            .toList(),
      ),
    );
  }
}
