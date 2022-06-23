import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_image.dart';
import 'package:flutter/material.dart';

class TabAnhDeoKinh extends StatefulWidget {
  final DiemDanhCubit cubit;

  const TabAnhDeoKinh({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TabAnhDeoKinh> createState() => _TabAnhDeoKinhState();
}

class _TabAnhDeoKinhState extends State<TabAnhDeoKinh> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.cubit.listDataDeoKinh
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
