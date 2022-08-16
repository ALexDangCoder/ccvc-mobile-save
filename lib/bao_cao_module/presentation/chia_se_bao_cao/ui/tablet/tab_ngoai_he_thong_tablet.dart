import 'dart:async';

import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/date_input.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_chia_se_co_tk.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/validate_email.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/radio/group_radio_button.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TabNgoaiHeThongTablet extends StatefulWidget {
  const TabNgoaiHeThongTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;

  @override
  State<TabNgoaiHeThongTablet> createState() => _TabNgoaiHeThongTabletState();
}

class _TabNgoaiHeThongTabletState extends State<TabNgoaiHeThongTablet> {
  final _groupKey = GlobalKey<FormGroupState>();

  late TextEditingController controller;
  Timer? debounce;

  String? name;
  DateTime? birthday;
  String? email;
  String? phoneNumber;
  String? position;
  String? unit;
  String? note;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (widget.cubit.keySearch != '') {
      controller.text = widget.cubit.keySearch;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (widget.cubit.canLoadMoreList &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              widget.cubit.valueDuocTruyCap) {
            widget.cubit.loadMoreUsersNgoaiHeThongTruyCap();
          }
          return true;
        },
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () async {
              widget.cubit.refreshData();
              widget.cubit.getUsersNgoaiHeThongDuocTruyCap(isSearch: true);
            },
            child: Stack(
              children: [
                SingleChildScrollView(
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
                              isRow: true,
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
                          initialData: true,
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
                      spaceH70,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 144.w,
                      right: 144.w,
                    ),
                    height: 70,
                    color: Colors.white,
                    child: buttonBottom,
                  ),
                ),
              ],
            ),
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
              isRequired: true,
              title: S.current.ho_ten,
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
              initDateTime: birthday,
            ),
            spaceH16,
            textField(
              isRequired: true,
              title: S.current.email,
              hintText: S.current.email,
              onChange: (value) {
                email = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.email}!';
                }
                if (!(value ?? '').isValidEmail()) {
                  return '${S.current.dinh_dang_truong_email}!';
                }
                if ((value ?? '').indexOf('@') > lengthEmailName) {
                  return '${S.current.dinh_dang_truong_email}!';
                }
                if ((value ?? '').split('@').last.characters.length >
                    lengthEmailDomain) {
                  return '${S.current.dinh_dang_truong_email}!';
                }
              },
            ),
            spaceH16,
            textField(
              maxLength: 255,
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
              isRequired: true,
              hintText: S.current.chuc_vu,
              title: S.current.chuc_vu,
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
              isRequired: true,
              title: S.current.don_vi,
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
              isRequired: true,
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return '${S.current.ban_phai_nhap_truong} ${S.current.ghi_chu}!';
                }
              },
              title: S.current.ghi_chu,
              onChange: (value) {
                note = value;
              },
              maxLine: 6,
            ),
            spaceH24,
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

  Widget get buttonBottom => StreamBuilder<bool>(
        stream: widget.cubit.isDuocTruyCapStream,
        builder: (context, snapshot) {
          return DoubleButtonBottom(
            height: 44,
            noPadding: true,
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
                      widget.cubit.chiaSeBaoCao(Share.COMMON).then((value) {
                        if (value == ChiaSeBaoCaoCubit.success) {
                          MessageConfig.show(title: value);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          MessageConfig.show(
                            title: value,
                            messState: MessState.error,
                          );
                        }
                      });
                    },
                    showTablet: true,
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
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          MessageConfig.show(
                            title: value,
                            messState: MessState.error,
                          );
                        }
                      });
                    },
                    showTablet: true,
                    textContent: S.current.chia_se_thu_muc_chac_chua,
                  ).then((value) {});
                }
              }
            },
          );
        },
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
        controller: controller,
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
          if (debounce != null) debounce!.cancel();
          setState(() {
            debounce = Timer(const Duration(seconds: 1), () {
              widget.cubit.keySearch = keySearch;
              widget.cubit.clearUsersNgoaiHeThongDuocTruyCap();
              widget.cubit.getUsersNgoaiHeThongDuocTruyCap(isSearch: true);
            });
          });
        },
      );

  Widget textField({
    String? hintText,
    int maxLine = 1,
    int? maxLength,
    bool isRequired = false,
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
          child: RichText(
            text: TextSpan(
              style: tokenDetailAmount(
                fontSize: 14,
                color: color3D5586,
              ),
              text: title,
              children: isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: tokenDetailAmount(
                          fontSize: 14,
                          color: redChart,
                        ),
                      ),
                    ]
                  : [],
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
          maxLength: maxLength,
        )
      ],
    );
  }
}
