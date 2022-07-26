import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';

import 'nguoi_gan_row_widget.dart';

class DiaLogThemCongViec extends StatefulWidget {
  final DanhSachCongViecCubit danhSachCVCubit;
  final TextEditingController controllerCongViec;
  final GlobalKey<FormGroupState> keyGroup;

  const DiaLogThemCongViec({
    Key? key,
    required this.danhSachCVCubit,
    required this.controllerCongViec,
    required this.keyGroup,
  }) : super(key: key);

  @override
  _DiaLogThemCongViecState createState() => _DiaLogThemCongViecState();
}

class _DiaLogThemCongViecState extends State<DiaLogThemCongViec> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
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
        widget.danhSachCVCubit.loadMoreListNguoiGan(keySearch);
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
            key: widget.keyGroup,
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
                  controller: widget.controllerCongViec,
                  hintText: S.current.nhap_cong_viec,
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return '${S.current.vui_long_nhap_cong_viec} ';
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
                      widget.danhSachCVCubit.getListNguoiGan(
                        true,
                        5,
                        keySearch: keySearch,
                        notLoadMore: true,
                      );
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
                                    return widget.danhSachCVCubit
                                        .setIconLoadMore(
                                      index,
                                      NguoiGanRowWidget(
                                        ontapItem: (String value) {
                                          eventBus.fire(
                                            CallBackNguoiGan(
                                              data[index].id ?? '',
                                            ),
                                          );
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
                                      ),
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Expanded(
                //         child: ButtonCustomBottom(
                //           title: S.current.dong,
                //           isColorBlue: false,
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 16,
                //       ),
                //       Expanded(
                //         child: ButtonCustomBottom(
                //           title: S.current.them,
                //           isColorBlue: true,
                //           onPressed: () {
                //             if (controllerCongViec.text.isEmpty) {
                //               keyGroup.currentState!.validator();
                //             } else {
                //               label = controllerCongViec.text;
                //               widget.danhSachCVCubit.addTodo(label, nguoiGanID);
                //               Navigator.pop(context, false);
                //             }
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 33),
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
