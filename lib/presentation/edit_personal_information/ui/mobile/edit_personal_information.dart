import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/custom_select_tinh.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/tablet/widget/show_dialog_edit.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/widgets/avatar.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_don_vi_mobile.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final ScrollController scrollController = ScrollController();
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
  final toast = FToast();
  String thuTu = '';

  @override
  void initState() {
    cubit.loadApi(id: widget.id);
    cubit.managerStream.listen((event) {
      cubit.getCurrentUnit(event);
      nameController.text = event.hoTen ?? '';
      maCanBoController.text = event.maCanBo ?? '';
      thuTuController.text = cubit.checkThuTu((event.thuTu ?? '').toString());
      cmndController.text = event.cmtnd ?? '';
      emailController.text = event.email ?? '';
      sdtCoquanController.text = event.phoneCoQuan ?? '';
      sdtController.text = event.phoneDiDong ?? '';
      diaChiLienHeController.text = event.diaChi ?? '';
      cubit.pathAnhDaiDien = event.anhDaiDienFilePath ?? '';
      cubit.pathAnhChuKy = event.anhChuKyFilePath ?? '';
      cubit.pathAnhKyNhay = event.anhChuKyNhayFilePath ?? '';
    });
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user =
        cubit.managerPersonalInformationModel.getInfoToMap();

    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException('1', ''),
      stream: cubit.stateStream,
      child: Scaffold(
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
                  showDiaLogTablet(
                    context,
                    title: S.current.ban_co_chac_muon,
                    child: Container(),
                    funcBtnOk: () {
                      cubit.getInfo(id: widget.id);
                      cubit.resetAvatar();
                      cubit.huyenSubject.sink.add([]);
                      cubit.xaSubject.sink.add([]);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    btnRightTxt: S.current.dong_y,
                    btnLeftTxt: S.current.khong,
                    title2: S.current.khong_edit,
                    title1: S.current.reset,
                    isPhone: true,
                  );
                },
                child: Text(
                  S.current.reset,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await cubit.getInfo(id: widget.id);
            cubit.huyenSubject.sink.add([]);
            cubit.xaSubject.sink.add([]);
            if (keyGroup.currentState!.validator()) {
            } else {}
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            controller: scrollController,
            child: FormGroup(
              scrollController: scrollController,
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
                          key: UniqueKey(),
                          hintText: S.current.ho_va_ten,
                          controller: nameController,
                          maxLength: 32,
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return '${S.current.ban_phai_nhap_truong} '
                                  '${S.current.ho_va_ten}!';
                            } else if ((value ?? '').trim().length < 6) {
                              return S.current.nhap_sai_dinh_dang;
                            }
                            return null;
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        isObligatory: true,
                        title: user.keys.elementAt(2),
                        child: TextFieldValidator(
                          isEnabled: false,
                          hintText: S.current.ma_can_bo,
                          controller: maCanBoController,
                          validator: (value) {
                            return value?.checkNulls();
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: user.keys.elementAt(3),
                        child: TextFieldValidator(
                          hintText: S.current.thu_tus,
                          controller: thuTuController,
                          maxLength: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          onChange: (value) {
                            if (value.length > 2) {
                              final input = value.substring(0, 2);
                              sdtCoquanController.text = input;
                              sdtCoquanController.selection =
                                  TextSelection.fromPosition(
                                const TextPosition(offset: 2),
                              );
                            }
                          },
                          validatorPaste: (value) {
                            if (value.trim().validateCopyPaste() != null) {
                              return true;
                            }
                            return false;
                          },
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
                          value:
                              cubit.managerPersonalInformationModel.ngaySinh ??
                                  '',
                          onSelectDate: (dateTime) {
                            cubit.selectBirthdayEvent(dateTime);
                            cubit.ngaySinh = dateTime;
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: user.keys.elementAt(5),
                        child: TextFieldValidator(
                          hintText: S.current.cmnd,
                          controller: cmndController,
                          maxLength: 255,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChange: (value) {
                            if (value.length > 255) {
                              final input = value.substring(0, 255);
                              cmndController.text = input;
                              cmndController.selection =
                                  TextSelection.fromPosition(
                                const TextPosition(offset: 255),
                              );
                            }
                          },
                          validatorPaste: (value) {
                            if (value.trim().validateCopyPaste() != null) {
                              return true;
                            }
                            return false;
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        isObligatory: true,
                        title: user.keys.elementAt(6),
                        child: CoolDropDown(
                          key: UniqueKey(),
                          initData:
                              cubit.managerPersonalInformationModel.gioiTinh ??
                                      false
                                  ? S.current.Nam
                                  : S.current.Nu,
                          placeHoder: S.current.gioi_tinh,
                          onChange: (value) {
                            if (value == 0) {
                              cubit.selectGTEvent(true);
                              cubit.gioiTinh = true;
                            } else {
                              cubit.selectGTEvent(false);
                              cubit.gioiTinh = false;
                            }
                          },
                          listData: cubit.fakeDataGioiTinh,
                        ),
                      ),
                      InputInfoUserWidget(
                        title: user.keys.elementAt(7),
                        isObligatory: true,
                        child: TextFieldValidator(
                          key: UniqueKey(),
                          hintText: S.current.email,
                          controller: emailController,
                          onChange: (value) {},
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return S.current.ban_phai_nhap_truong_email;
                            } else if (value.trim().contains('@')) {
                              if (value.trim().contains(
                                    '@',
                                    value.trim().indexOf('@') + 1,
                                  )) {
                                return S.current.nhap_sai_dinh_dang;
                              }
                            }
                            return value.trim().checkEmailBoolean();
                          },
                        ),
                      ),
                      InputInfoUserWidget(
                        title: user.keys.elementAt(8),
                        child: TextFieldValidator(
                          hintText: S.current.sdt_co_quan,
                          controller: sdtCoquanController,
                          textInputType: TextInputType.number,
                          maxLength: 255,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChange: (value) {
                            if (value.length > 255) {
                              final input = value.substring(0, 255);
                              sdtCoquanController.text = input;
                              sdtCoquanController.selection =
                                  TextSelection.fromPosition(
                                const TextPosition(offset: 255),
                              );
                            }
                          },
                          validatorPaste: (value) {
                            if (value.trim().validateCopyPaste() != null) {
                              return true;
                            }
                            return false;
                          },
                        ),
                      ),
                      //
                      InputInfoUserWidget(
                        title: user.keys.elementAt(9),
                        child: TextFieldValidator(
                          hintText: S.current.so_dien_thoai,
                          controller: sdtController,
                          maxLength: 255,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          onChange: (value) {
                            if (value.length > 255) {
                              final input = value.substring(0, 255);
                              sdtController.text = input;
                              sdtController.selection =
                                  TextSelection.fromPosition(
                                const TextPosition(offset: 255),
                              );
                            }
                          },
                          validatorPaste: (value) {
                            if (value.trim().validateCopyPaste() != null) {
                              return true;
                            }
                            return false;
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
                                cubit.managerPersonalInformationModel.xa = null;
                                cubit.idXa = '';
                                cubit.idHuyen = '';
                                cubit.getDataHuyenXa(
                                  isXa: false,
                                  parentId: id,
                                );
                                if (indexes >= 0) {
                                  cubit.isCheckTinhSubject.sink.add(false);
                                }
                                cubit.idTinh = id;
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
                                cubit.managerPersonalInformationModel.xa = null;
                                cubit.getDataHuyenXa(
                                  isXa: true,
                                  parentId: id,
                                );
                                if (indexes >= 0) {
                                  cubit.isCheckTinhSubject.sink.add(false);
                                }
                                cubit.idHuyen = id;
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
                                cubit.idXa = id;
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
                          maxLength: 255,
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
                        toast: toast,
                      ),
                      spaceH20,
                      DoubleButtonBottom(
                        onClickLeft: () {
                          showDiaLogTablet(
                            context,
                            title: S.current.ban_muon_thoat,
                            child: Container(),
                            funcBtnOk: () {
                              Navigator.pop(context, false);
                            },
                            btnRightTxt: S.current.dong_y,
                            btnLeftTxt: S.current.khong,
                            title2: '',
                            title1: '',
                            isPhone: true,
                            isBottomShowText: false,
                            isCallApi: false,
                          );
                        },
                        onClickRight: () async {
                          if (keyGroup.currentState?.validator() ?? true) {
                            await cubit
                                .getEditPerson(
                              id: widget.id,
                              maCanBo: maCanBoController.value.text,
                              name: nameController.value.text,
                              sdtCoQuan: sdtCoquanController.value.text,
                              sdt: sdtController.value.text,
                              email: emailController.value.text,
                              gioitinh: cubit.gioiTinh,
                              ngaySinh: cubit.ngaySinh,
                              cmnt: cmndController.value.text,
                              diaChiLienHe: diaChiLienHeController.value.text,
                              donViDetail: cubit
                                  .editPersonInformationRequest.donViDetail,
                              thuTu: thuTuController.value.text,
                              tinh: cubit.tinh,
                              huyen: cubit.huyen,
                              xa: cubit.xa,
                              idTinh: cubit.idTinh,
                              idHuyen: cubit.idHuyen,
                              idXa: cubit.idXa,
                              anhChuKy: cubit.pathAnhChuKy,
                              anhDaiDien: cubit.pathAnhDaiDien,
                              anhKyNhay: cubit.pathAnhKyNhay,
                            )
                                .then((value) {
                              if (value) {
                                Navigator.pop(context, true);
                              }
                            });
                          } else {
                            return;
                          }
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
    );
  }
}
