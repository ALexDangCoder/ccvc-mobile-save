import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/widgets/text/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'nguoi_gan_row_widget.dart';

class BottomSheetThemCongViec extends StatefulWidget {
  const BottomSheetThemCongViec({Key? key}) : super(key: key);

  @override
  _BottomSheetThemCongViecState createState() =>
      _BottomSheetThemCongViecState();
}

class _BottomSheetThemCongViecState extends State<BottomSheetThemCongViec> {
  TextEditingController controller = TextEditingController();
  DanhSachCongViecCubit danhSachCVCubit = DanhSachCongViecCubit();
  bool isSelected = false;
  String label = '';
  String nguoiGanID = '';

  @override
  void initState() {
    super.initState();
    danhSachCVCubit.getListNguoiGan(1, 9999, true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        customTextField(
          hintText: S.current.nhap_cong_viec,
          onChange: (value) {
            label = value;
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
            suffixIcon: SizedBox(
              width: 12,
              height: 12,
              child: StreamBuilder<IconListCanBo>(
                stream: danhSachCVCubit.getIcon,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? IconListCanBo.DOWN;
                  final getShowIcon = danhSachCVCubit.getIconListCanBo(
                    data,
                    controller,
                  );
                  return GestureDetector(
                    child: getShowIcon.icon,
                    onTap: () {
                      getShowIcon.onTapItem();
                    },
                  );
                },
              ),
            ),
            onTap: () {
              if (controller.text.isEmpty || isSelected) {
                danhSachCVCubit.setDisplayListCanBo(true);
              }
            },
            onChange: (value) {
              Future.delayed(const Duration(seconds: 1), () {
                danhSachCVCubit.searchNguoiGan(value);
              });
            }),
        StreamBuilder<bool>(
            stream: danhSachCVCubit.isShowListCanBo,
            builder: (context, snapshot) {
              final data = snapshot.data ?? false;
              return Visibility(
                visible: data,
                child: SizedBox(
                  height: 200,
                  child: StreamBuilder<List<ItemRowData>>(
                    stream: danhSachCVCubit.getDanhSachNguoiGan,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return NguoiGanRowWidget(
                              ontapItem: (String value) {
                                controller.text = value;
                                nguoiGanID = data[index].id ?? '';
                                isSelected = true;
                                danhSachCVCubit.setDisplayListCanBo(false);
                                danhSachCVCubit.setDisplayIcon(
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
                    danhSachCVCubit.addTodo(label, nguoiGanID);
                    // Navigator.pop(context, false);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget customTextField({
  Widget? suffixIcon,
  Function()? onTap,
  String? hintText,
  Function(String text)? onChange,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    onChanged: (value) {
      onChange != null ? onChange(value) : null;
    },
    onTap: () {
      onTap != null ? onTap() : null;
    },
    decoration: InputDecoration(
      counterText: '',
      hintText: hintText ?? '',
      hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      suffixIcon: suffixIcon ?? const SizedBox(),
      // prefixIcon: widget.prefixIcon,
      // fillColor: widget.isEnabled
      //     ? widget.fillColor ?? Colors.transparent
      //     : borderColor.withOpacity(0.3),
      // filled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: borderColor),
      ),
    ),
  );
}
