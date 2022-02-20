import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/cong_viec_cell.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkListTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const WorkListTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _WorkListWidgetState createState() => _WorkListWidgetState();
}

class _WorkListWidgetState extends State<WorkListTabletWidget> {
  late HomeCubit cubit;
  DanhSachCongViecCubit danhSachCVCubit = DanhSachCongViecCubit();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
    danhSachCVCubit.getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      paddingChild: const EdgeInsets.only(top: 20),
      title: S.current.work_list,
      maxHeight: 415,
      urlIcon: ImageAssets.icPlus,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        customDialog: AddToDoWidget(
          onTap: (value) {
            cubit.closeDialog();
            danhSachCVCubit.addTodo(value);
          },
        ),
      ),
      child: Flexible(
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
                        onClose: () {},
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
                            onClose: () {},
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
                  color: AppTheme.getInstance().titleColor(),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  checkColor: Colors.white, // color of tick Mark
                  activeColor: !isAdd ? sideTextInactiveColor : indicatorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: const BorderSide(width: 1.5, color: lineColor),
                  value: true,
                  onChanged: (value) {
                    if (isAdd) {
                      widget.onTap(controller.text.trim());
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
