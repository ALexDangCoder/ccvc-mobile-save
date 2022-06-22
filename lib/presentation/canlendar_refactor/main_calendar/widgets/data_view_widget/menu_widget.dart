import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key, required this.cubit}) : super(key: key);
  final CalendarWorkCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDrawerMenu,
      body: BlocBuilder(
        bloc: cubit,
        builder: (_, state) {
          final isCalendarView = state is CalendarViewState;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH50,
              title,
              spaceH24,
              itemMenuView(
                icon: ImageAssets.icTheoDangLich,
                title: S.current.theo_dang_lich,
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.emitCalendar();
                },
                isSelect: isCalendarView,
              ),
              spaceH2,
              itemMenuView(
                icon: ImageAssets.icTheoDangDanhSachGrey,
                title: S.current.theo_dang_danh_sach,
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.emitList();
                  if (cubit.statusType == StatusWorkCalendar.LICH_DUOC_MOI){
                    cubit.stateType = StateType.CHO_XAC_NHAN;
                    cubit.worksPagingController.refresh();
                  }
                },
                isSelect: !isCalendarView,
              ),
              spaceH12,
              const Divider(
                color: containerColor,
                height: 1,
              ),
              spaceH12,
              itemMenuView(
                isMyWork: true,
                icon: ImageAssets.icPerson,
                title: S.current.lich_cua_toi,
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.callApiByMenu(status: StatusWorkCalendar.LICH_CUA_TOI);
                },
              ),
              spaceH2,
              ExpandOnlyWidget(
                isPadingIcon: true,
                header: itemMenuView(
                  icon: ImageAssets.icLichTheoTrangThai,
                  title: S.current.lich_theo_trang_thai,
                ),
                child: StreamBuilder<DashBoardLichHopModel>(
                  stream: cubit.totalWorkStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? DashBoardLichHopModel.empty();
                    return Column(
                      children: [
                        childItemMenu(
                          context,
                          data.tongLichDuocMoi ?? 0,
                          StatusWorkCalendar.LICH_DUOC_MOI,
                        ),
                        childItemMenu(
                          context,
                          data.soLichTaoHo ?? 0,
                          StatusWorkCalendar.LICH_TAO_HO,
                        ),
                        childItemMenu(
                          context,
                          data.soLichHuyBo ?? 0,
                          StatusWorkCalendar.LICH_HUY,
                        ),
                        childItemMenu(
                          context,
                          data.soLichThuHoi ?? 0,
                          StatusWorkCalendar.LICH_THU_HOI,
                        ),
                        childItemMenu(
                          context,
                          data.soLichCoBaoCaoDaDuyet ?? 0,
                          StatusWorkCalendar.LICH_DA_CO_BAO_CAO,
                        ),
                        childItemMenu(
                          context,
                          data.soLichChuaCoBaoCao ?? 0,
                          StatusWorkCalendar.LICH_CHUA_CO_BAO_CAO,
                        ),
                      ],
                    );
                  },
                ),
              ),
              spaceH2,
              ExpandOnlyWidget(
                isPadingIcon: true,
                header: itemMenuView(
                  icon: ImageAssets.icLichLanhDao,
                  title: S.current.lich_theo_lanh_dao,
                ),
                child: Container(
                  height: 200,
                  color: Colors.red,
                ),
              ),
              spaceH16,
            ],
          );
        },
      ),
    );

  }

  Widget childItemMenu(
      BuildContext context,
      int value,
      StatusWorkCalendar type,
      ) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
        cubit.callApiByMenu(status: type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 12,
        ),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  spaceW30,
                  Expanded(
                    child: Text(
                      type.getTitle(),
                      style: tokenDetailAmount(
                        color: backgroundColorApp,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            spaceW12,
            countItemWidget(value),
          ],
        ),
      ),
    );
  }


  Widget countItemWidget(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppTheme.getInstance().colorField(),
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: textNormalCustom(
          color: backgroundColorApp,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget get title => Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          SvgPicture.asset(ImageAssets.icHeaderLVVV.svgToTheme()),
          const SizedBox(
            width: 12,
          ),
          Text(
            S.current.lich_lam_viec,
            style: textNormalCustom(
              color: backgroundColorApp,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );

  Widget itemMenuView({
    bool isMyWork = false,
    bool isSelect = false,
    required String icon,
    required String title,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 10,
        ),
        color: isSelect ? color_464646 : null,
        child: Row(
          children: [
            SizedBox(
              height: 15,
              width: 15,
              child: SvgPicture.asset(
                icon,
              ),
            ),
            spaceW13,
            Expanded(
              child: Text(
                title,
                style: textNormalCustom(
                  color: backgroundColorApp,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            if (isMyWork) spaceW12,
            if (isMyWork)
              StreamBuilder<DashBoardLichHopModel>(
                stream: cubit.totalWorkStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? DashBoardLichHopModel.empty();
                  return countItemWidget(data.countScheduleCaNhan ?? 0);
                },
              ),
          ],
        ),
      ),
    );
  }
}
