import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dia_log_tablet.dart';
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
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/creat_todo_ver2_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
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
  String textSearch = '';

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
              child: CreatTodoOrUpdateWidget(
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
              await cubit.callAndFillApiAutu().then(
                    (value) => textSearch != '' ? cubit.search(textSearch) : '',
                  );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: StreamBuilder<int>(
                stream: cubit.statusDSCV.stream,
                builder: (context, snapshotType) {
                  final dataType = snapshotType.data ?? 0;
                  return ScrollBarWidget(
                    children: [
                      BaseSearchBar(
                        controller: cubit.searchControler,
                        hintText: S.current.tim_kiem_nhanh,
                        onChange: (value) {
                          textSearch = value;
                          cubit.search(value);
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (dataType == DSCVScreen.CVCB ||
                              dataType == DSCVScreen.CVQT ||
                              dataType == DSCVScreen.GCT ||
                              dataType == DSCVScreen.NCVM ||
                              dataType == DSCVScreen.DBX)
                            StreamBuilder<List<TodoDSCVModel>>(
                              stream: cubit.listDSCV.stream,
                              builder: (context, snapshot) {
                                final data = snapshot.data
                                        ?.where(
                                          (element) =>
                                              dataType != DSCVScreen.DBX
                                                  ? element.isTicked == false
                                                  : element.inUsed == false,
                                        )
                                        .toList() ??
                                    [];
                                if (data.isNotEmpty) {
                                  return Column(
                                    children: [
                                      if (dataType == DSCVScreen.CVCB ||
                                          dataType == DSCVScreen.NCVM)
                                        textTitle(
                                          S.current.gan_cho_toi,
                                          data.length,
                                        ),
                                      ListUpDSCV(
                                        data: data,
                                        cubit: cubit,
                                        dataType: dataType,
                                      ),
                                    ],
                                  );
                                }
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Column(
                                    children: [
                                      if (dataType == DSCVScreen.CVCB ||
                                          dataType == DSCVScreen.NCVM)
                                        textTitle(
                                          S.current.gan_cho_toi,
                                          data.length,
                                        ),
                                      const NodataWidget(),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      if (dataType == DSCVScreen.CVCB ||
                          dataType == DSCVScreen.DHT ||
                          dataType == DSCVScreen.NCVM)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (dataType == DSCVScreen.CVCB ||
                                      dataType == DSCVScreen.NCVM)
                                    textTitle(
                                      S.current.da_hoan_thanh,
                                      data.length,
                                    ),
                                  ListDownDSCV(
                                    data: data,
                                    dataType: dataType,
                                    cubit: cubit,
                                  ),
                                ],
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Column(
                                children: [
                                  if (dataType == DSCVScreen.CVCB ||
                                      dataType == DSCVScreen.NCVM)
                                    textTitle(
                                      S.current.da_hoan_thanh,
                                      data.length,
                                    ),
                                  const NodataWidget(),
                                ],
                              ),
                            );
                          },
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

  Widget textTitle(String text, int count) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Text(
              text,
              style: textNormalCustom(
                fontSize: 14,
                color: infoColor,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: textDefault,
              ),
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0.textScale(),
                ),
              ),
            ),
          ],
        ),
      );
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
            if (dataType == DSCVScreen.NCVM) {
              return MenuSelectWidget(
                listSelect: [
                  CellPopPupMenu(
                    urlImage: ImageAssets.icEditBlue,
                    text: S.current.doi_lai_ten,
                    onTap: () {
                      if (isMobile()) {
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
                      } else {
                        showDiaLogTablet(
                          context,
                          title: S.current.doi_lai_ten,
                          child: AddToDoWidgetTienIch(
                            initData: cubit.titleAppBar.value,
                            onTap: (value) {
                              cubit.updateLabelTodoList(value);
                              Navigator.pop(context);
                            },
                          ),
                          isBottomShow: false,
                          funcBtnOk: () {},
                          maxHeight: 250,
                        );
                      }
                    },
                  ),
                  CellPopPupMenu(
                    urlImage: '',
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
                        title:
                            S.current.ban_co_chan_chan_muon_xoa_nhom_cong_viec,
                        textContent: '',
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

class ListUpDSCV extends StatelessWidget {
  final List<TodoDSCVModel> data;
  final int dataType;
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
          isEnableIcon: cubit.enableIcon(dataType),
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
            );
          },
          onChange: (vl) {
            cubit.editWork(
              todo: todo,
            );
          },
          onEdit: () {
            if (cubit.listNguoiThucHienSubject.hasValue) {
              onTapCreatOrUpdate(context, todo);
            }
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
            );
          },
          onXoaVinhVien: () {
            showDiaLog(
              context,
              funcBtnRight: () {
                cubit.xoaCongViecVinhVien(todo.id ?? '');
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_xoa_vinh_viec_cv,
              ),
              title: S.current.ban_co_chan_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
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
          isCreat: false,
        ),
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreat: false,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}

class ListDownDSCV extends StatelessWidget {
  final List<TodoDSCVModel> data;
  final int dataType;
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
          isEnableIcon: cubit.enableIcon(dataType),
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
            );
          },
          onChange: (vl) {
            cubit.editWork(
              todo: todo,
            );
          },
          onEdit: () {
            if (cubit.listNguoiThucHienSubject.hasValue) {
              onTapCreatOrUpdate(context, todo);
            }
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
                cubit.xoaCongViecVinhVien(todo.id ?? '');
              },
              icon: SvgPicture.asset(
                ImageAssets.ic_xoa_vinh_viec_cv,
              ),
              title: S.current.ban_co_chan_chan_muon_xoa,
              btnLeftTxt: S.current.huy,
              btnRightTxt: S.current.xoa,
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
          isCreat: false,
        ),
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.chinh_sua,
        child: CreatTodoOrUpdateWidget(
          cubit: cubit,
          todo: todo,
          isCreat: false,
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      );
    }
  }
}
