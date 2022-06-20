import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/widgets/text/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';

import 'nguoi_gan_row_widget.dart';

class BottomSheetThemCongViec extends StatefulWidget {
  final DanhSachCongViecCubit danhSachCVCubit;

  const BottomSheetThemCongViec({Key? key, required this.danhSachCVCubit})
      : super(key: key);

  @override
  _BottomSheetThemCongViecState createState() =>
      _BottomSheetThemCongViecState();
}

class _BottomSheetThemCongViecState extends State<BottomSheetThemCongViec> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerCongViec = TextEditingController();
  ScrollController scrollController = ScrollController();
  final keyGroup = GlobalKey<FormGroupState>();
  bool isSelected = false;
  String label = '';
  String? nguoiGanID;
  String keySearch = '';

  @override
  void initState() {
    super.initState();
    widget.danhSachCVCubit.initListDataCanBo();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (widget.danhSachCVCubit.pageIndex <=
            widget.danhSachCVCubit.totalPage) {
          widget.danhSachCVCubit.pageIndex =
              widget.danhSachCVCubit.pageIndex + 1;
          if (widget.danhSachCVCubit.isSearching) {
            widget.danhSachCVCubit.getListNguoiGan(
              true,
              5,
              keySearch: keySearch,
            );
          }
          widget.danhSachCVCubit.getListNguoiGan(true, 5);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: FormGroup(
            key: keyGroup,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 8,
                  ),
                  child: Text(
                    S.current.cong_viec,
                    style: textNormalCustom(
                      color: titleItemEdit,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                TextFieldValidator(
                  controller: controllerCongViec,
                  hintText: S.current.nhap_cong_viec,
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return '${S.current.ban_phai_nhap_truong_nay} ';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 8,
                  ),
                  child: Text(
                    S.current.nguoi_thuc_hien,
                    style: textNormalCustom(
                      color: titleItemEdit,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                customTextField(
                  hintText: S.current.tim_theo_nguoi,
                  controller: controller,
                  suffixIcon: StreamBuilder<IconListCanBo>(
                    stream: widget.danhSachCVCubit.getIcon,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? IconListCanBo.DOWN;
                      final getShowIcon =
                          widget.danhSachCVCubit.getIconListCanBo(
                        data,
                        controller,
                      );
                      return GestureDetector(
                        onTap: () {
                          getShowIcon.onTapItem();
                        },
                        child: SizedBox(
                          width: 22,
                          child: Center(
                            child: getShowIcon.icon,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    if (controller.text.isEmpty || isSelected) {
                      widget.danhSachCVCubit.setDisplayListCanBo(true);
                      widget.danhSachCVCubit
                          .getIconListCanBo(IconListCanBo.DOWN, controller);
                    }
                  },
                  onChange: (value) {
                    keySearch = value;
                    Future.delayed(const Duration(seconds: 1), () {
                      widget.danhSachCVCubit.getListNguoiGan(true, 5,
                          keySearch: keySearch, notLoadMore: true,);
                    });
                  },
                ),
                StreamBuilder<bool>(
                    stream: widget.danhSachCVCubit.isShowListCanBo,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? false;
                      return Visibility(
                        visible: data,
                        child: SizedBox(
                          height: 200,
                          child: StreamBuilder<List<ItemRowData>>(
                            stream: widget.danhSachCVCubit.getDanhSachNguoiGan,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? [];
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        widget.danhSachCVCubit.inforCanBo
                                                .length - 1) {
                                      if (widget.danhSachCVCubit.inforCanBo
                                                  .length +
                                              1 ==
                                          widget.danhSachCVCubit.totalItem) {
                                        return const SizedBox();
                                      } else {
                                        // return const SizedBox();
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: AppTheme.getInstance()
                                                .primaryColor(),
                                          ),
                                        );
                                      }
                                    }

                                    return NguoiGanRowWidget(
                                      ontapItem: (String value) {
                                        controller.text = value;
                                        nguoiGanID = data[index].id ?? '';
                                        isSelected = true;
                                        widget.danhSachCVCubit
                                            .setDisplayListCanBo(false);
                                        widget.danhSachCVCubit.setDisplayIcon(
                                          IconListCanBo.CLOSE,
                                        );
                                      },
                                      inforNguoiGan: data[index].infor,
                                    );
                                  },
                                );
                              } else {
                                return const NodataWidget();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ButtonCustomBottom(
                          title: S.current.dong,
                          isColorBlue: false,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: ButtonCustomBottom(
                          title: S.current.them,
                          isColorBlue: true,
                          onPressed: () {
                            if (controllerCongViec.text.isEmpty) {
                              keyGroup.currentState!.validator();
                            } else {
                              label = controllerCongViec.text;
                              widget.danhSachCVCubit.addTodo(label, nguoiGanID);
                              Navigator.pop(context, false);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 33),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField({
  Widget? suffixIcon,
  Function()? onTap,
  String? hintText,
  Function(String text)? onChange,
  String? Function(String?)? validator,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    style: textNormal(titleColor, 14),
    onChanged: (value) {
      onChange != null ? onChange(value) : null;
    },
    onTap: () {
      onTap != null ? onTap() : null;
    },
    validator: (value) {
      if (validator != null) {
        return validator(value);
      }
    },
    decoration: InputDecoration(
      counterText: '',
      hintText: hintText ?? '',
      hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      suffixIcon: suffixIcon ?? const SizedBox(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: borderColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: borderColor),
      ),
    ),
  );
}
