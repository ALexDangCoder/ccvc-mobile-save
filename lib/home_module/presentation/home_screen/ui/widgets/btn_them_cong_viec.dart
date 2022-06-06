import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'nguoi_gan_row_widget.dart';

class BottomSheetThemCongViec extends StatefulWidget {


  const BottomSheetThemCongViec({Key? key})
      : super(key: key);

  @override
  _BottomSheetThemCongViecState createState() =>
      _BottomSheetThemCongViecState();
}

class _BottomSheetThemCongViecState extends State<BottomSheetThemCongViec> {
  TextEditingController controller = TextEditingController();
  DanhSachCongViecCubit danhSachCVCubit =DanhSachCongViecCubit();
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    danhSachCVCubit.getListNguoiGan(1, 999, true);
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
          controller: controller,
          suffixIcon: StreamBuilder<IconListCanBo>(
            stream: danhSachCVCubit.getIcon,
            builder: (context, snapshot) {
              final data = snapshot.data ?? IconListCanBo.DOWN;
              final getShowIcon =danhSachCVCubit.getIconListCanBo(
                  data, controller,);
              return GestureDetector(
                child: getShowIcon.icon,
                onTap: (){
                  getShowIcon.onTapItem();
                },
              );
            },
          ),
          onTap: () {
            if (controller.text.isEmpty || isSelected) {
              danhSachCVCubit.setDisplayListCanBo(true);
            }
          },
        ),
        StreamBuilder<bool>(
            stream: danhSachCVCubit.isShowListCanBo,
            builder: (context, snapshot) {
              final data = snapshot.data ?? false;
              return Visibility(
                visible: data,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return NguoiGanRowWidget(
                        ontapItem: (String value) {
                          controller.text = value;
                          isSelected = true;
                          danhSachCVCubit.setDisplayListCanBo(false);
                          danhSachCVCubit.setDisplayIcon(IconListCanBo.CLOSE);
                        },
                        nguoiGan: NguoiGanModel(
                          text2: 'text 2  index${index}',
                          text1: 'text 1  index${index}',
                          text3: 'text 3 index${index}',
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
        const SizedBox(height: 200),
      ],
    );
  }
}

Widget customTextField({
  Widget? suffixIcon,
  Function()? onTap,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    onChanged: (value) {},
    onTap: () {
      onTap!();
    },
    decoration: InputDecoration(
      counterText: '',
      hintText: 'Nhap cong viec',
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
    ),
  );
}
