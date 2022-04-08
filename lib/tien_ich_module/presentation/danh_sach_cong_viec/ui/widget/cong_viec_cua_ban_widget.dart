import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chinh_sua_widget.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'cell_dscv_tien_tich.dart';

class CvCuaBanWidget extends StatelessWidget {
  final DanhSachCongViecTienIchCubit cubit;

  const CvCuaBanWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<TodoListModelTwo>(
          stream: cubit.getTodoList,
          builder: (context, snapshot) {
            final data = snapshot.data?.listTodoImportant ?? <TodoDSCVModel>[];
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
                        textContent: S.current.ban_chac_chan_muon_xoa,
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
            StreamBuilder<TodoListModelTwo>(
              stream: cubit.getTodoList,
              builder: (context, snapshot) {
                final data = snapshot.data?.listTodoDone ?? <TodoDSCVModel>[];
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
                            textContent: S.current.ban_chac_chan_muon_xoa,
                            btnLeftTxt: S.current.huy,
                            btnRightTxt: S.current.xoa,
                          );
                        },
                        onStar: () {
                          cubit.tickerQuanTrongTodo(todo);
                        },
                        text: todo.label ?? '',
                        onEdit: () {},
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
    );
  }
}
