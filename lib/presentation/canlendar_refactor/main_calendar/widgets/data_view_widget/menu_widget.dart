import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
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
          final isList = state is ListViewState;
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
                isSelect: !isList,
              ),
              spaceH2,
              itemMenuView(
                icon: ImageAssets.icTheoDangDanhSachGrey,
                title: S.current.theo_dang_danh_sach,
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.emitList();
                },
                isSelect: isList,
              ),
              spaceH12,
              const Divider(
                color: containerColor,
                height: 1,
              ),
              spaceH12,
              itemMenuView(
                icon: ImageAssets.icPerson,
                title: S.current.lich_cua_toi,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              spaceH2,
              ExpandOnlyWidget(
                header: itemMenuView(
                  icon: ImageAssets.icLichTheoTrangThai,
                  title: S.current.lich_theo_trang_thai,
                ),
                child: Container(
                  height: 200,
                  color: Colors.red,
                ),
              ),
              spaceH2,
              ExpandOnlyWidget(
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
          ],
        ),
      ),
    );
  }
}
