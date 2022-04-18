import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/bloc/tao_su_kien_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/wiget/custom_select_mutil.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/explan_group/explan_group.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/from_group/form_group.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/text_field/text_field_style.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/text_field/text_field_style_png.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/widget_tablet/button_double.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/widget_tablet/widget_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaoSuKienKetNoi extends StatefulWidget {
  final TaoSuKienCubit cubit;

  const TaoSuKienKetNoi({Key? key, required this.cubit}) : super(key: key);

  @override
  _TaoSuKienKetNoiState createState() => _TaoSuKienKetNoiState();
}

class _TaoSuKienKetNoiState extends State<TaoSuKienKetNoi> {
  final keyGroup = GlobalKey<FormGroupState>();
  bool isValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        appBar: BaseAppBar(
          title: S.current.tao_su_kien,
          leadingIcon: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: SvgPicture.asset(
              ImageAssets.icBacks,
            ),
          ),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: FormGroup(
            key: keyGroup,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldStyle(
                          urlIcon: ImageAssets.icEdit,
                          hintText: S.current.nhap_ten_chuong_trinh,
                          onChange: (value) {
                            widget.cubit.tenSuKien = value;
                          },
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return S.current.khong_duoc_de_trong;
                            }
                            return null;
                          },
                        ),
                        spaceH5,
                        StreamBuilder<List<LoaiBaiVietModel>>(
                          stream: widget.cubit.loaiBaiVietSubject,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            if (data.isNotEmpty) {
                              return Column(
                                children: [
                                  CustomSelectMutil(
                                    urlIcon: ImageAssets.icDocument,
                                    title: S.current.loai_bai_viet,
                                    value: data.map((e) => e.title).first ??
                                        S.current.loai_bai_viet,
                                    onChange: (value) {
                                      widget.cubit.listName(value);
                                      value.isNotEmpty
                                          ? isValidate = true
                                          : isValidate = false;
                                    },
                                    dataLoaiBaiViet: data,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        spaceH5,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icDoublePerson,
                          hintText: S.current.them_nguoi,
                          onChange: (value) {
                            widget.cubit.themNguoi = value;
                          },
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return S.current.khong_duoc_de_trong;
                            }
                            return null;
                          },
                        ),
                        spaceH5,
                        StartEndDateWidget(
                          icMargin: false,
                          onEndDateTimeChanged: (DateTime value) {},
                          onStartDateTimeChanged: (DateTime value) {
                            widget.cubit.thoiGian = value.formatApiSS;
                          }, isCheck: (bool value) {  },
                        ),
                        spaceH5,
                        TextFieldStyle(
                          urlIcon: ImageAssets.ic_location,
                          hintText: S.current.dia_diem,
                          onChange: (value) {
                            widget.cubit.diaDiem = value;
                          },
                        ),
                        spaceH24,
                        Text(
                          S.current.thong_tin_lien_he,
                          style: textNormalCustom(
                            color: titleColor,
                            fontSize: 16.0,
                          ),
                        ),
                        spaceH5,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icCaling,
                          hintText: S.current.so_dien_thoai,
                          validator: (value) {
                            return (value ?? '').checkSdt();
                          },
                          onChange: (value) {
                            widget.cubit.tel = value;
                          },
                        ),
                        spaceH16,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icViber,
                          hintText: S.current.id_viber,
                          onChange: (value) {
                            widget.cubit.viber = value;
                          },
                        ),
                        spaceH16,
                        TextFieldStylePNG(
                          urlIcon: ImageAssets.icGroup,
                          hintText: S.current.id_meeting,
                          onChange: (value) {
                            widget.cubit.emeeting = value;
                          },
                        ),
                        spaceH16,
                        TextFieldStylePNG(
                          urlIcon: ImageAssets.icZoom,
                          hintText: S.current.zoom,
                          onChange: (value) {
                            widget.cubit.zoom = value;
                          },
                        ),
                        spaceH24,
                        TextFieldStyle(
                          urlIcon: ImageAssets.icDocument,
                          hintText: S.current.noi_dung,
                          onChange: (value) {
                            widget.cubit.noiDung = value;
                          },
                          maxLine: 4,
                        ),
                        spaceH24,
                        DoubleButtonBottom(
                          title1: S.current.huy,
                          title2: S.current.tao_su_kien,
                          onPressed1: () {
                            Navigator.pop(context);
                          },
                          onPressed2: () async {
                            if (keyGroup.currentState!.validator() &&
                                isValidate == true) {
                              await widget.cubit.callApis().then(
                                (value) {
                                  MessageConfig.show(
                                    title: S.current.tao_thanh_cong,
                                  );
                                  Navigator.pop(context, true);
                                },
                              ).onError(
                                (error, stackTrace) {},
                              );
                            } else {
                              MessageConfig.show(
                                title: S.current.tao_that_bai,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgTabletColor,
        appBar: BaseAppBar(
          title: S.current.tao_su_kien,
          leadingIcon: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: SvgPicture.asset(
              ImageAssets.icBacks,
            ),
          ),
          actions: const [],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RowColunmTabletWidget(
                titleLeft: S.current.thong_tin_su_kien,
                titleRight: S.current.thong_tin_lien_he,
                widgetRight: Column(
                  children: [
                    TextFieldStyle(
                      urlIcon: ImageAssets.icCaling,
                      hintText: S.current.so_dien_thoai,
                      validator: (value) {
                        return (value ?? '').checkSdt();
                      },
                      onChange: (value) {
                        widget.cubit.tel = value;
                      },
                    ),
                    spaceH16,
                    TextFieldStyle(
                      urlIcon: ImageAssets.icViber,
                      hintText: S.current.id_viber,
                      onChange: (value) {
                        widget.cubit.viber = value;
                      },
                    ),
                    spaceH16,
                    TextFieldStylePNG(
                      urlIcon: ImageAssets.icMeetings,
                      hintText: S.current.id_meeting,
                      onChange: (value) {
                        widget.cubit.emeeting = value;
                      },
                    ),
                    spaceH16,
                    TextFieldStylePNG(
                      urlIcon: ImageAssets.icZoom,
                      hintText: S.current.id_zoom,
                      onChange: (value) {
                        widget.cubit.zoom = value;
                      },
                    ),
                    spaceH24,
                    TextFieldStyle(
                      urlIcon: ImageAssets.icDocument,
                      hintText: S.current.noi_dung,
                      onChange: (value) {
                        widget.cubit.noiDung = value;
                      },
                      maxLine: 4,
                    ),
                    spaceH24,
                  ],
                ),
                widgetLeft: FormGroup(
                  key: keyGroup,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandGroup(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldStyle(
                                urlIcon: ImageAssets.icEdit,
                                hintText: S.current.nhap_ten_chuong_trinh,
                                onChange: (value) {
                                  widget.cubit.tenSuKien = value;
                                },
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return S.current.khong_duoc_de_trong;
                                  }
                                  return null;
                                },
                              ),
                              spaceH5,
                              StreamBuilder<List<LoaiBaiVietModel>>(
                                stream: widget.cubit.loaiBaiVietSubject,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  if (data.isNotEmpty) {
                                    return CustomSelectMutil(
                                      urlIcon: ImageAssets.icDocument,
                                      title: S.current.loai_bai_viet,
                                      value: data.map((e) => e.title).first ??
                                          S.current.loai_bai_viet,
                                      onChange: (value) {
                                        widget.cubit.listName(value);
                                        value.isNotEmpty
                                            ? isValidate = true
                                            : isValidate = false;
                                      },
                                      dataLoaiBaiViet: data,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              spaceH5,
                              TextFieldStyle(
                                urlIcon: ImageAssets.icDoublePerson,
                                hintText: S.current.them_nguoi,
                                onChange: (value) {
                                  widget.cubit.themNguoi = value;
                                },
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return S.current.khong_duoc_de_trong;
                                  }
                                  return null;
                                },
                              ),
                              spaceH5,
                              StartEndDateWidget(
                                icMargin: false,
                                onEndDateTimeChanged: (DateTime value) {},
                                onStartDateTimeChanged: (DateTime value) {
                                  widget.cubit.thoiGian = value.formatApiSS;
                                }, isCheck: (bool value) {  },
                              ),
                              spaceH5,
                              TextFieldStyle(
                                urlIcon: ImageAssets.ic_location,
                                hintText: S.current.dia_diem,
                                onChange: (value) {
                                  widget.cubit.diaDiem = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 28, bottom: 30),
                  child: ButtonSaveWidget(
                    leftTxt: S.current.huy,
                    rightTxt: S.current.tao_su_kien,
                    funcBtnOk: () async {
                      if (keyGroup.currentState!.validator() &&
                          isValidate == true) {
                        await widget.cubit.callApis().then(
                          (value) {
                            MessageConfig.show(
                              title: S.current.tao_thanh_cong,
                            );
                            Navigator.pop(context, true);
                          },
                        ).onError(
                          (error, stackTrace) {},
                        );
                      } else {
                        MessageConfig.show(
                          title: S.current.tao_that_bai,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
