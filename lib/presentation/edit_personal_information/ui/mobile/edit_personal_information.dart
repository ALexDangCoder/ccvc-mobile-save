import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/custom_select_tinh.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/avatar.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/manager_provider.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditPersonInformationScreen extends StatefulWidget {
  final String id;

  const EditPersonInformationScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPersonalInformationScreen();
}

class _EditPersonalInformationScreen
    extends State<EditPersonInformationScreen> {
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
  String tinh = '';
  String huyen = '';
  String xa = '';
  String dateTimes = '';
  bool gioiTinh = true;

  @override
  void initState() {
    cubit.loadApi(id: widget.id);
    super.initState();
    cubit.managerStream.listen((event) {
      cubit.getCurrentUnit(event);
      nameController.text = event.hoTen ?? '';
      maCanBoController.text = event.maCanBo ?? '';
      thuTuController.text = event.thuTu.toString();
      cmndController.text = event.cmtnd ?? '';
      emailController.text = event.email ?? '';
      sdtCoquanController.text = event.phoneCoQuan ?? '';
      sdtController.text = event.phoneDiDong ?? '';
      diaChiLienHeController.text = event.diaChi ?? '';
      dateTimes = cubit.managerPersonalInformationModel.ngaySinh ?? '';
    });
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
                cubit.getInfo(id: widget.id);
                cubit.huyenSubject.sink.add([]);
                cubit.xaSubject.sink.add([]);
                if (keyGroup.currentState!.validator()) {
                } else {}
              },
              child: Text(
                S.current.reset,
                style: textNormalCustom(fontSize: 14, color: labelColor),
              ),
            ),
          )
        ],
      ),
      body: ManagerProvider(
        managerCubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', ''),
          stream: cubit.stateStream,
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.getInfo(id: widget.id);
              if (keyGroup.currentState!.validator()) {
              } else {}
            },
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FormGroup(
                key: keyGroup,
                child: StreamBuilder<ManagerPersonalInformationModel>(
                  stream: cubit.managerStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    return Column(
                      children: [
                        InputInfoUserWidget(
                          isObligatory: true,
                          title: user.keys.elementAt(1),
                          child: TextFieldValidator(
                            hintText: S.current.ho_va_ten,
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
                            hintText: S.current.ma_can_bo,
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
                            hintText: S.current.thu_tus,
                            controller: thuTuController,
                          ),
                        ),
                        InputInfoUserWidget(
                          isObligatory: true,
                          title: user.keys.elementAt(4),
                          child: SelectDate(
                            key: UniqueKey(),
                            paddings: 10,
                            leadingIcon:
                                SvgPicture.asset(ImageAssets.icCalenders),
                            value: cubit
                                    .managerPersonalInformationModel.ngaySinh ??
                                '',
                            onSelectDate: (dateTime) {
                              cubit.selectBirthdayEvent(dateTime);
                              dateTimes = dateTime;
                            },
                          ),
                        ),
                        InputInfoUserWidget(
                          title: user.keys.elementAt(5),
                          child: TextFieldValidator(
                            hintText: S.current.cmnd,
                            controller: cmndController,
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
                                gioiTinh = true;
                              } else {
                                cubit.selectGTEvent(false);
                                gioiTinh = false;
                              }
                            },
                          ),
                        ),
                        InputInfoUserWidget(
                          title: user.keys.elementAt(7),
                          child: TextFieldValidator(
                            hintText: S.current.email,
                            controller: emailController,
                            validator: (value) {
                              return (value ?? '').checkEmail();
                            },
                          ),
                        ),
                        InputInfoUserWidget(
                          title: user.keys.elementAt(8),
                          child: TextFieldValidator(
                            hintText: S.current.sdt_co_quan,
                            controller: sdtCoquanController,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              return (value ?? '').checkSdt();
                            },
                          ),
                        ),
                        //
                        InputInfoUserWidget(
                          title: user.keys.elementAt(9),
                          child: TextFieldValidator(
                            hintText: S.current.so_dien_thoai,
                            controller: sdtController,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              return (value ?? '').checkSdt();
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
                                initialValue:
                                    cubit.managerPersonalInformationModel.tinh,
                                key: UniqueKey(),
                                title: S.current.tinh_thanh,
                                items: data,
                                onChange: (indexes, id) {
                                  cubit.huyenSubject.sink.add([]);
                                  cubit.xaSubject.sink.add([]);
                                  cubit.managerPersonalInformationModel.huyen =
                                      null;
                                  cubit.managerPersonalInformationModel.xa =
                                      null;

                                  cubit.getDataHuyenXa(
                                    isXa: false,
                                    parentId: cubit.tinhModel[indexes].id ?? '',
                                  );
                                  if (indexes >= 0) {
                                    cubit.isCheckTinhSubject.sink.add(false);
                                  }
                                  tinh = data[indexes].name ?? '';
                                },
                                onRemove: () {
                                  cubit.huyenSubject.sink.add([]);
                                  cubit.isCheckTinhSubject.sink.add(true);
                                  cubit.isCheckHuyenSubject.sink.add(true);
                                },
                                cubit: cubit,
                                isEnable: cubit.huyenSubject.value.isEmpty,
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
                                initialValue:
                                    cubit.managerPersonalInformationModel.huyen,
                                key: UniqueKey(),
                                title: S.current.quan_huyen,
                                items: data,
                                onChange: (indexes, id) {
                                  cubit.xaSubject.sink.add([]);
                                  cubit.managerPersonalInformationModel.xa =
                                      null;
                                  cubit.getDataHuyenXa(
                                    isXa: true,
                                    parentId:
                                        cubit.huyenModel[indexes].id ?? '',
                                  );
                                  if (indexes >= 0) {
                                    cubit.isCheckTinhSubject.sink.add(false);
                                  }
                                  huyen = data[indexes].name ?? '';
                                },
                                onRemove: () {
                                  cubit.xaSubject.sink.add([]);
                                  cubit.isCheckTinhSubject.sink.add(true);
                                  cubit.isCheckHuyenSubject.sink.add(true);
                                },
                                cubit: cubit,
                                isEnable: cubit.huyenSubject.value.isEmpty,
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
                                initialValue:
                                    cubit.managerPersonalInformationModel.xa,
                                key: UniqueKey(),
                                title: S.current.phuong_xa,
                                items: data,
                                onChange: (indexes, id) {
                                  if (indexes >= 0) {
                                    cubit.isCheckTinhSubject.sink.add(false);
                                  }
                                  xa = data[indexes].name ?? '';
                                },
                                onRemove: () {
                                  cubit.isCheckTinhSubject.sink.add(true);
                                  cubit.isCheckHuyenSubject.sink.add(true);
                                },
                                cubit: cubit,
                                isEnable: cubit.xaSubject.value.isEmpty,
                              ),
                            );
                          },
                        ),

                        InputInfoUserWidget(
                          title: user.keys.elementAt(13),
                          child: TextFieldValidator(
                            hintText: S.current.dia_chi_lien_he,
                            controller: diaChiLienHeController,
                          ),
                        ),
                        spaceH20,
                        WidgetDonVibMobile(
                          cubit: cubit,
                        ),
                        spaceH20,
                        WidgetUngDungMobile(
                          cubit: cubit,
                        ),
                        spaceH20,
                        AvatarAndSignature(
                          cubit: cubit,
                        ),
                        spaceH20,
                        DoubleButtonBottom(
                          onPressed1: () {
                            Navigator.pop(context);
                          },
                          onPressed2: () async {
                            if (keyGroup.currentState!.validator()) {
                              await cubit
                                  .getEditPerson(
                                id: widget.id,
                                maCanBo: maCanBoController.value.text,
                                name: nameController.value.text,
                                sdtCoQuan: sdtCoquanController.value.text,
                                sdt: sdtController.value.text,
                                email: emailController.value.text,
                                gioitinh: gioiTinh,
                                ngaySinh: dateTimes,
                                cmnt: cmndController.value.text,
                                diaChiLienHe: diaChiLienHeController.value.text,
                                donViDetail: cubit
                                    .editPersonInformationRequest.donViDetail,
                                thuTu: int.parse(thuTuController.text),
                                tinh: tinh,
                                huyen: huyen,
                                xa: xa,
                              )
                                  .then(
                                (value) {
                                  return MessageConfig.show(
                                    title: S.current.sua_thanh_cong,
                                  );
                                },
                              ).onError(
                                (error, stackTrace) => MessageConfig.show(
                                  title: S.current.sua_that_bai,
                                  messState: MessState.error,
                                ),
                              );
                              Navigator.pop(context);
                            } else {}
                          },
                          title1: S.current.dong,
                          title2: S.current.luu_lai,
                        ),
                        spaceH32,
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
