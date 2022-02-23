import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/custom_select_tinh.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/widget/avatar_tablet.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/double_button_edit_seen.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/manager_provider.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditPersonInformationTabletScreen extends StatefulWidget {
  final String id;

  const EditPersonInformationTabletScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPersonalInformationTabletScreen();
}

class _EditPersonalInformationTabletScreen
    extends State<EditPersonInformationTabletScreen> {
  ManagerPersonalInformationCubit cubit = ManagerPersonalInformationCubit();
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
    cubit.loadApi(id: widget.id);
    super.initState();
    cubit.managerStream.listen((event) {
      cubit.getCurrentUnit(event);
      nameController.text = event.hoTen ?? 'Họ tên';
      maCanBoController.text = event.maCanBo ?? 'Mã cán bộ';
      thuTuController.text = event.thuTu.toString();
      cmndController.text = event.cmtnd ?? 'Số CMND';
      emailController.text = event.email ?? 'Email';
      sdtCoquanController.text = event.phoneCoQuan ?? 'Số điện thoại cơ quan';
      sdtController.text = event.phoneDiDong ?? 'Số điện thoại';
      diaChiLienHeController.text = event.diaChi ?? 'Địa chỉ';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        cubit.managerPersonalInformationModel.getInfoToMap();
    return Scaffold(
      backgroundColor: bgManagerColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefaultBack(
        S.current.chinh_sua_thong_tin,
      ),
      body: ManagerProvider(
        managerCubit: cubit,
        child: RefreshIndicator(
          onRefresh: () async {
            await cubit.getInfo(id: widget.id);
            if (keyGroup.currentState!.validator()) {
            } else {}
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColorApp,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderItemCalender.withOpacity(0.5)),
              ),
              margin: const EdgeInsets.only(
                top: 28,
                left: 30,
                right: 30,
                bottom: 30,
              ),
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: FormGroup(
                key: keyGroup,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.thong_tin,
                          style: textNormalCustom(
                            fontSize: 18,
                            color: fontColorTablet2,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.getInfo(id: widget.id);
                            if (keyGroup.currentState!.validator()) {
                            } else {}
                          },
                          child: Text(
                            S.current.reset,
                            style: titleText(
                              fontSize: 16,
                              color: numberColorTablet,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InputInfoUserWidget(
                                needMargin: false,
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
                              StreamBuilder<bool>(
                                stream: cubit.isCheckButtonReset,
                                builder: (context, snapshot) {
                                  return InputInfoUserWidget(
                                    isObligatory: true,
                                    title: user.keys.elementAt(4),
                                    child: SelectDate(
                                      key: UniqueKey(),
                                      paddings: 10,
                                      leadingIcon: SvgPicture.asset(
                                        ImageAssets.icEditInfor,
                                      ),
                                      value: cubit
                                          .managerPersonalInformationModel
                                          .ngaySinh,
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
                                    return value?.checkNull();
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
                                      value:
                                          cubit.managerPersonalInformationModel
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
                            ],
                          ),
                        ),
                        spaceW28,
                        Expanded(
                          child: Column(
                            children: [
                              InputInfoUserWidget(
                                needMargin: false,
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
                              StreamBuilder<List<TinhHuyenXaModel>>(
                                stream: cubit.tinhStream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  return InputInfoUserWidget(
                                    title: user.keys.elementAt(10),
                                    child: CustomSelectTinh(
                                      initialValue: cubit
                                          .managerPersonalInformationModel.tinh,
                                      key: UniqueKey(),
                                      title: S.current.tinh_thanh,
                                      items: data,
                                      onChange: (indexes, id) {
                                        cubit.huyenSubject.sink.add([]);
                                        cubit.xaSubject.sink.add([]);
                                        cubit.getDataHuyenXa(
                                          isXa: false,
                                          parentId:
                                              cubit.tinhModel[indexes].id ?? '',
                                        );
                                        if (indexes >= 0) {
                                          cubit.isCheckTinhSubject.sink
                                              .add(false);
                                        }
                                      },
                                      onRemove: () {
                                        cubit.huyenSubject.sink.add([]);
                                        cubit.isCheckTinhSubject.sink.add(true);
                                        cubit.isCheckHuyenSubject.sink
                                            .add(true);
                                      },
                                      cubit: cubit,
                                      isEnable:
                                          cubit.huyenSubject.value.isEmpty,
                                    ),
                                  );
                                },
                              ),
                              StreamBuilder<List<TinhHuyenXaModel>>(
                                stream: cubit.huyenStream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  if (data.isEmpty) {
                                    cubit.xaSubject.sink.add([]);
                                  }
                                  return InputInfoUserWidget(
                                    title: user.keys.elementAt(11),
                                    child: CustomSelectTinh(
                                      initialValue: cubit
                                          .managerPersonalInformationModel
                                          .huyen,
                                      key: UniqueKey(),
                                      title: S.current.quan_huyen,
                                      items: data,
                                      onChange: (indexes, id) {
                                        cubit.xaSubject.sink.add([]);
                                        cubit.getDataHuyenXa(
                                          isXa: true,
                                          parentId:
                                              cubit.huyenModel[indexes].id ??
                                                  '',
                                        );
                                        if (indexes >= 0) {
                                          cubit.isCheckTinhSubject.sink
                                              .add(false);
                                        }
                                      },
                                      onRemove: () {
                                        cubit.xaSubject.sink.add([]);
                                        cubit.isCheckTinhSubject.sink.add(true);
                                        cubit.isCheckHuyenSubject.sink
                                            .add(true);
                                      },
                                      cubit: cubit,
                                      isEnable:
                                          cubit.huyenSubject.value.isEmpty,
                                    ),
                                  );
                                },
                              ),
                              StreamBuilder<List<TinhHuyenXaModel>>(
                                stream: cubit.xaStream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  return InputInfoUserWidget(
                                    title: user.keys.elementAt(12),
                                    child: CustomSelectTinh(
                                      initialValue: cubit
                                          .managerPersonalInformationModel.xa,
                                      key: UniqueKey(),
                                      title: S.current.phuong_xa,
                                      items: data,
                                      onChange: (indexes, id) {
                                        if (indexes >= 0) {
                                          cubit.isCheckTinhSubject.sink
                                              .add(false);
                                        }
                                      },
                                      onRemove: () {
                                        cubit.isCheckTinhSubject.sink.add(true);
                                        cubit.isCheckHuyenSubject.sink
                                            .add(true);
                                      },
                                      cubit: cubit,
                                      isEnable: cubit.xaSubject.value.isEmpty,
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
                            // child: const WidgetDonVi(),
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
                            // child: const WidgetUngDung(),
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
                      cubit: cubit,
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
        ),
      ),
    );
  }
}
