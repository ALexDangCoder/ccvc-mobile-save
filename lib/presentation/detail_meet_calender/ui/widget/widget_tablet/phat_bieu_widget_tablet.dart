import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:flutter/material.dart';
import '../dang_ky_phat_bieu_widget.dart';
import '../icon_tiltle_widget.dart';
import '../state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/state_phat_bieu_widget.dart';

class PhatBieuWidgetTablet extends StatefulWidget {
  const PhatBieuWidgetTablet({Key? key}) : super(key: key);

  @override
  _PhatBieuWidgetTabletState createState() => _PhatBieuWidgetTabletState();
}

class _PhatBieuWidgetTabletState extends State<PhatBieuWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                IconWithTiltleWidget(
                  icon: ImageAssets.icVoice2,
                  title: S.current.dang_ky_phat_bieu,
                  onPress: () {
                    showDiaLogTablet(
                      context,
                      title: S.current.dang_ky_phat_bieu,
                      child: const DangKyPhatBieuWidget(),
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
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(S.current.khong_co_du_lieu),
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          StatePhatBieuWidget(cubit: cubit),
        ],
      ),
    );
  }
}
