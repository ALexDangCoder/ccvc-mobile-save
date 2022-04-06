import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/mobile/danh_sach_cong_viec_tien_ich_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_dscv_tien_tich.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chinh_sua_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
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
  bool isCheck = false;
  bool isChecks = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getToDoList();
    cubit.listNguoiThucHien();
    cubit.getNHomCVMoi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgQLVBTablet,
        title: S.current.danh_sach_cong_viec,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuDSCV(
                    cubit: cubit,
                    theoDangLich: () {},
                    TheoDangDanhSach: () {},
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: ScrollBarWidget(
        children: [
          const SizedBox(
            height: 28,
          ),
          BaseSearchBar(
            hintText: S.current.tim_kiem_nhanh,
            onChange: (value) {
              cubit.search(value);
            },
          ),
          const SizedBox(
            height: 26,
          ),
          StreamBuilder<TodoListModel>(
            stream: cubit.getTodoList,
            builder: (context, snapshot) {
              final data = snapshot.data?.listTodoImportant ?? <TodoModel>[];
              if (data.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: toDayColor.withOpacity(0.5)),
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: isCheck
                            ? RotatedBox(
                                quarterTurns: 2,
                                child: SvgPicture.asset(
                                  ImageAssets.icDropDown,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 28),
                                child: SvgPicture.asset(ImageAssets.icDropDown),
                              ),
                      ),
                      onExpansionChanged: (value) {
                        isCheck = value;
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Row(
                        children: [
                          Text(
                            S.current.danh_sach_cong_viec,
                            style: textNormalCustom(
                              color: textTitle,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${data.length} ${S.current.cong_viec}',
                            style: tokenDetailAmount(
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                          SvgPicture.asset(
                            ImageAssets.icBacham,
                          )
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            Text(
                              '${DateTime.parse(data.first.createdOn ?? DateTime.now().toString()).toStringWithListFormat} -'
                              ' ${DateTime.parse(data.last.createdOn ?? DateTime.now().toString()).toStringWithListFormat}',
                              style: tokenDetailAmount(
                                color: infoColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 26,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                S.current.chon_ngay,
                                style: textNormalCustom(
                                  color: dangXyLyColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 22,
                            right: 26,
                            bottom: 28,
                          ),
                          child: ListView.builder(
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
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.transparent,
                  child: Text(
                    S.current.khong_co_du_lieu,
                    style: textDetailHDSD(
                      fontSize: 16,
                      color: textTitle,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 28,
          ),
          StreamBuilder<TodoListModel>(
            stream: cubit.getTodoList,
            builder: (context, snapshot) {
              final data = snapshot.data?.listTodoDone ?? <TodoModel>[];
              if (data.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: toDayColor.withOpacity(0.5)),
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: Container(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: isChecks
                            ? RotatedBox(
                                quarterTurns: 2,
                                child: SvgPicture.asset(
                                  ImageAssets.icDropDown,
                                ),
                              )
                            : SvgPicture.asset(ImageAssets.icDropDown),
                      ),
                      onExpansionChanged: (value) {
                        isChecks = value;
                        setState(() {
                          isChecks = !isChecks;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Row(
                        children: [
                          Text(
                            S.current.da_hoan_thanh,
                            style: textNormalCustom(
                              color: textTitle,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${data.length} ${S.current.cong_viec}',
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
                          child: Column(
                            key: UniqueKey(),
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
                                onEdit: () {},
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Colors.transparent,
                  child: Text(
                    S.current.khong_co_du_lieu,
                    style: textDetailHDSD(
                      fontSize: 16,
                      color: textTitle,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 28,
          ),
        ],
      ),
    );
  }
}
