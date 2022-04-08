import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/custom_select_tinh.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/widget/avatar_tablet.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/double_button_edit_seen.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_don_vi.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_ung_dung.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
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
      body: StateStreamLayout(
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
                child: StreamBuilder<ManagerPersonalInformationModel>(
                  stream: cubit.managerStream,
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const SizedBox();
                    }
                    return Column(
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
                                cubit.huyenSubject.sink.add([]);
                                cubit.xaSubject.sink.add([]);
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
                                        return value?.checkNull();
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
                                      leadingIcon: SvgPicture.asset(
                                        ImageAssets.icCalenders,
                                      ),
                                      value: cubit
                                              .managerPersonalInformationModel
                                              .ngaySinh ??
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
                                      hintText: S.current.sdt_co_quan,
                                      controller: sdtCoquanController,
                                      textInputType: TextInputType.number,
                                      validator: (value) {
                                        return (value ?? '').checkSdt();
                                      },
                                    ),
                                  ),
                                  InputInfoUserWidget(
                                    title: user.keys.elementAt(9),
                                    child: TextFieldValidator(
                                      hintText: S.current.so_dien_thoai,
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
                                              .managerPersonalInformationModel
                                              .tinh,
                                          key: UniqueKey(),
                                          title: S.current.tinh_thanh,
                                          items: data,
                                          onChange: (indexes, id) {
                                            cubit.huyenSubject.sink.add([]);
                                            cubit.xaSubject.sink.add([]);
                                            cubit
                                                .managerPersonalInformationModel
                                                .huyen = null;
                                            cubit
                                                .managerPersonalInformationModel
                                                .xa = null;

                                            cubit.getDataHuyenXa(
                                              isXa: false,
                                              parentId:
                                                  cubit.tinhModel[indexes].id ??
                                                      '',
                                            );
                                            if (indexes >= 0) {
                                              cubit.isCheckTinhSubject.sink
                                                  .add(false);
                                            }
                                            tinh = data[indexes].name ?? '';
                                          },
                                          onRemove: () {
                                            cubit.huyenSubject.sink.add([]);
                                            cubit.isCheckTinhSubject.sink
                                                .add(true);
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
                                            cubit
                                                .managerPersonalInformationModel
                                                .xa = null;
                                            cubit.getDataHuyenXa(
                                              isXa: true,
                                              parentId: cubit
                                                      .huyenModel[indexes].id ??
                                                  '',
                                            );
                                            if (indexes >= 0) {
                                              cubit.isCheckTinhSubject.sink
                                                  .add(false);
                                            }
                                            huyen = data[indexes].name ?? '';
                                          },
                                          onRemove: () {
                                            cubit.xaSubject.sink.add([]);
                                            cubit.isCheckTinhSubject.sink
                                                .add(true);
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
                                              .managerPersonalInformationModel
                                              .xa,
                                          key: UniqueKey(),
                                          title: S.current.phuong_xa,
                                          items: data,
                                          onChange: (indexes, id) {
                                            if (indexes >= 0) {
                                              cubit.isCheckTinhSubject.sink
                                                  .add(false);
                                            }
                                            xa = data[indexes].name ?? '';
                                          },
                                          onRemove: () {
                                            cubit.isCheckTinhSubject.sink
                                                .add(true);
                                            cubit.isCheckHuyenSubject.sink
                                                .add(true);
                                          },
                                          cubit: cubit,
                                          isEnable:
                                              cubit.xaSubject.value.isEmpty,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.current.don_vi,
                                    style:
                                        titleAppbar(fontSize: 16.0.textScale()),
                                  ),
                                  spaceH24,
                                  Container(
                                    padding: const EdgeInsets.only(
                                      //  top: 20,
                                      left: 20,
                                      bottom: 20,
                                      right: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          borderItemCalender.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: borderItemCalender),
                                    ),
                                    child: WidgetDonVi(
                                      cubit: cubit,
                                      isCheckTitle: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            spaceW28,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.current.ung_dung,
                                    style:
                                        titleAppbar(fontSize: 16.0.textScale()),
                                  ),
                                  spaceH24,
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      bottom: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          borderItemCalender.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: borderItemCalender),
                                    ),
                                    child: WidgetUngDung(
                                      cubit: cubit,
                                      isCheckTitle: false,
                                    ),
                                  ),
                                ],
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
