import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/xem_luong_xu_ly/xem_luong_xu_ly_nhiem_vu.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class LichSuPhanXuLyWidget extends StatelessWidget {
  final List<LichSuPhanXuLyNhiemVuModel> dataModel;
  final ChiTietNVCubit cubit;
  final String idNhiemVu;

  const LichSuPhanXuLyWidget(
      {Key? key, required this.dataModel, required this.cubit, required this.idNhiemVu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataModel.isNotEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 30,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => XemLuongXuLyNhiemVu(
                      id: idNhiemVu,
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                height: 40,
                decoration: BoxDecoration(
                  color: colorDBDFEF,
                  border: Border.all(
                    color: colorDBDFEF.withOpacity(0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.current.xem_luong_xu_ly,
                    style: TextStyle(
                      color: color3D5586,
                      fontSize: 16.0.textScale(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: dataModel
                  .map(
                    (e) => WidgetInExpand(
                      row: e.listLSPXL(),
                      cubit: cubit,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: NodataWidget(),
      );
    }
  }
}
