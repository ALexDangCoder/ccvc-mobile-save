import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/tao_bieu_quyet_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cell_bieu_quyet.dart';
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                ).then((value) {
                  if (value == true) {
                    widget.cubit.callAPiBieuQuyet();
                  } else if (value == null) {
                    return;
                  }
                });
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
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CellBieuQuyet(
                            infoModel: _list[index],
                            cubit: widget.cubit,
                          ),
                        ],
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
      ),
    );
  }
}
