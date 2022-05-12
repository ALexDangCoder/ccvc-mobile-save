import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/dialog_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/mobile/danh_sach_cong_viec_tien_ich_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/addToDoWidget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chinh_sua_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachCongViecTienIchTablet extends StatefulWidget {
  const DanhSachCongViecTienIchTablet({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchTabletState createState() =>
      _DanhSachCongViecTienIchTabletState();
}

class _DanhSachCongViecTienIchTabletState
    extends State<DanhSachCongViecTienIchTablet> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();
  bool isCheck = true;
  bool isCheck2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.initialData();
      },
      child: Scaffold(
        backgroundColor: bgQLVBTablet,
        appBar: appBarDSCV(cubit: cubit, context: context),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
              showDiaLogTablet(
                context,
                title: S.current.them_cong_viec,
                child: AddToDoWidgetTienIch(
                  onTap: (value) {
                    cubit.addTodo(value);
                    Navigator.pop(context);
                  },
                ),
                isBottomShow: false,
                funcBtnOk: () {},
                maxHeight: 200,
              );
            },
            backgroundColor: AppTheme.getInstance().colorField(),
            child: SvgPicture.asset(
              ImageAssets.icAddCalenderWhite,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: cubit.stateStream,
            child: ProviderWidget(
              cubit: cubit,
              child: StreamBuilder<int>(
                stream: cubit.statusDSCV.stream,
                builder: (context, snapshotbool) {
                  final dataType = snapshotbool.data ?? 0;
                  return ScrollBarWidget(
                    children: [
                      spaceH28,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 26),
                        child: BaseSearchBar(
                          hintText: S.current.tim_kiem_nhanh,
                          onChange: (value) {
                            cubit.search(value);
                          },
                        ),
                      ),
                      if (dataType == CVCB ||
                          dataType == CVQT ||
                          dataType == GCT ||
                          dataType == NCVM ||
                          dataType == DBX)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28),
                          child: StreamBuilder<List<TodoDSCVModel>>(
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
                              return expanTablet(
                                isOtherType:
                                    dataType == CVCB || dataType == NCVM,
                                isCheck: isCheck,
                                title: S.current.cong_viec_cua_ban,
                                count: data.length,
                                child: data.isNotEmpty
                                    ? ListView.builder(
                                        key: UniqueKey(),
                                        itemCount: data.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final todo = data[index];
                                          return CongViecCellTienIch(
                                            isTheEdit: dataType != DBX,
                                            text: todo.label ?? '',
                                            todoModel: todo,
                                            onCheckBox: (value) {
                                              cubit.editWork(
                                                todo: todo,
                                                isTicked: !todo.isTicked!,
                                              );
                                            },
                                            onStar: () {
                                              cubit.editWork(
                                                todo: todo,
                                                important: !todo.important!,
                                              );
                                            },
                                            onClose: () {
                                              showDiaLog(
                                                context,
                                                funcBtnRight: () {
                                                  cubit.editWork(
                                                    todo: todo,
                                                    inUsed: !todo.inUsed!,
                                                  );
                                                },
                                                icon: SvgPicture.asset(
                                                  ImageAssets.icDeleteLichHop,
                                                ),
                                                title: S.current.xoa_cong_viec,
                                                textContent: S.current
                                                    .ban_chac_chan_muon_xoa,
                                                btnLeftTxt: S.current.huy,
                                                btnRightTxt: S.current.xoa,
                                              );
                                            },
                                            onChange: (controller) {
                                              cubit.editWork(
                                                todo: todo,
                                              );
                                              cubit.titleChange =
                                                  controller.text;
                                            },
                                            onEdit: () {
                                              showDiaLogTablet(
                                                context,
                                                title:
                                                    S.current.ban_co_chac_muon,
                                                child: EditWidget(
                                                  cubit: cubit,
                                                  todo: todo,
                                                ),
                                                funcBtnOk: () {
                                                  cubit.editWork(todo: todo);
                                                },
                                                btnRightTxt: S.current.dong_y,
                                                btnLeftTxt: S.current.khong,
                                              );
                                            },
                                            enabled: !todo.isTicked!,
                                            isDaBiXoa: dataType == DBX,
                                          );
                                        },
                                      )
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: NodataWidget(),
                                      ),
                              );
                            },
                          ),
                        ),
                      if (dataType == CVCB ||
                          dataType == DHT ||
                          dataType == NCVM)
                        StreamBuilder<List<TodoDSCVModel>>(
                          stream: cubit.listDSCV.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data
                                    ?.where(
                                      (element) => element.isTicked == true,
                                    )
                                    .toList() ??
                                [];
                            return expanTablet(
                              isOtherType: dataType == CVCB || dataType == NCVM,
                              isCheck: isCheck2,
                              title: S.current.da_hoan_thanh,
                              count: data.length,
                              child: data.isNotEmpty
                                  ? Column(
                                      children:
                                          List.generate(data.length, (index) {
                                        final todo = data[index];
                                        return CongViecCellTienIch(
                                          enabled: false,
                                          todoModel: todo,
                                          onCheckBox: (value) {
                                            cubit.editWork(
                                              todo: todo,
                                              isTicked: !todo.isTicked!,
                                            );
                                          },
                                          onClose: () {
                                            showDiaLog(
                                              context,
                                              funcBtnRight: () {
                                                cubit.editWork(
                                                  todo: todo,
                                                  inUsed: !todo.inUsed!,
                                                );
                                              },
                                              icon: SvgPicture.asset(
                                                ImageAssets.icDeleteLichHop,
                                              ),
                                              title: S.current.xoa_cong_viec,
                                              textContent: S.current
                                                  .ban_chac_chan_muon_xoa,
                                              btnLeftTxt: S.current.huy,
                                              btnRightTxt: S.current.xoa,
                                            );
                                          },
                                          onStar: () {
                                            cubit.editWork(
                                              todo: todo,
                                              important: !todo.important!,
                                            );
                                          },
                                          text: todo.label ?? '',
                                        );
                                      }),
                                    )
                                  : const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: NodataWidget(),
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

  Widget expanTablet({
    required String title,
    required int count,
    required Widget child,
    required bool isCheck,
    bool isOtherType = false,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: toDayColor.withOpacity(0.5)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: isOtherType
              ? ExpansionTile(
                  initiallyExpanded: isCheck,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(
                        title,
                        style: textNormalCustom(
                          color: textTitle,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$count ${S.current.cong_viec}',
                        style: tokenDetailAmount(
                          color: infoColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22,
                        right: 26,
                        bottom: 28,
                      ),
                      child: child,
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: child,
                ),
        ),
      );
}
