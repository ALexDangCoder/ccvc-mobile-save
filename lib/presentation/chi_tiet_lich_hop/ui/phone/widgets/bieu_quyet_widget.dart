import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import '../chi_tiet_lich_hop_screen.dart';

class BieuQuyetWidget extends StatefulWidget {
  final String id;

  const BieuQuyetWidget({Key? key, required this.id}) : super(key: key);

  @override
  _BieuQuyetWidgetState createState() => _BieuQuyetWidgetState();
}

class _BieuQuyetWidgetState extends State<BieuQuyetWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited.of(context).cubit;
    return SelectOnlyWidget(
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
                    id: widget.id,
                  ),
                );
              },
            ),
          ),
          StreamBuilder<List<PhatBieuModel>>(
            stream: cubit.streamBieuQuyet,
            builder: (context, snapshot) {
              final _list = snapshot.data ?? [];
              if (_list.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return CellPhatBieu(
                      infoModel: _list[index],
                      cubit: cubit,
                      index: index,
                      isthePhatBieu: false,
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
