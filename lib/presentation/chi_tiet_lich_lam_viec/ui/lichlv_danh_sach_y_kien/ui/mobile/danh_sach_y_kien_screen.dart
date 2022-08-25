import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/lichlv_danh_sach_y_kien/ui/mobile/widgets/item_y_kiem.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class DanhSachYKienScreen extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;

  const DanhSachYKienScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _DanhSachYKienScreenState createState() => _DanhSachYKienScreenState();
}

class _DanhSachYKienScreenState extends State<DanhSachYKienScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: StreamBuilder<List<YKienModel>>(
          stream: widget.cubit.listYKien,
          builder: (context, snapshot) {
            final listData = snapshot.data ?? [];
            if (listData.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  return ItemYKien(
                    yKienModel: listData[index],
                  );
                },
              );
            } else {
              return const NodataWidget(
                height: 50.0,
              );
            }
          },
        ),
      ),
    );
  }
}
