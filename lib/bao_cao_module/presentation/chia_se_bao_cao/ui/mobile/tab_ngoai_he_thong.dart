import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/date_input.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_chia_se_co_tk.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/validate_email.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/radio/group_radio_button.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNgoaiHeThongMobile extends StatefulWidget {
  const TabNgoaiHeThongMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;

  @override
  State<TabNgoaiHeThongMobile> createState() => _TabNgoaiHeThongMobileState();
}

class _TabNgoaiHeThongMobileState extends State<TabNgoaiHeThongMobile> {
  final _groupKey = GlobalKey<FormGroupState>();

  final Debouncer _debounce = Debouncer(milliseconds: 500);

  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? position;
  String? unit;
  String? note;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (widget.cubit.canLoadMoreList &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              widget.cubit.valueDuocTruyCap) {
            widget.cubit.loadMoreUsersNgoaiHeThongTruyCap();
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              spaceH20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: StreamBuilder<bool>(
                  initialData: false,
                  stream: widget.cubit.isDuocTruyCapStream,
                  builder: (context, snapshot) {
                    final isDuocTruyCap = snapshot.data ?? false;
                    return CustomGroupRadio<bool>(
                      listData: [
                        ItemCustomGroupRadio(
                          title: S.current.doi_tuong_da_duoc_truy_cap,
                          value: true,
                        ),
                        ItemCustomGroupRadio(
                          title: S.current.them_moi_doi_tuong,
                          value: false,
                        ),
                      ],
                      groupValue: isDuocTruyCap,
                      onchange: (value) {
                        widget.cubit.isDuocTruyCapSink.add(value ?? false);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: StreamBuilder<bool>(
                  initialData: false,
                  stream: widget.cubit.isDuocTruyCapStream,
                  builder: (context, snapshot) {
                    final isDuocTruyCap = snapshot.data ?? false;
                    if (isDuocTruyCap) {
                      return objectAccessed;
                    } else {
                      return newObject;
                    }
                  },
                ),
              ),
              buttonBottom,
              spaceH28,
            ],
          ),
        ),
      ),
    );
  }

  Widget get newObject => FormGroup(
        key: _groupKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textField(
              title: '${S.current.ho_ten}(*)',
              hintText: S.current.ho_ten,
              onChange: (value) {
                name = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.ho_ten}!';
                }
              },
            ),
            spaceH16,
            Text(
              S.current.ngay_sinh,
              textAlign: TextAlign.start,
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
            ),
            spaceH8,
            DateInput(
              paddings: 10,
              leadingIcon:
                  SvgPicture.asset(image_utils.ImageAssets.icCalenders),
              onSelectDate: (dateTime) {
                birthday = dateTime;
              },
              initDateTime: DateTime.tryParse(birthday ?? ''),
            ),
            spaceH16,
            textField(
              inputFormatter: [
                FilteringTextInputFormatter.deny(' '),
              ],
              title: '${S.current.email}(*)',
              hintText: S.current.email,
              onChange: (value) {
                email = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.email}!';
                }
                if (!(value ?? '').isValidEmail()) {
                  return S.current.dinh_dang_email;
                }
                if ((value ?? '').indexOf('@') > 64) {}
              },
            ),
            spaceH16,
            textField(
              hintText: S.current.so_dien_thoai,
              title: S.current.so_dien_thoai,
              onChange: (value) {
                phoneNumber = value;
              },
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputType: TextInputType.number,
            ),
            spaceH16,
            textField(
              hintText: S.current.chuc_vu,
              title: '${S.current.chuc_vu}(*)',
              onChange: (value) {
                position = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.chuc_vu}!';
                }
              },
            ),
            spaceH16,
            textField(
              title: '${S.current.don_vi}(*)',
              hintText: S.current.don_vi,
              onChange: (value) {
                unit = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.don_vi}!';
                }
              },
            ),
            spaceH16,
            textField(
              title: S.current.ghi_chu,
              onChange: (value) {
                note = value;
              },
              maxLine: 6,
            ),
          ],
        ),
      );

  ///các đối tượng được truy cấp
  Widget get objectAccessed => Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          search,
          listDoiTuongDaTruyCap,
        ],
      );

  InputBorder get borderSearch => const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      );

  Widget get buttonBottom => Padding(
        padding: const EdgeInsets.only(
          left: 21,
          right: 21,
          top: 24,
        ),
        child: StreamBuilder<bool>(
          stream: widget.cubit.isDuocTruyCapStream,
          builder: (context, snapshot) {
            return DoubleButtonBottom(
              onPressed1: () {
                Navigator.pop(context);
              },
              title1: S.current.dong,
              title2: S.current.chia_se,
              onPressed2: () {
                if (_groupKey.currentState?.validator() ?? true) {
                  if (snapshot.data == true) {
                    showDiaLog(
                      context,
                      title: S.current.chia_se_thu_muc,
                      icon: SvgPicture.asset(
                        ImageAssets.ic_chia_se,
                      ),
                      btnLeftTxt: S.current.huy,
                      btnRightTxt: S.current.dong_y,
                      funcBtnRight: () {
                        widget.cubit
                            .chiaSeBaoCao(
                          Share.HAS_USER,
                        )
                            .then((value) {
                          if (value == ChiaSeBaoCaoCubit.success) {
                            MessageConfig.show(title: value);
                          } else {
                            MessageConfig.show(
                              title: value,
                              messState: MessState.error,
                            );
                          }
                        });
                      },
                      showTablet: false,
                      textContent: S.current.chia_se_thu_muc_chac_chua,
                    ).then((value) {});
                  } else {
                    showDiaLog(
                      context,
                      title: S.current.chia_se_thu_muc,
                      icon: SvgPicture.asset(
                        ImageAssets.ic_chia_se,
                      ),
                      btnLeftTxt: S.current.huy,
                      btnRightTxt: S.current.dong_y,
                      funcBtnRight: () {
                        widget.cubit
                            .themMoiDoiTuong(
                          email: email,
                          fullName: name,
                          birthday: birthday,
                          phone: phoneNumber,
                          position: position,
                          unit: unit,
                          description: note,
                        )
                            .then((value) {
                          if (value == ChiaSeBaoCaoCubit.success) {
                            MessageConfig.show(title: value);
                          } else {
                            MessageConfig.show(
                              title: value,
                              messState: MessState.error,
                            );
                          }
                        });
                      },
                      showTablet: false,
                      textContent: S.current.chia_se_thu_muc_chac_chua,
                    ).then((value) {});
                  }
                } else {
                  final toast = FToast();
                  toast.init(context);
                  toast.showToast(
                    child: ShowToast(
                      text: S.current.sai_dinh_dang_truong,
                    ),
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
            );
          },
        ),
      );

  Widget get listDoiTuongDaTruyCap =>
      StreamBuilder<List<UserNgoaiHeThongDuocTruyCapModel>>(
        initialData: const [],
        stream: widget.cubit.usersNgoaiHeThongDuocTruyCapBHVSJ.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: NodataWidget(),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ItemChiaSeCoTk(
                  model: data[index],
                  cubit: widget.cubit,
                );
              },
            );
          }
        },
      );

  Widget get search => TextField(
        style: tokenDetailAmount(
          fontSize: 14.0.textScale(),
          color: color3D5586,
        ),
        decoration: InputDecoration(
          hintText: S.current.tim_kiem_nhanh,
          hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.getInstance().colorField(),
          ),
          border: borderSearch,
          enabledBorder: borderSearch,
          focusedBorder: borderSearch,
        ),
        onChanged: (keySearch) {
          _debounce.run(() {
            setState(() {});
            widget.cubit.keySearch = keySearch;
            widget.cubit.clearUsersNgoaiHeThongDuocTruyCap();
            widget.cubit.getUsersNgoaiHeThongDuocTruyCap(isSearch: true);
          });
        },
      );

  Widget textField({
    String? hintText,
    int maxLine = 1,
    required String title,
    required Function(String) onChange,
    String? Function(String?)? validate,
    List<TextInputFormatter>? inputFormatter,
    TextInputType? textInputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: tokenDetailAmount(
              fontSize: 14,
              color: color3D5586,
            ),
          ),
        ),
        spaceH8,
        TextFieldValidator(
          hintText: hintText,
          onChange: onChange,
          maxLine: maxLine,
          validator: validate,
          inputFormatters: inputFormatter,
          textInputType: textInputType,
        )
      ],
    );
  }
}
