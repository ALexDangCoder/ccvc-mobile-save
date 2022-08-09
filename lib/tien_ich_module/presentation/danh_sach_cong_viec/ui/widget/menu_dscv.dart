import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/button_botton_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_menu_custom.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/container_menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/theo_dang_lich_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
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
    widget.cubit.getCountTodoAndMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: !isMobile() ? bgTabletColor : backgroundDrawerMenu,
      appBar: BaseAppBar(
        maxLine: 2,
        backGroundColor: backgroundDrawerMenu,
        title: S.current.danh_sach_cong_viec,
        titleColor: backgroundColorApp,
        leadingIcon: isMobile()
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(ImageAssets.icDocument),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  ImageAssets.icClose,
                ),
              ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                StreamBuilder<String>(
                  stream: widget.cubit.statusDSCV.stream,
                  builder: (context, snapshot) {
                    final dataStatusScreen = snapshot.data;
                    return StreamBuilder<List<CountTodoModel>>(
                      stream: widget.cubit.countTodoModelSubject,
                      builder: (context, snapshotCountTodoModel) {
                        final dataCountTodoModel =
                            snapshotCountTodoModel.data ?? [];
                        if (dataCountTodoModel.isEmpty) {
                          return const SizedBox();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: dataCountTodoModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final value = dataCountTodoModel[index];
                            final valueChildren = value.childrenTodoViewModel;
                            if (value.code != DSCVScreen.NCVM) {
                              return screenDevice(
                                mobileScreen: TheoDangLichWidgetDSCV(
                                  icon: value.icon(),
                                  name: value.name ?? '',
                                  onTap: () {
                                    onTapInMenu(value);
                                  },
                                  isSelect: value.code == dataStatusScreen,
                                  number: value.count ?? 0,
                                ),
                                tabletScreen: CellMenuCustom(
                                  icon: value.icon(),
                                  name: value.name ?? '',
                                  onTap: () {
                                    onTapInMenu(value);
                                  },
                                  isSelect: value.code == dataStatusScreen,
                                  number: value.count ?? 0,
                                ),
                              );
                            }
                            return screenDevice(
                              mobileScreen: ContainerMenuDSCVWidget(
                                name: value.name ?? '',
                                icon: value.icon(),
                                type: TypeContainer.expand,
                                childExpand: Column(
                                  children: [
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: valueChildren?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexChildren) {
                                        final valueChil =
                                            valueChildren?[indexChildren];
                                        return TheoDangLichWidgetDSCV(
                                          icon: '',
                                          name: valueChil?.name ?? '',
                                          onTap: () {
                                            onTopInMenuChildren(
                                              valueChil ?? CountTodoModel(),
                                            );
                                          },
                                          isSelect: false,
                                          number: valueChil?.count ?? 0,
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
                                          buttonThemNhomCongViec();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              tabletScreen: ContainerMenuDSCVWidget(
                                name: S.current.nhom_cong_viec_moi,
                                icon: ImageAssets.ic_nhomCVMoi,
                                type: TypeContainer.expand,
                                childExpand: Column(
                                  children: [
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: valueChildren?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexChildren) {
                                        final valueChild =
                                            valueChildren?[indexChildren];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10,),
                                          child: CellMenuCustom(
                                            margin: false,
                                            icon: '',
                                            name: valueChild?.name ?? '',
                                            onTap: () {
                                              onTopInMenuChildren(
                                                valueChild ?? CountTodoModel(),
                                              );
                                            },
                                            isSelect: true,
                                            number: valueChild?.count ?? 0,
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
                                          buttonThemNhomCongViec();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
    );
  }

  void buttonThemNhomCongViec() => isMobile()
      ? showBottomSheetCustom(
          context,
          title: S.current.ten_nhom,
          child: addTodoGroup(),
        )
      : showDiaLogTablet(
          context,
          title: S.current.ten_nhom,
          child: addTodoGroup(),
          isBottomShow: false,
          funcBtnOk: () {},
          maxHeight: 200,
        );

  Widget addTodoGroup() => AddToDoWidgetTienIch(
        onTap: (value) {
          widget.cubit.addGroupTodo(value);
          Navigator.pop(context);
        },
      );

  void onTapInMenu(CountTodoModel value) {
    widget.cubit.titleAppBar.add(value.name ?? '');
    widget.cubit.statusDSCV.sink.add(value.code ?? '');
    widget.cubit.groupId = '';
    widget.cubit.searchControler.text = '';
    widget.cubit.countLoadMore = 1;
    Navigator.pop(
      context,
      widget.cubit.callAPITheoFilter(),
    );
  }

  void onTopInMenuChildren(CountTodoModel value) {
    widget.cubit.titleAppBar.add(value.name ?? '');
    widget.cubit.statusDSCV.sink.add(DSCVScreen.NCVM);
    widget.cubit.groupId = value.id ?? '';
    widget.cubit.searchControler.text = '';
    widget.cubit.countLoadMore = 1;
    Navigator.pop(
      context,
      widget.cubit.callAPITheoFilter(groupId: value.id),
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
