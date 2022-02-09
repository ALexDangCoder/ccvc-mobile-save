import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'child_widget/moi_nguoi_tham_gia_widget.dart';

class MoiNguoiThamGiaWidget extends StatefulWidget {
  const MoiNguoiThamGiaWidget({Key? key}) : super(key: key);

  @override
  _MoiNguoiThamGiaWidgetState createState() => _MoiNguoiThamGiaWidgetState();
}

class _MoiNguoiThamGiaWidgetState extends State<MoiNguoiThamGiaWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited.of(context).cubit;

    return SelectOnlyWidget(
      title: S.current.thanh_phan_tham_gia,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.icAddUser,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showBottomSheetCustom(
                context,
                child: const ThemThanhPhanThamGiaWidget(),
                title: S.current.them_thanh_phan_tham_gia,
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.icTickSquare,
            title: S.current.diem_danh,
            onPress: () {},
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
                        border: Border.all(color: borderItemCalender),
                        color: borderItemCalender.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Column(
                        children: snapshot.data!.toListRow().map(
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
    );
  }
}
