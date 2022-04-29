import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'icon_with_title_widget.dart';

class ThanhPhanThamGiaWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ThanhPhanThamGiaWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThanhPhanThamGiaWidgetState createState() => _ThanhPhanThamGiaWidgetState();
}

class _ThanhPhanThamGiaWidgetState extends State<ThanhPhanThamGiaWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.thanhPhanThamGia.sink.add(widget.cubit.dataThaGiaDefault);
    widget.cubit.dataThanhPhanThamGia = widget.cubit.dataThaGiaDefault;
  }

  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.thanh_phan_tham_gia,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.ic_addUser,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showBottomSheetCustom(
                context,
                title: S.current.them_thanh_phan_tham_gia,
                child: ThemThanhPhanThamGiaWidget(
                  cubit: widget.cubit,
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.ic_diemDanh,
            title: S.current.diem_danh,
            onPress: () {
              showDiaLog(
                context,
                title: S.current.diem_danh,
                icon: SvgPicture.asset(ImageAssets.icDiemDanh),
                btnLeftTxt: S.current.khong,
                btnRightTxt: S.current.dong_y,
                funcBtnRight: () {
                  if (widget.cubit.selectedIds.isNotEmpty) {
                    widget.cubit.postDiemDanh();
                  }
                },
                textContent: S.current.conten_diem_danh,
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<List<CanBoModel>>(
            stream: widget.cubit.thanhPhanThamGia,
            builder: (context, snapshot) {
              final list = snapshot.data ?? [];
              if (list.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return CellThanhPhanThamGia(
                      cubit: widget.cubit,
                      infoModel: list[index],
                      ontap: () {
                        widget.cubit.postHuyDiemDanh(list[index].id ?? '');
                      },
                    );
                  },
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: NodataWidget(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
