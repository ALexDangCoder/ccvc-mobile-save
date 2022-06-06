import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/btn_them_cong_viec.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/todo_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/cong_viec_cell.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/widgets/text/dialog/show_dialog.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class WorkListWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const WorkListWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _WorkListWidgetState createState() => _WorkListWidgetState();
}

class _WorkListWidgetState extends State<WorkListWidget> {
  late HomeCubit cubit;
  DanhSachCongViecCubit danhSachCVCubit = DanhSachCongViecCubit();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    danhSachCVCubit.getToDoList();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        danhSachCVCubit.getToDoList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      spacingTitle: 0,
      paddingChild: const EdgeInsets.only(top: 20),
      title: S.current.work_list,
      urlIcon: ImageAssets.icPlus,
      onTapIcon: () {
        // HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
        showBottomSheetCustom(
          context,
          child: const BottomSheetThemCongViec(),
          title: S.current.them_cong_viec,
        );
      },
      isCustomDialog: true,
      // dialogSelect: DialogSettingWidget(
      //   type: widget.homeItemType,
      //   customDialog: AddToDoWidget(
      //     onTap: (value) {
      //       cubit.closeDialog();
      //       danhSachCVCubit.addTodo(value);
      //     },
      //   ),
      // ),
      child: LoadingOnly(
        stream: danhSachCVCubit.stateStream,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<TodoListModel>(
              stream: danhSachCVCubit.getTodoList,
              builder: (context, snapshot) {
                final data = snapshot.data?.listTodoImportant ?? <TodoModel>[];
                if (data.isNotEmpty) {
                  return Column(
                    key: UniqueKey(),
                    children: List.generate(data.length, (index) {
                      final todo = data[index];
                      return CongViecCell(
                        text: todo.label ?? '',
                        todoModel: todo,
                        onCheckBox: (value) {
                          danhSachCVCubit.tickerListWord(
                            todo: todo,
                            removeDone: false,
                          );
                        },
                        onStar: () {
                          danhSachCVCubit.tickerQuanTrongTodo(
                            todo,
                            removeDone: false,
                          );
                        },
                        onClose: () {
                          showDiaLog(
                            context,
                            funcBtnRight: () {
                              danhSachCVCubit.deleteCongViec(
                                todo,
                                removeDone: false,
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
                        onChange: (controller) {
                          danhSachCVCubit.changeLabelTodo(
                            controller.text.trim(),
                            todo,
                          );
                        },
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
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.da_hoan_thanh,
                  style: textNormalCustom(fontSize: 14, color: infoColor),
                ),
                StreamBuilder<TodoListModel>(
                  stream: danhSachCVCubit.getTodoList,
                  builder: (context, snapshot) {
                    final data = snapshot.data?.listTodoDone ?? <TodoModel>[];
                    if (data.isNotEmpty) {
                      return Column(
                        key: UniqueKey(),
                        children: List.generate(data.length, (index) {
                          final todo = data[index];
                          return CongViecCell(
                            enabled: false,
                            todoModel: todo,
                            onCheckBox: (value) {
                              danhSachCVCubit.tickerListWord(todo: todo);
                            },
                            onClose: () {
                              showDiaLog(
                                context,
                                funcBtnRight: () {
                                  danhSachCVCubit.deleteCongViec(todo);
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
                            onStar: () {
                              danhSachCVCubit.tickerQuanTrongTodo(todo);
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddToDoWidget extends StatefulWidget {
  final Function(String) onTap;

  const AddToDoWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  _AddToDoWidgetState createState() => _AddToDoWidgetState();
}

class _AddToDoWidgetState extends State<AddToDoWidget> {
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
                  activeColor: !isAdd
                      ? sideTextInactiveColor
                      : AppTheme.getInstance().colorSelect(),
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

