import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/button/button_select_file.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
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

class CreatTodoOrUpdateWidget extends StatefulWidget {
  final bool? isCreat;
  final TodoDSCVModel? todo;
  final DanhSachCongViecTienIchCubit cubit;

  const CreatTodoOrUpdateWidget(
      {Key? key, required this.cubit, this.todo, this.isCreat})
      : super(key: key);

  @override
  _CreatTodoOrUpdateWidgetState createState() =>
      _CreatTodoOrUpdateWidgetState();
}

class _CreatTodoOrUpdateWidgetState
    extends State<CreatTodoOrUpdateWidget> {
  final TextEditingController tieuDeController = TextEditingController();
  final TextEditingController noteControler = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    widget.cubit.initDataNguoiTHucHienTextFild(widget.todo ?? TodoDSCVModel());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.dateChange = '';
    widget.cubit.noteChange = '';
    widget.cubit.titleChange = '';
  }

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
                  initialValue: widget.todo?.label ?? '',
                  title: S.current.tieu_de,
                  controller: tieuDeController,
                  validator: (String? value) {},
                  onChange: (String value) {
                    widget.cubit.titleChange = value;
                  },
                ),
                InputInfoUserWidget(
                  title: S.current.ngay_hoan_thanh,
                  child: SelectDate(
                    leadingIcon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(ImageAssets.icCalendar),
                    ),
                    key: UniqueKey(),
                    value: widget.cubit.dateChange.isEmpty
                        ? widget.todo?.createdOn ?? DateTime.now().toString()
                        : widget.cubit.dateChange,
                    onSelectDate: (value) {
                      widget.cubit.dateChange = value;
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
                StreamBuilder<NguoiThucHienModel>(
                  stream: widget.cubit.nguoiThucHienSubject,
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
                                snapshot.data?.dataAll() ?? '',
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
                                widget.cubit.nguoiThucHienSubject.add(
                                  NguoiThucHienModel(
                                    id: '',
                                    hoten: S.current.tim_theo_nguoi,
                                    donVi: [],
                                    chucVu: [],
                                  ),
                                );
                              },
                              child: snapshot.data?.hoten !=
                                      S.current.tim_theo_nguoi
                                  ? SvgPicture.asset(
                                      ImageAssets.icClose,
                                    )
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
                ButtonSelectFile(
                  title: S.current.them_tai_lieu_dinh_kem,
                  onChange: (files) {},
                ),
                ItemTextFieldWidgetDSNV(
                  initialValue: widget.todo?.note ?? '',
                  title: S.current.ghi_chu,
                  validator: (String? value) {},
                  onChange: (String value) {
                    widget.cubit.noteChange = value;
                  },
                  maxLine: 8,
                  controller: noteControler,
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
                      Navigator.pop(context);
                    },
                    onPressed2: () {
                      if (widget.isCreat ?? true) {
                        widget.cubit.addTodo();
                      } else {
                        widget.cubit.editWork(
                          todo: widget.todo ?? TodoDSCVModel(),
                        );
                      }

                      Navigator.pop(context);
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
