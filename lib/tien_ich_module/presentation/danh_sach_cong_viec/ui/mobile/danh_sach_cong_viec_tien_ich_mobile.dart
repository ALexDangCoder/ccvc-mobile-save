import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/addToDoWidget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chinh_sua_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/creat_todo_ver2_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachCongViecTienIchMobile extends StatefulWidget {
  const DanhSachCongViecTienIchMobile({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchMobileState createState() =>
      _DanhSachCongViecTienIchMobileState();
}

class _DanhSachCongViecTienIchMobileState
    extends State<DanhSachCongViecTienIchMobile> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDSCV(cubit: cubit, context: context),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            showBottomSheetCustom(
              context,
              title: S.current.them_cong_viec,
              child: CreatTodoOrUpdateVer2Widget(
                cubit: cubit,
              ),
            );
          },
          backgroundColor: AppTheme.getInstance().colorField(),
          child: SvgPicture.asset(
            ImageAssets.icAddCalenderWhite,
          ),
        ),
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: cubit.stateStream,
        child: ProviderWidget<DanhSachCongViecTienIchCubit>(
          cubit: cubit,
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.initialData();
            },
            child: SingleChildScrollView(
              child: StreamBuilder<int>(
                stream: cubit.statusDSCV.stream,
                builder: (context, snapshotType) {
                  final dataType = snapshotType.data ?? 0;
                  return ScrollBarWidget(
                    children: [
                      BaseSearchBar(
                        hintText: S.current.tim_kiem_nhanh,
                        onChange: (value) {
                          cubit.search(value);
                        },
                      ),
                      if (dataType == CVCB ||
                          dataType == CVQT ||
                          dataType == GCT ||
                          dataType == NCVM ||
                          dataType == DBX)
                        StreamBuilder<List<TodoDSCVModel>>(
                          stream: cubit.listDSCV.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data
                                    ?.where(
                                      (element) => dataType != DBX
                                          ? element.isTicked == false
                                          : element.inUsed == false,
                                    )
                                    .toList() ??
                                [];
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                key: UniqueKey(),
                                itemCount: data.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final todo = data[index];
                                  return CongViecCellTienIch(
                                    isTheEdit: dataType != DBX,
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
                                        textContent:
                                            S.current.ban_chac_chan_muon_xoa,
                                        btnLeftTxt: S.current.huy,
                                        btnRightTxt: S.current.xoa,
                                      );
                                    },
                                    onChange: (controller) {
                                      cubit.editWork(
                                        todo: todo,
                                      );
                                      cubit.titleChange = controller.text;
                                    },
                                    onEdit: () {
                                      showBottomSheetCustom(
                                        context,
                                        title: S.current.chinh_sua,
                                        child: CreatTodoOrUpdateVer2Widget(
                                          cubit: cubit,
                                          todo: todo,
                                          isCreat: false,
                                        ),
                                      );
                                    },
                                    enabled: !(todo.isTicked ?? true),
                                    isDaBiXoa: dataType == DBX,
                                  );
                                },
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: NodataWidget(),
                            );
                          },
                        ),
                      if (dataType == CVCB ||
                          dataType == DHT ||
                          dataType == NCVM)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (dataType == CVCB || dataType == NCVM)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  S.current.da_hoan_thanh,
                                  style: textNormalCustom(
                                    fontSize: 14,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            StreamBuilder<List<TodoDSCVModel>>(
                              stream: cubit.listDSCV.stream,
                              builder: (context, snapshot) {
                                final data = snapshot.data
                                        ?.where(
                                          (element) => element.isTicked == true,
                                        )
                                        .toList() ??
                                    [];
                                if (data.isNotEmpty) {
                                  return Column(
                                    children:
                                        List.generate(data.length, (index) {
                                      final todo = data[index];
                                      return CongViecCellTienIch(
                                        enabled: false,
                                        todoModel: todo,
                                        onCheckBox: (value) {
                                          cubit.editWork(
                                            todo: todo,
                                            isTicked: !(todo.isTicked ?? true),
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
                                            textContent: S
                                                .current.ban_chac_chan_muon_xoa,
                                            btnLeftTxt: S.current.huy,
                                            btnRightTxt: S.current.xoa,
                                          );
                                        },
                                        onStar: () {
                                          cubit.editWork(
                                            todo: todo,
                                            important:
                                                !(todo.important ?? false),
                                          );
                                        },
                                        text: todo.label ?? '',
                                      );
                                    }),
                                  );
                                }
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: NodataWidget(),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AppBar appBarDSCV({required DanhSachCongViecTienIchCubit cubit, context}) {
  return AppBar(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    bottomOpacity: 0.0,
    leadingWidth: 100,
    elevation: isMobile() ? 0 : 0.7,
    shadowColor: bgDropDown,
    automaticallyImplyLeading: false,
    title: StreamBuilder<String>(
      stream: cubit.titleAppBar.stream,
      builder: (context, snapshot) {
        final title = snapshot.data ?? S.current.danh_sach_cong_viec;
        return Text(
          title,
          style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
        );
      },
    ),
    leading: Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: StreamBuilder<int>(
          stream: cubit.statusDSCV.stream,
          builder: (context, snapshotbool) {
            final dataType = snapshotbool.data ?? 0;
            if (dataType == NCVM) {
              return MenuSelectWidget(
                listSelect: [
                  CellPopPupMenu(
                    urlImage: ImageAssets.icEditBlue,
                    text: S.current.doi_lai_ten,
                    onTap: () {
                      showBottomSheetCustom(
                        context,
                        title: S.current.doi_lai_ten,
                        child: AddToDoWidgetTienIch(
                          initData: cubit.titleAppBar.value,
                          onTap: (value) {
                            cubit.updateLabelTodoList(value);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  CellPopPupMenu(
                    urlImage: ImageAssets.ic_delete_do,
                    text: S.current.xoa,
                    onTap: () {
                      showDiaLog(
                        context,
                        funcBtnRight: () {
                          cubit.deleteGroupTodoList();
                        },
                        icon: SvgPicture.asset(
                          ImageAssets.icDeleteLichHop,
                        ),
                        title: S.current.xoa_cong_viec,
                        textContent:
                            S.current.viec_nay_se_xoa_cac_task_ben_trong_no,
                        btnLeftTxt: S.current.huy,
                        btnRightTxt: S.current.xoa,
                      );
                    },
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
      IconButton(
        onPressed: () {
          DrawerSlide.navigatorSlide(
            context: context,
            screen: MenuDSCV(
              cubit: cubit,
            ),
            thenValue: (value) {},
          );
        },
        icon: SvgPicture.asset(ImageAssets.icMenuCalender),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
