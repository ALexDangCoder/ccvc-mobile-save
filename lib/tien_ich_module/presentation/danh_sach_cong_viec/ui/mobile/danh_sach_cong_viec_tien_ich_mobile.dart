import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chinh_sua_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/nhom_cong_viec_moi_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return StreamBuilder<String>(
      stream: cubit.titleAppBar.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBarWithTwoLeading(
            title: snapshot.data ?? S.current.cv_cua_ban,
            leadingIcon: Row(
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
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: SvgPicture.asset(ImageAssets.ic_Group),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: AddToDoWidgetTienIch(
                      onTap: (value) {
                        cubit.addTodo(value);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
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
              )
            ],
          ),
          body: StreamBuilder<int>(
            stream: cubit.statusDSCV.stream,
            builder: (context, snapshotbool) {
              final dataType = snapshotbool.data ?? 0;
              return ScrollBarWidget(
                children: [
                  BaseSearchBar(
                    hintText: S.current.tim_kiem_nhanh,
                    onChange: (value) {
                      cubit.search(value);
                    },
                  ),
                  if (dataType == CVCB || dataType == CVQT || dataType == GCT)
                    StreamBuilder<List<TodoDSCVModel>>(
                      stream: cubit.listDSCV.stream,
                      builder: (context, snapshot) {
                        final data = snapshot.data
                                ?.where((element) => element.isTicked == false)
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
                                isTheEdit: true,
                                text: todo.label ?? '',
                                todoModel: todo,
                                onCheckBox: (value) {
                                  cubit.tickerListWord(
                                    todo: todo,
                                    removeDone: false,
                                  );
                                },
                                onStar: () {
                                  cubit.tickerQuanTrongTodo(
                                    todo,
                                    removeDone: false,
                                  );
                                },
                                onClose: () {
                                  showDiaLog(
                                    context,
                                    funcBtnRight: () {
                                      cubit.deleteCongViec(
                                        todo,
                                        removeDone: false,
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
                                  cubit.changeLabelTodo(
                                    controller.text.trim(),
                                    todo,
                                  );
                                },
                                onEdit: () {
                                  showBottomSheetCustom(
                                    context,
                                    title: S.current.chinh_sua,
                                    child: EditWidget(
                                      cubit: cubit,
                                      todo: todo,
                                    ),
                                  );
                                },
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
                  if (dataType == CVCB || dataType == DHT)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (dataType == CVCB)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              S.current.da_hoan_thanh,
                              style: textNormalCustom(
                                  fontSize: 14, color: infoColor),
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
                                children: List.generate(data.length, (index) {
                                  final todo = data[index];
                                  return CongViecCellTienIch(
                                    enabled: false,
                                    todoModel: todo,
                                    onCheckBox: (value) {
                                      cubit.tickerListWord(todo: todo);
                                    },
                                    onClose: () {
                                      showDiaLog(
                                        context,
                                        funcBtnRight: () {
                                          cubit.deleteCongViec(todo);
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
                                    onStar: () {
                                      cubit.tickerQuanTrongTodo(todo);
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
                  if (dataType == DBX)
                    StreamBuilder<List<TodoDSCVModel>>(
                      stream: cubit.listDSCV.stream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        if (data.isNotEmpty) {
                          return Column(
                            children: List.generate(data.length, (index) {
                              final todo = data[index];
                              return CongViecCellTienIch(
                                todoModel: todo,
                                onCheckBox: (value) {
                                  cubit.tickerListWord(todo: todo);
                                },
                                text: todo.label ?? '',
                                isDaBiXoa: true,
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
                  if (snapshotbool.data == NCXM)
                    NhomCvMoiWidget(
                      cubit: cubit,
                    )
                  // if (snapshotbool.data == CVCB)
                  //   CvCuaBanWidget(
                  //     cubit: cubit,
                  //   ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class AddToDoWidgetTienIch extends StatefulWidget {
  final Function(String) onTap;

  const AddToDoWidgetTienIch({Key? key, required this.onTap}) : super(key: key);

  @override
  _AddToDoWidgetTienIchState createState() => _AddToDoWidgetTienIchState();
}

class _AddToDoWidgetTienIchState extends State<AddToDoWidgetTienIch> {
  bool isAdd = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.them_cong_viec,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  checkColor: Colors.white,
                  // color of tick Mark
                  activeColor: !isAdd ? sideTextInactiveColor : indicatorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: const BorderSide(width: 1.5, color: lineColor),
                  value: true,
                  onChanged: (value) {
                    if (isAdd) {
                      widget.onTap(controller.text.trim());
                      controller.text = '';
                      focusNode.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: borderButtomColor)),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: (value) {
                if (value.isEmpty) {
                  isAdd = false;
                } else {
                  isAdd = true;
                }
                setState(() {});
              },
              style: textNormal(infoColor, 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconConstraints:
                    const BoxConstraints(maxWidth: 25, maxHeight: 14),
                prefixIcon: Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      ImageAssets.icEdit,
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
