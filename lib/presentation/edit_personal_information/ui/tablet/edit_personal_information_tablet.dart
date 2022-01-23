import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/edit_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/widget/avatar_tablet.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/widget/custom_select_items_tablet.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/double_button_edit_seen.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_don_vi.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_ung_dung.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EditPersonInformationTabletScreen extends StatefulWidget {
  final ManagerPersonalInformationModel managerPersonalInformationModel;

  const EditPersonInformationTabletScreen({
    Key? key,
    required this.managerPersonalInformationModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPersonalInformationTabletScreen();
}

class _EditPersonalInformationTabletScreen
    extends State<EditPersonInformationTabletScreen> {
  EditPersonalInformationCubit cubit = EditPersonalInformationCubit();
  TextEditingController nameController = TextEditingController();
  TextEditingController maCanBoController = TextEditingController();
  TextEditingController thuTuController = TextEditingController();
  TextEditingController cmndController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sdtCoquanController = TextEditingController();
  TextEditingController sdtController = TextEditingController();
  TextEditingController diaChiLienHeController = TextEditingController();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  void initState() {
    cubit.getCurrentUnit(widget.managerPersonalInformationModel);
    nameController.text = widget.managerPersonalInformationModel.hoTen ?? '';
    maCanBoController.text =
        widget.managerPersonalInformationModel.maCanBo ?? '';
    thuTuController.text =
        widget.managerPersonalInformationModel.thuTu.toString();
    cmndController.text = widget.managerPersonalInformationModel.cmtnd ?? '';
    emailController.text = widget.managerPersonalInformationModel.email ?? '';
    sdtCoquanController.text =
        widget.managerPersonalInformationModel.phoneCoQuan ?? '';
    sdtController.text =
        widget.managerPersonalInformationModel.phoneDiDong ?? '';
    diaChiLienHeController.text =
        widget.managerPersonalInformationModel.diaChi ?? '';
    super.initState();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        cubit.managerPersonalInformationModel.getInfoToMap();
    return Scaffold(
      backgroundColor: bgManagerColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(S.current.chinh_sua_thong_tin),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColorApp,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderItemCalender.withOpacity(0.5)),
          ),
          margin:
              const EdgeInsets.only(top: 28, left: 30, right: 30, bottom: 30),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FormGroup(
            key: keyGroup,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InputInfoUserWidget(
                            isObligatory: true,
                            title: user.keys.elementAt(1),
                            child: TextFieldValidator(
                              controller: nameController,
                              validator: (value) {
                                return value?.checkNull();
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            isObligatory: true,
                            title: user.keys.elementAt(2),
                            child: TextFieldValidator(
                              controller: maCanBoController,
                              validator: (value) {
                                return value?.checkNull();
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(3),
                            child: TextFormFieldWidget(
                              controller: thuTuController,
                              isEnabled: true,
                            ),
                          ),
                          InputInfoUserWidget(
                            isObligatory: true,
                            title: user.keys.elementAt(4),
                            child: CustomSelectDate(
                              value: cubit
                                  .managerPersonalInformationModel.ngaySinh,
                              onSelectDate: (dateTime) {
                                cubit.selectBirthdayEvent(dateTime.toString());
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(5),
                            child: TextFieldValidator(
                              controller: cmndController,
                              validator: (value) {
                                return value?.checkNull();
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            isObligatory: true,
                            title: user.keys.elementAt(6),
                            child: CustomDropDown(
                              value: cubit.managerPersonalInformationModel
                                          .gioiTinh ??
                                      false
                                  ? S.current.Nam
                                  : S.current.Nu,
                              items: cubit.fakeDataGioiTinh,
                              onSelectItem: (value) {
                                if (value == 0) {
                                  cubit.selectGTEvent(true);
                                } else {
                                  cubit.selectGTEvent(false);
                                }
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(7),
                            child: TextFieldValidator(
                              controller: emailController,
                              validator: (value) {
                                return value!.checkEmail();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceW28,
                    Expanded(
                      child: Column(
                        children: [
                          InputInfoUserWidget(
                            title: user.keys.elementAt(8),
                            child: TextFieldValidator(
                              controller: sdtCoquanController,
                              textInputType: TextInputType.number,
                              validator: (value) {
                                return value!.checkSdt();
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(9),
                            child: TextFieldValidator(
                              controller: sdtController,
                              textInputType: TextInputType.number,
                              validator: (value) {
                                return value!.checkSdt();
                              },
                            ),
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(10),
                            child: CustomSelectItemsTablet(
                              title: S.current.tinh_thanh,
                              context: context,
                              items: cubit.fakeDataTinh,
                              onChange: (indexes) {
                                if (indexes >= 0) {
                                  setState(() {
                                    // cubit.isCheckH(false);
                                    cubit.isCheckTinhSubject.sink.add(false);
                                  });
                                }
                              },
                              onRemove: () {
                                cubit.isCheckTinhSubject.sink.add(true);
                                cubit.isCheckHuyenSubject.sink.add(true);
                              },
                              isCheckEnable: false,
                            ),
                          ),
                          StreamBuilder<bool>(
                            stream: cubit.isCheckTinhStream,
                            builder: (context, snapshot) {
                              final snap = snapshot.data ?? true;
                              return Form(
                                child: InputInfoUserWidget(
                                  title: user.keys.elementAt(11),
                                  child: CustomSelectItemsTablet(
                                    key: UniqueKey(),
                                    title: S.current.quan_huyen,
                                    context: context,
                                    items: cubit.fakeDataHuyen,
                                    onChange: (indexes) {
                                      if (indexes >= 0) {
                                        cubit.isCheckHuyenSubject.sink
                                            .add(false);
                                      }
                                    },
                                    onRemove: () {
                                      cubit.isCheckHuyenSubject.sink.add(true);
                                    },
                                    isCheckEnable: snap,
                                  ),
                                ),
                              );
                            },
                          ),
                          StreamBuilder<bool>(
                            stream: cubit.isCheckHuyenStream,
                            builder: (context, snapshot) {
                              final snap = snapshot.data ?? true;
                              return Form(
                                child: InputInfoUserWidget(
                                  title: user.keys.elementAt(12),
                                  child: CustomSelectItemsTablet(
                                    key: UniqueKey(),
                                    title: S.current.phuong_xa,
                                    context: context,
                                    items: cubit.fakeDataTinh,
                                    onChange: (indexes) {},
                                    isCheckEnable: snap,
                                  ),
                                ),
                              );
                            },
                          ),
                          InputInfoUserWidget(
                            title: user.keys.elementAt(13),
                            child: TextFormFieldWidget(
                              controller: diaChiLienHeController,
                              isEnabled: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                spaceH28,
                Container(
                  height: 1,
                  color: borderItemCalender,
                ),
                spaceH28,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: borderItemCalender.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: borderItemCalender),
                        ),
                        child: const WidgetDonVi(),
                      ),
                    ),
                    spaceW28,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: borderItemCalender.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: borderItemCalender),
                        ),
                        child: const WidgetUngDung(),
                      ),
                    )
                  ],
                ),
                spaceH28,
                Container(
                  height: 1,
                  color: borderItemCalender,
                ),
                spaceH28,
                AvatarAndSignatureTablet(
                  editPersonalInformationCubit: EditPersonalInformationCubit(),
                ),
                spaceH48,
                DoubleButtonEditScreen(
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  onPressed2: () {
                    if (keyGroup.currentState!.validator()) {
                    } else {}
                  },
                  title1: S.current.huy,
                  title2: S.current.thay_doi,
                ),
                spaceH32,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
