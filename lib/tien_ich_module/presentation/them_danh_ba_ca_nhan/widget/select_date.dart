import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/dialog_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/button_bottom.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/fix_bug_cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SelectDateThem extends StatefulWidget {
  final Function(String) onSelectDate;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? leadingIcon;
  final bool isObligatory;
  final double? paddings;
  final bool isTablet;
  final DanhBaDienTuCubit cubit;

  const SelectDateThem({
    Key? key,
    required this.onSelectDate,
    this.hintText,
    this.backgroundColor,
    this.leadingIcon,
    this.paddings,
    this.isObligatory = false,
    this.isTablet = false,
    required this.cubit,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<SelectDateThem> {
  String dateSelect = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTablet
        ? GestureDetector(
            onTap: () {
              showDiaLogTablet(
                context,
                title: S.current.chon_ngay,
                isBottomShow: false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: FixBugCupertinoDatePicker(
                          onDateTimeChanged: (value) {
                            dateSelect = value.toString();
                          },
                          textStyleDate: titleAppbar(),
                          initialDateTime: dateSelect.isEmpty
                              ? DateTime.now()
                              : DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .parse(dateSelect),
                        ),
                      ),
                    ],
                  ),
                ),
                btnRightTxt: S.current.chon_ngay,
                funcBtnOk: () {
                  setState(() {});
                  if (dateSelect.isNotEmpty) {
                    widget.onSelectDate(dateSelect);
                  } else {
                    dateSelect = DateTime.now().toString();
                    widget.onSelectDate(dateSelect);
                  }
                  widget.cubit.isCheckValidate.add(dateSelect);
                },
                setHeight: 400,
                funcBtnPop: () {},
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 16.0.textScale(space: 4),
                    height: 16.0.textScale(space: 4),
                    color: Colors.transparent,
                    child: widget.leadingIcon ??
                        SvgPicture.asset(ImageAssets.icCalenderDb),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                            left: 16,
                          ),
                          child: dateSelect.isEmpty
                              ? Text(
                                  widget.hintText ?? '',
                                  style: tokenDetailAmount(
                                    fontSize: 14.0,
                                    color: colorA2AEBD,
                                  ),
                                )
                              : Text(
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .parse(dateSelect)
                                      .toStringWithListFormat,
                                  style: tokenDetailAmount(
                                    fontSize: 14.0,
                                    color: color3D5586,
                                  ),
                                ),
                        ),
                        StreamBuilder<String>(
                          initialData: widget.cubit.dateDanhSach,
                          stream: widget.cubit.isCheckValidate,
                          builder: (context, snap) {
                            if (snap.data?.isNotEmpty ?? true) {
                              return Container();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${S.current.ban_phai_nhap_truong} '
                                  '${S.current.ngay_sinh_require}!',
                                  style: tokenDetailAmount(
                                    fontSize: 12.0,
                                    color: redChart,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colorECEEF7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              showBottomSheetCustom(
                context,
                title: S.current.chon_ngay,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: FixBugCupertinoDatePicker(
                        onDateTimeChanged: (value) {
                          dateSelect = value.toString();
                        },
                        textStyleDate: titleAppbar(),
                        initialDateTime: dateSelect.isEmpty
                            ? DateTime.now()
                            : DateFormat('yyyy-MM-dd HH:mm:ss')
                                .parse(dateSelect),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 32,
                      ),
                      child: ButtonBottom(
                        text: S.current.chon,
                        onPressed: () {
                          setState(() {});
                          if (dateSelect.isNotEmpty) {
                            widget.onSelectDate(dateSelect);
                          } else {
                            dateSelect = DateTime.now().toString();
                            widget.onSelectDate(dateSelect);
                          }
                          widget.cubit.isCheckValidate.add(dateSelect);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 16.0.textScale(space: 4),
                    height: 16.0.textScale(space: 4),
                    color: Colors.transparent,
                    child: widget.leadingIcon ??
                        SvgPicture.asset(ImageAssets.icCalenderDb),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                            left: 16,
                          ),
                          child: dateSelect.isEmpty
                              ? Text(
                                  widget.hintText ?? '',
                                  style: tokenDetailAmount(
                                    fontSize: 14.0.textScale(),
                                    color: colorA2AEBD,
                                  ),
                                )
                              : Text(
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .parse(dateSelect)
                                      .toStringWithListFormat,
                                  style: tokenDetailAmount(
                                    fontSize: 14.0.textScale(),
                                    color: color3D5586,
                                  ),
                                ),
                        ),
                        StreamBuilder<String>(
                          initialData: widget.cubit.dateDanhSach,
                          stream: widget.cubit.isCheckValidate,
                          builder: (context, snap) {
                            if (snap.data?.isNotEmpty ?? true) {
                              return Container();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${S.current.ban_phai_nhap_truong} '
                                  '${S.current.ngay_sinh_require}!',
                                  style: tokenDetailAmount(
                                    fontSize: 12,
                                    color: redChart,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colorECEEF7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
