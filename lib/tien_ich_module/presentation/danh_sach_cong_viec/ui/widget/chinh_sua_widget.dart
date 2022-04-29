import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/chon_nguoi_thuc_hien_screen.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/customTextFieldVersion2.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditWidget extends StatefulWidget {
  final TodoDSCVModel todo;
  final DanhSachCongViecTienIchCubit cubit;

  const EditWidget({Key? key, required this.cubit, required this.todo})
      : super(key: key);

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  final TextEditingController tieuDeController = TextEditingController();
  final TextEditingController nguoiThucHienController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemTextFieldWidgetDSNV(
                  initialValue: widget.todo.label ?? '',
                  title: S.current.tieu_de,
                  controller: tieuDeController,
                  validator: (String? value) {},
                  onChange: (String value) {
                    widget.cubit.getTitle(value);
                  },
                ),
                InputInfoUserWidget(
                  title: S.current.ngay_hoan_thanh,
                  child: SelectDate(
                    hintText: DateTime.parse(
                      widget.todo.createdOn ?? DateTime.now().toString(),
                    ).toStringWithListFormat,
                    onSelectDate: (value) {
                      widget.cubit.getDate(value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.current.nguoi_thuc_hien,
                  style: textNormalCustom(
                    color: titleItemEdit,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                StreamBuilder<bool>(
                  stream: widget.cubit.getEnabled,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChonNguoiThucHienScreen(
                              cubit: widget.cubit,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                              border: Border.all(
                                color: borderColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 14,
                                bottom: 14,
                                right: 30,
                              ),
                              child: Text(
                                snapshot.data == true
                                    ? (widget.cubit.person.isEmpty
                                        ? widget.cubit.convertIdToPerson(
                                            widget.todo.performer ?? '',
                                          )
                                        : widget.cubit.person)
                                    : (widget.cubit.person.isEmpty)
                                        ? S.current.tim_theo_nguoi
                                        : widget.cubit.person,
                                style: textNormalCustom(
                                  color: titleItemEdit,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0.textScale(),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 14,
                            top: 14,
                            bottom: 14,
                            child: GestureDetector(
                              onTap: () {
                                widget.cubit.enabled.sink.add(false);
                                widget.cubit
                                    .getPersontodo(person: '', idPerson: '');
                                setState(() {});
                              },
                              child: snapshot.data == true
                                  ? (widget.cubit.person != ''
                                      ? Container(
                                          color: Colors.transparent,
                                          child: SvgPicture.asset(
                                            ImageAssets.icClose,
                                          ),
                                        )
                                      : const SizedBox())
                                  : const SizedBox(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ItemTextFieldWidgetDSNV(
                  initialValue: widget.todo.note ?? '',
                  title: S.current.ghi_chu,
                  validator: (String? value) {},
                  onChange: (String value) {
                    widget.cubit.getnote(value);
                  },
                  maxLine: 8,
                  controller: tieuDeController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: APP_DEVICE == DeviceType.MOBILE
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 100),
                  child: DoubleButtonBottom(
                    title1: S.current.dong,
                    title2: S.current.luu,
                    onPressed1: () {
                      widget.cubit.person = '';
                      Navigator.pop(context);
                    },
                    onPressed2: () {
                      Navigator.pop(context);
                      widget.cubit.editWork(todo: widget.todo);
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
