import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/bieu_quyet_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/cong_tac_chuan_bi_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/phat_bieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thanh_phan_tham_gia_widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'Widget_tablet/double_button.dart';

// todo chi tiet van ban
class DetailMeetCalenderTablet extends StatefulWidget {
  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet> {
  late DetailMeetCalenderCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = DetailMeetCalenderCubit();
    cubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: backgroundColorApp,
        bottomOpacity: 0.0,
        elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
        shadowColor: bgDropDown,
        automaticallyImplyLeading: false,
        title: Text(
          S.current.chi_tiet_lich_hop,
          style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ),
      body: DetailMeetCalendarInherited(
        cubit: cubit,
        child: ExpandGroup(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SingleChildScrollView(
                    child: StreamBuilder<ChiTietLichLamViecModel>(
                      stream: cubit.chiTietLichLamViecStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        final data = snapshot.data;

                        final listText = data
                                ?.dataRow()
                                .where(
                                    (element) => element.type == typeData.text)
                                .toList() ??
                            [];

                        final listText1 = listText.sublist(0, 2);
                        final listText2 = listText.sublist(3, listText.length);

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 16,
                                    color: statusCalenderRed,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    S.current.hop_noi_bo_cong_ty,
                                    style: textNormalCustom(
                                      color: textTitle,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Column(
                                            children: listText1
                                                .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 24,
                                                    ),
                                                    child: RowValueWidget(
                                                      row: e,
                                                      isTablet: true,
                                                      // isMarinLeft: true,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                          Column(
                                            children: listText2
                                                .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 24,
                                                    ),
                                                    child: RowValueWidget(
                                                      row: e,
                                                      isTablet: true,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      DoubleButtonWidget(
                                        onPressed2: () {},
                                        onPressed1: () {},
                                      ),
                                      const SizedBox(
                                        height: 28,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: (data
                                                          ?.dataRow()
                                                          .where(
                                                            (element) =>
                                                                element.type ==
                                                                typeData
                                                                    .listperson,
                                                          )
                                                          .toList())
                                                      ?.map(
                                                        (e) => RowValueWidget(
                                                          row: e,
                                                          isTablet: true,
                                                        ),
                                                      )
                                                      .toList() ??
                                                  [
                                                    Container(),
                                                  ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                CongTacChuanBiWidget(),
                MoiNguoiThamGiaWidget(),
                TaiLieuWidget(),
                PhatBieuWidget(),
                BieuQuyetWidget(),
                KetLuanHopWidget(),
                YKienCuocHopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
