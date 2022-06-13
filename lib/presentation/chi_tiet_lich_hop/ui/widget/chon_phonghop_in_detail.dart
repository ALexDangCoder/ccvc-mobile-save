import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/cong_tac_chuan_bi_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/chon_phong_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChonPhongHopDetailHopScreen extends StatefulWidget {
  const ChonPhongHopDetailHopScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChonPhongHopWidgetState createState() => _ChonPhongHopWidgetState();
}

class _ChonPhongHopWidgetState extends State<ChonPhongHopDetailHopScreen> {
  final DetailMeetCalenderCubit _cubit = DetailMeetCalenderCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showBottomSheet();
      },
      text: S.current.chon_phong_hop,
      urlIcon: ImageAssets.icChonPhongHop,
    );
  }

  void showBottomSheet() {
    if (isMobile()) {
      showBottomSheetCustom<ChonPhongHopModel>(
        context,
        child: _ChonPhongHopScreen(
          cubit: _cubit,
        ),
        title: S.current.chon_phong_hop,
      );
    } else {
      showDiaLogTablet<ChonPhongHopModel>(
        context,
        title: S.current.chon_phong_hop,
        child: _ChonPhongHopScreen(
          cubit: _cubit,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}

class _ChonPhongHopScreen extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const _ChonPhongHopScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  __ChonPhongHopScreenState createState() => __ChonPhongHopScreenState();
}

class __ChonPhongHopScreenState extends State<_ChonPhongHopScreen> {
  int groupValue = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      width: double.infinity,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: Column(
          children: [
            StreamBuilder<List<PhongHopModel>>(
              stream: widget.cubit.phongHopSubject,
              builder: (context, snapshot) {
                final listData = snapshot.data ?? [];
                return listData.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listData.length,
                        itemBuilder: (_, index) => itemPhongHop(
                          phongHop: listData[index],
                          index: index,
                          groupValue: groupValue,
                          onChange: (index) {
                            widget.cubit.chosePhongHop
                              ..donViId = listData[index].donViDuyetId
                              ..ten = listData[index].ten
                              ..bitTTDH = listData[index].bit_TTDH
                              ..phongHopId = listData[index].id;
                            groupValue = index;
                            setState(() {});
                          },
                        ),
                      )
                    : const NodataWidget();
              },
            ),
            DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.xac_nhan,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                widget.cubit.thayDoiPhongHop();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
