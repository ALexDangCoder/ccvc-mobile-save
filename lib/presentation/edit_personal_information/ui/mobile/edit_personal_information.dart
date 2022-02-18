import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/edit_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/avatar.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/custom_select_items_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditPersonInformationScreen extends StatefulWidget {
  final ManagerPersonalInformationModel managerPersonalInformationModel;

  const EditPersonInformationScreen({
    Key? key,
    required this.managerPersonalInformationModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPersonalInformationScreen();
}

class _EditPersonalInformationScreen
    extends State<EditPersonInformationScreen> {
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
    // TODO: implement initState
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
    // TODO: implement dispose
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        cubit.managerPersonalInformationModel.getInfoToMap();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: BaseAppBar(
        title: S.current.chinh_sua_thong_tin,
        leadingIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset(ImageAssets.icBack),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {
                nameController.text =
                    widget.managerPersonalInformationModel.hoTen ?? '';
                maCanBoController.text =
                    widget.managerPersonalInformationModel.maCanBo ?? '';
                thuTuController.text =
                    widget.managerPersonalInformationModel.thuTu.toString();
                cmndController.text =
                    widget.managerPersonalInformationModel.cmtnd ?? '';
                emailController.text =
                    widget.managerPersonalInformationModel.email ?? '';
                sdtCoquanController.text =
                    widget.managerPersonalInformationModel.phoneCoQuan ?? '';
                sdtController.text =
                    widget.managerPersonalInformationModel.phoneDiDong ?? '';
                diaChiLienHeController.text =
                    widget.managerPersonalInformationModel.diaChi ?? '';
                cubit.isCheckButtonReset.sink.add(
                  !cubit.isCheckButtonReset.value,
                );
                cubit.isCheckData();
              },
              child: Text(
                S.current.reset,
                style: textNormalCustom(fontSize: 14, color: labelColor),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FormGroup(
          key: keyGroup,
          child: Column(
            children: [
              InputInfoUserWidget(
                isObligatory: true,
                title: user.keys.elementAt(1),
                child: TextFieldValidator(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.current.khong_duoc_de_trong;
                    }
                    return null;
                  },
                ),
              ),
              InputInfoUserWidget(
                isObligatory: true,
                title: user.keys.elementAt(2),
                child: TextFieldValidator(
                  controller: maCanBoController,
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return S.current.khong_duoc_de_trong;
                    }
                    return null;
                  },
                ),
              ),
              InputInfoUserWidget(
                title: user.keys.elementAt(3),
                child: TextFieldValidator(
                  controller: thuTuController,
                ),
              ),
              StreamBuilder<bool>(
                stream: cubit.isCheckButtonReset,
                builder: (context, snapshot) {
                  return InputInfoUserWidget(
                    isObligatory: true,
                    title: user.keys.elementAt(4),
                    child: SelectDate(
                      key: UniqueKey(),
                      paddings: 10,
                      leadingIcon: SvgPicture.asset(ImageAssets.icEditInfor),
                      value: cubit.managerPersonalInformationModel.ngaySinh,
                      onSelectDate: (dateTime) {
                        cubit.selectBirthdayEvent(dateTime);
                      },
                    ),
                  );
                },
              ),
              InputInfoUserWidget(
                title: user.keys.elementAt(5),
                child: TextFieldValidator(
                  controller: cmndController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.current.khong_duoc_de_trong;
                    }
                    return null;
                  },
                ),
              ),
              StreamBuilder<bool>(
                stream: cubit.isCheckButtonReset,
                builder: (context, snapshot) {
                  return InputInfoUserWidget(
                    isObligatory: true,
                    title: user.keys.elementAt(6),
                    child: CustomDropDown(
                      value: cubit.managerPersonalInformationModel.gioiTinh ??
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
                  );
                },
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
              //
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
              StreamBuilder<bool>(
                stream: cubit.isCheckButtonReset,
                builder: (context, snapshot) {
                  return InputInfoUserWidget(
                    title: user.keys.elementAt(10),
                    child: CustomSelectItems(
                      title: S.current.tinh_thanh,
                      key: UniqueKey(),
                      value: cubit.managerPersonalInformationModel.tinh,
                      context: context,
                      items: cubit.fakeDataTinh,
                      onChange: (indexes) {
                        if (indexes >= 0) {
                          cubit.isCheckTinhSubject.sink.add(false);
                        }
                      },
                      onRemove: () {
                        cubit.isCheckTinhSubject.sink.add(true);
                        cubit.isCheckHuyenSubject.sink.add(true);
                      },
                      isCheckEnable: false,
                    ),
                  );
                },
              ),
              StreamBuilder<bool>(
                stream: cubit.isCheckTinhStream,
                builder: (context, snapshot) {
                  final snap = snapshot.data ?? true;
                  return Form(
                    child: InputInfoUserWidget(
                      title: user.keys.elementAt(11),
                      child: CustomSelectItems(
                        key: UniqueKey(),
                        value: cubit.managerPersonalInformationModel.huyen,
                        title: S.current.quan_huyen,
                        context: context,
                        items: cubit.fakeDataHuyen,
                        onChange: (indexes) {
                          if (indexes >= 0) {
                            cubit.isCheckHuyenSubject.sink.add(false);
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
                      child: CustomSelectItems(
                        key: UniqueKey(),
                        value: cubit.managerPersonalInformationModel.xa,
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
              spaceH20,
            //  WidgetDonVibMobile(cubit: ,),
              spaceH20,
           //   WidgetUngDungMobile(),
              spaceH20,
              AvatarAndSignature(
                editPersonalInformationCubit: EditPersonalInformationCubit(),
              ),
              spaceH20,
              ButtonCustomBottom(
                onPressed: () {
                  if (keyGroup.currentState!.validator()) {
                  } else {}
                },
                title: S.current.thay_doi,
                isColorBlue: true,
              ),
              spaceH32,
            ],
          ),
        ),
      ),
    );
  }
}
