import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/thanh_phan_tham_gia_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/tao_bieu_quyet_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cell_bieu_quyet_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class BieuQuyetWidgetTablet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const BieuQuyetWidgetTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _BieuQuyetWidgetTabletState createState() => _BieuQuyetWidgetTabletState();
}

class _BieuQuyetWidgetTabletState extends State<BieuQuyetWidgetTablet> {
  @override
  void initState() {
    super.initState();
    if (!isMobile()) {
      widget.cubit.callAPiBieuQuyet();
      widget.cubit.callApiThanhPhanThamGia();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.cubit.isBtnMoiNguoiThamGia())
              IconWithTiltleWidget(
                icon: ImageAssets.icBieuQuyet,
                title: S.current.them_bieu_quyet,
                onPress: () {
                  showDiaLogTablet(
                    context,
                    title: S.current.tao_bieu_quyet,
                    child: TaoBieuQuyetTabletWidget(
                      id: widget.cubit.idCuocHop,
                      cubit: widget.cubit,
                    ),
                    isBottomShow: false,
                    funcBtnOk: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            StreamBuilder<List<DanhSachBietQuyetModel>>(
              stream: widget.cubit.streamBieuQuyet,
              builder: (context, snapshot) {
                final _list = snapshot.data ?? [];
                if (_list.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CellBieuQuyetTablet(
                            infoModel: _list[index],
                            cubit: widget.cubit,
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const NodataWidget(
                    height: 50.0,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
