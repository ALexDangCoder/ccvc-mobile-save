import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/creat_todo_ver2_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListUpDSCV extends StatelessWidget {
  final List<TodoDSCVModel> data;
  final String dataType;
  final DanhSachCongViecTienIchCubit cubit;

  const ListUpDSCV({
    Key? key,
    required this.data,
    required this.dataType,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final todo = data[index];
        return CongViecCellTienIch(
          showIcon: cubit.showIcon(dataType: dataType),
          isEnableIcon: dataType != DSCVScreen.DBX,
          text: todo.label ?? '',
          todoModel: todo,
          onCheckBox: (value) {
            cubit.editWork(
              todo: todo,
              isTicked: !(todo.isTicked ?? false),
            );
          },
          onStar: () {
            cubit.editWork(
              todo: todo,
              important: !(todo.important ?? false),
            );
          },
          onClose: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.editWork(
                  todo: todo,
                  inUsed: !(todo.inUsed ?? false),
                );
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_xoa_vinh_viec_cv,
              ),
              title: S.current.ban_co_chan_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
              showTablet: !isMobile(),
            );
          },
          onChange: (value) {
            cubit.editWork(
              todo: todo,
            );
          },
          onEdit: () {
            onTapCreatOrUpdate(context, todo);
          },
          onThuHoi: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.editWork(
                  todo: todo,
                  inUsed: !(todo.inUsed ?? false),
                );
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_hoan_tac_dscv,
              ),
              title: S.current.ban_co_chan_chan_muon_hoan_tac,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.hoan_tac,
              showTablet: !isMobile(),
            );
          },
          onXoaVinhVien: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.xoaCongViecVinhVien(todo.id ?? '', todo);
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_xoa_vinh_viec_cv,
              ),
              title: S.current.ban_co_chan_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
              showTablet: !isMobile(),
            );
          },
          cubit: cubit,
        );
      },
    );
  }

  void onTapCreatOrUpdate(BuildContext context, TodoDSCVModel todo) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreate: false,
        ),
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreate: false,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}

class ListDownDSCV extends StatelessWidget {
  final List<TodoDSCVModel> data;
  final String dataType;
  final DanhSachCongViecTienIchCubit cubit;

  const ListDownDSCV({
    Key? key,
    required this.data,
    required this.dataType,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final todo = data[index];
        return CongViecCellTienIch(
          showIcon: cubit.showIcon(dataType: dataType, isListUp: false),
          isEnableIcon: dataType != DSCVScreen.DBX,
          text: todo.label ?? '',
          todoModel: todo,
          onCheckBox: (value) {
            cubit.editWork(
              todo: todo,
              isTicked: !(todo.isTicked ?? false),
            );
          },
          onStar: () {
            cubit.editWork(
              todo: todo,
              important: !(todo.important ?? false),
            );
          },
          onClose: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.editWork(
                  todo: todo,
                  inUsed: !(todo.inUsed ?? false),
                );
              },
              icon: SvgPicture.asset(
                ImageAssets.icDeleteLichHop,
              ),
              title: S.current.xoa_cong_viec,
              textContent: S.current.ban_chac_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
              showTablet: !isMobile(),
            );
          },
          onChange: (value) {
            cubit.editWork(
              todo: todo,
            );
          },
          onEdit: () {
            onTapCreatOrUpdate(context, todo);
          },
          onThuHoi: () {
            cubit.editWork(
              todo: todo,
              inUsed: !(todo.inUsed ?? false),
            );
          },
          onXoaVinhVien: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.xoaCongViecVinhVien(todo.id ?? '', todo);
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_xoa_vinh_viec_cv,
              ),
              title: S.current.ban_co_chan_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
              showTablet: !isMobile(),
            );
          },
          cubit: cubit,
        );
      },
    );
  }

  void onTapCreatOrUpdate(BuildContext context, TodoDSCVModel todo) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreate: false,
        ),
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreate: false,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}
