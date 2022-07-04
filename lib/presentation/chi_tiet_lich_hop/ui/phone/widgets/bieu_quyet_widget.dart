import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/bieu_quyet_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/cell_bieu_quyet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class BieuQuyetWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const BieuQuyetWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _BieuQuyetWidgetState createState() => _BieuQuyetWidgetState();
}

class _BieuQuyetWidgetState extends State<BieuQuyetWidget> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value) {
            widget.cubit.callAPiBieuQuyet();
          }
        },
        title: S.current.bieu_quyet,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IconWithTiltleWidget(
                icon: ImageAssets.icBieuQuyet,
                title: S.current.them_bieu_quyet,
                onPress: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.tao_bieu_quyet,
                    child: TaoBieuQuyetWidget(
                      id: widget.cubit.idCuocHop,
                      cubit: widget.cubit,
                    ),
                  ).then((value) {
                    if (value == null) {
                      return;
                    }
                    if (value) {
                      widget.cubit.callApi(widget.cubit.idCuocHop);
                    }
                  });
                },
              ),
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
                      return CellBieuQuyet(
                        infoModel: _list[index],
                        cubit: widget.cubit,
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
      tabletScreen: BieuQuyetWidgetTablet(
        cubit: widget.cubit,
      ),
    );
  }
}
