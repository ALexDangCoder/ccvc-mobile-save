import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'cell_phat_bieu_widget.dart';

class BieuQuyetWidgetTablet extends StatefulWidget {
  const BieuQuyetWidgetTablet({Key? key}) : super(key: key);

  @override
  _BieuQuyetWidgetTabletState createState() => _BieuQuyetWidgetTabletState();
}

class _BieuQuyetWidgetTabletState extends State<BieuQuyetWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
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
                  child: const TaoBieuQuyetWidget(),
                  isBottomShow: false,
                  funcBtnOk: () {
                    Navigator.pop(context);
                  },
                );
              },
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
                      return Column(
                        children: [
                          CellPhatBieu(
                            infoModel: _list[index],
                            cubit: cubit,
                            index: index,
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
