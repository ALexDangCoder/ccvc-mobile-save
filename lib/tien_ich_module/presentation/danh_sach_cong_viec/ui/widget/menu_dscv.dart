import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/button_botton_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_menu_custom.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/container_menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/theo_dang_lich_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'addToDoWidget.dart';

class MenuDSCV extends StatefulWidget {
  final DanhSachCongViecTienIchCubit cubit;

  const MenuDSCV({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<MenuDSCV> createState() => _MenuDSCVState();
}

class _MenuDSCVState extends State<MenuDSCV> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 58,
            ),
            headerWidget(menu: S.current.danh_sach_cong_viec),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  StreamBuilder<int>(
                    stream: widget.cubit.statusDSCV.stream,
                    builder: (context, snapshot) {
                      return StreamBuilder<List<CountTodoModel>>(
                        stream: widget.cubit.countTodoModelSubject,
                        builder: (context, snapshotCountTodoModel) {
                          final dataCountTodoModel =
                              snapshotCountTodoModel.data ?? [];
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: dataCountTodoModel?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final value = dataCountTodoModel[index];
                              final valuechildren = dataCountTodoModel[index]
                                  .childrenTodoViewModel;
                              if (value.childrenTodoViewModel != null) {
                                ContainerMenuDSCVWidget(
                                  name: S.current.nhom_cong_viec_moi,
                                  icon: ImageAssets.ic_nhomCVMoi,
                                  type: TypeContainer.expand,
                                  childExpand: Column(
                                    children: [
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: valuechildren?.length ?? 0,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, indexChildren) {
                                          final vlChil = valuechildren?[index];
                                          return TheoDangLichWidgetDSCV(
                                            icon: '',
                                            name: vlChil?.name ?? '',
                                            onTap: () {
                                              widget.cubit.titleAppBar
                                                  .add(vlChil?.name ?? '');
                                              widget.cubit.statusDSCV.sink
                                                  .add(DSCVScreen.NCVM);
                                              widget.cubit
                                                  .addValueWithTypeToDSCV();
                                              widget.cubit.groupId =
                                                  vlChil?.id ?? '';
                                              widget.cubit.searchControler
                                                  .text = '';
                                              Navigator.pop(context);
                                            },
                                            isSelect: false,
                                            number: vlChil?.count ?? 0,
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 17,
                                          top: 4,
                                        ),
                                        child: ButtonCustomBottomDSCV(
                                          title: S.current.them_nhom_cong_viec,
                                          isColorBlue: true,
                                          size: 12,
                                          onPressed: () {
                                            showBottomSheetCustom(
                                              context,
                                              title: S.current.ten_nhom,
                                              child: AddToDoWidgetTienIch(
                                                onTap: (value) {
                                                  widget.cubit
                                                      .addGroupTodo(value);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return TheoDangLichWidgetDSCV(
                                icon: value.icon(),
                                name: value.name ?? '',
                                onTap: () {
                                  widget.cubit.titleAppBar
                                      .add(value.name ?? '');
                                  widget.cubit.statusDSCV.sink.add(index);
                                  widget.cubit.addValueWithTypeToDSCV();
                                  widget.cubit.groupId = '';
                                  widget.cubit.searchControler.text = '';
                                  Navigator.pop(context);
                                },
                                isSelect: index == snapshot.data,
                                number: value.count ?? 0,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgTabletColor,
        appBar: BaseAppBar(
          backGroundColor: bgTabletColor,
          title: S.current.danh_sach_cong_viec,
          leadingIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              ImageAssets.icClose,
            ),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder<int>(
              stream: widget.cubit.statusDSCV.stream,
              builder: (context, snapshot) {
                return StreamBuilder<List<CountTodoModel>>(
                  stream: widget.cubit.countTodoModelSubject,
                  builder: (context, snapshotCountTodoModel) {
                    final dataCountTodoModel =
                        snapshotCountTodoModel.data ?? [];
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: dataCountTodoModel?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final value = dataCountTodoModel[index];
                        final valuechildren =
                            dataCountTodoModel[index].childrenTodoViewModel;
                        if (value.childrenTodoViewModel != null) {
                          ContainerMenuDSCVWidget(
                            name: S.current.nhom_cong_viec_moi,
                            icon: ImageAssets.ic_nhomCVMoi,
                            type: TypeContainer.expand,
                            childExpand: Column(
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: valuechildren?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, indexChildren) {
                                    final vlChil = valuechildren?[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CellMenuCustom(
                                        margin: false,
                                        icon: '',
                                        name: vlChil?.name ?? '',
                                        onTap: () {
                                          widget.cubit.titleAppBar
                                              .add(vlChil?.name ?? '');
                                          widget.cubit.statusDSCV.sink
                                              .add(DSCVScreen.NCVM);
                                          widget.cubit.addValueWithTypeToDSCV();
                                          widget.cubit.groupId =
                                              vlChil?.id ?? '';
                                          widget.cubit.searchControler.text =
                                              '';
                                          Navigator.pop(context);
                                        },
                                        isSelect: true,
                                        number: widget.cubit.soLuongNhomCvMoi(
                                          groupId: vlChil?.id ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 200, right: 8, top: 20),
                                  child: ButtonCustomBottomDSCV(
                                    size: 14,
                                    title: S.current.them_nhom_cong_viec,
                                    isColorBlue: true,
                                    onPressed: () {
                                      showDiaLogTablet(
                                        context,
                                        title: S.current.ten_nhom,
                                        child: AddToDoWidgetTienIch(
                                          onTap: (value) {
                                            widget.cubit.addGroupTodo(value);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        isBottomShow: false,
                                        funcBtnOk: () {},
                                        maxHeight: 200,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return CellMenuCustom(
                          icon: value.icon(),
                          name: value.name ?? '',
                          onTap: () {
                            widget.cubit.titleAppBar.add(value.name ?? '');
                            widget.cubit.statusDSCV.sink.add(index);
                            widget.cubit.addValueWithTypeToDSCV();
                            widget.cubit.groupId = '';
                            widget.cubit.searchControler.text = '';
                            Navigator.pop(context);
                          },
                          isSelect: true,
                          number: value.count ?? 0,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(ImageAssets.icDocument),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            menu,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
