import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/th%C3%A0nh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/tablet/Widget_tablet/cell_thanh_phan_tham_gia_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thanh_phan_tham_gia_widget/child_widget/moi_nguoi_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/checkbox/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import '../icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';

class MoiNguoiThamGiaWidgetTablet extends StatefulWidget {
  const MoiNguoiThamGiaWidgetTablet({Key? key}) : super(key: key);

  @override
  _MoiNguoiThamGiaWidgetTabletState createState() =>
      _MoiNguoiThamGiaWidgetTabletState();
}

class _MoiNguoiThamGiaWidgetTabletState
    extends State<MoiNguoiThamGiaWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          IconWithTiltleWidget(
            icon: ImageAssets.icAddUser,
            title: S.current.moi_nguoi_tham_gia,
            onPress: () {
              showDiaLogTablet(
                context,
                title: S.current.them_thanh_phan_tham_gia,
                child: const ThemThanhPhanThamGiaWidget(),
                isBottomShow: false,
                funcBtnOk: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                child: IconWithTiltleWidget(
                  icon: ImageAssets.icTickSquare,
                  title: S.current.diem_danh,
                  onPress: () {},
                ),
              ),
              const Expanded(child: SizedBox()),
              Flexible(
                child: IconWithTiltleWidget(
                  type2: true,
                  icon: ImageAssets.icVector2,
                  title: S.current.huy_diem_danh,
                  onPress: () {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          BaseSearchBar(
            hintText: S.current.tim_kiem_can_bo,
            onChange: (value) {
              cubit.search(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.5, top: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 41,
                  child: CustomCheckBox(
                    title: '',
                    isCheck: cubit.check,
                    onChange: (VALUE) {
                      cubit.check = !cubit.check;
                      cubit.subjectStreamCheck.sink.add(VALUE);
                      print(VALUE);
                    },
                  ),
                ),
                AutoSizeText(
                  S.current.chon_tat_ca,
                  style: textNormalCustom(
                    fontSize: 16,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          StreamBuilder<List<ThanhPhanThamGiaModel>>(
            initialData: cubit.listFakeThanhPhanThamGiaModel,
            stream: cubit.thanhPhanThamGia,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.listFakeThanhPhanThamGiaModel.length,
                  itemBuilder: (context, index) {
                    return CellThanhPhanThamGia(
                      index: index,
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
    );
  }
}
