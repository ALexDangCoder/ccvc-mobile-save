import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/dialog_them_cong_viec.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/todo_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/cong_viec_cell.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/widgets/text/dialog/show_dialog.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class WorkListTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const WorkListTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _WorkListWidgetState createState() => _WorkListWidgetState();
}

class _WorkListWidgetState extends State<WorkListTabletWidget> {
  late HomeCubit cubit;
  String? nguoiGanID;
  DanhSachCongViecCubit danhSachCVCubit = DanhSachCongViecCubit();
  TextEditingController controllerCongViec = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

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
    danhSachCVCubit.callApi();
    danhSachCVCubit.getToDoList();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        danhSachCVCubit.getToDoList();
      });
    });
    _handleEventBus();
  }

  void _handleEventBus() {
    eventBus.on<CallBackNguoiGan>().listen((event) {
      nguoiGanID = event.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      paddingChild: const EdgeInsets.only(top: 20),
      title: S.current.work_list,
      maxHeight: 415,
      minHeight: 415,
      urlIcon: ImageAssets.icPlus,
      onTapIcon: () {
        showDiaLogTablet(
          context,
          child: DiaLogThemCongViec(
            keyGroup: keyGroup,
            controllerCongViec: controllerCongViec,
            danhSachCVCubit: danhSachCVCubit,
          ),
          title: S.current.them_cong_viec,
          funcBtnOk: () {
            if (controllerCongViec.text.isEmpty) {
              keyGroup.currentState!.validator();
            } else {
              final String label = controllerCongViec.text;
              danhSachCVCubit.addTodo(label, nguoiGanID);
              Navigator.pop(context, false);
            }
          },
        ).then((value) {
          danhSachCVCubit.setDisplayIcon(
            IconListCanBo.DOWN,
          );
          danhSachCVCubit.setDisplayListCanBo(false);
        });
      },
      isCustomDialog: true,
      child: LoadingOnly(
        stream: danhSachCVCubit.stateStream,
        child: ScrollBarWidget(
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
                        nguoiGan: danhSachCVCubit.listTempName[todo.id] ?? '',
                        text: todo.label ?? '',
                        todoModel: todo,
                        onCheckBox: (value) {
                          danhSachCVCubit.tickerListWord(
                              todo: todo, removeDone: false);
                        },
                        onStar: () {
                          danhSachCVCubit.tickerQuanTrongTodo(todo,
                              removeDone: false);
                        },
                        onClose: () {
                          showDiaLog(
                            context,
                            funcBtnRight: () {
                              danhSachCVCubit.deleteCongViec(todo,
                                  removeDone: false);
                            },
                            showTablet: true,
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
                            nguoiGan: '',
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
                                showTablet: true,
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
                      : AppTheme.getInstance().colorField(),
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
