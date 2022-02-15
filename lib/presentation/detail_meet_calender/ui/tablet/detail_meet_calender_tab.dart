import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 12,
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
                        StreamBuilder<ChiTietLichLamViecModel>(
                          stream: cubit.chiTietLichLamViecStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }

                            final data = snapshot.data;

                            return Column(
                              children: data
                                      ?.dataRow()
                                      .map(
                                        (e) => Container(
                                          margin:
                                              const EdgeInsets.only(top: 24),
                                          child: RowValueWidget(
                                            row: e,
                                            isTablet: false,
                                          ),
                                        ),
                                      )
                                      .toList() ??
                                  [Container()],
                            );
                          },
                        ),
                      ],
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

class DetailMeetCalendarInherited extends InheritedWidget {
  DetailMeetCalenderCubit cubit;

  DetailMeetCalendarInherited(
      {Key? key, required this.cubit, required Widget child})
      : super(key: key, child: child);

  static DetailMeetCalendarInherited of(BuildContext context) {
    final DetailMeetCalendarInherited? result = context
        .dependOnInheritedWidgetOfExactType<DetailMeetCalendarInherited>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
