import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import '../icon_tiltle_widget.dart';
import '../them_bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/them_bieu_quyet_widget.dart';

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
              icon: ImageAssets.icVectorA,
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
            StreamBuilder<PhatBieuModel>(
              initialData: cubit.phatBieu,
              // stream: cubit.detailDocumentGuiNhan,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderItemCalender),
                          color: borderItemCalender.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Column(
                          children: snapshot.data!.toListRowPhatBieu().map(
                            (row) {
                              return DetailDocumentRow(
                                row: row,
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  );
                } else {
                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 200,
                      child: NodataWidget(),
                    ),
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
