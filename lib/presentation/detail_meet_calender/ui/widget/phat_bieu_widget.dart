import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/state_phat_bieu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'dang_ky_phat_bieu_widget.dart';

class PhatBieuWidget extends StatefulWidget {
  const PhatBieuWidget({Key? key}) : super(key: key);

  @override
  _PhatBieuWidgetState createState() => _PhatBieuWidgetState();
}

class _PhatBieuWidgetState extends State<PhatBieuWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited.of(context).cubit;
    return SelectOnlyWidget(
      title: S.current.phat_bieu,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
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
                      showBottomSheetCustom(
                        context,
                        title: S.current.dang_ky_phat_bieu,
                        child: const DangKyPhatBieuWidget(),
                      );
                    },
                  ),
                  StreamBuilder<DetailDocumentProfileSend>(
                    initialData: cubit.thongTinGuiNhan,
                    stream: cubit.detailDocumentGuiNhan,
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
                                border: Border.all(
                                    color: borderItemCalender),
                                color:
                                borderItemCalender.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Column(
                                children:
                                snapshot.data!.toListRow().map(
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
                          physics:
                          const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
