import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button_switch/flutter_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetUngDungMobile extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;

  const WidgetUngDungMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  _WidgetUngDungMobileState createState() => _WidgetUngDungMobileState();
}

class _WidgetUngDungMobileState extends State<WidgetUngDungMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.ung_dung,
          style: titleAppbar(fontSize: 14.0.textScale()),
        ),
        spaceH16,
        Container(
          padding: const EdgeInsets.only(top: 6, left: 16, right: 16),
          decoration: BoxDecoration(
            color: borderItemCalender.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderItemCalender),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.cubit.managerPersonalInformationModel
                          .userAccounts?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                S.current.stt,
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleItemEdit,
                                  textHeight: 2.5,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${index + 1}',
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleCalenderWork,
                                  textHeight: 2.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                S.current.ten_dang_nhap,
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleItemEdit,
                                  textHeight: 2.5,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                widget.cubit.managerPersonalInformationModel
                                        .userAccounts?[index].userName ??
                                    '',
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleCalenderWork,
                                  textHeight: 2.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                S.current.ung_dung,
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleItemEdit,
                                  textHeight: 2.5,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget
                                        .cubit
                                        .managerPersonalInformationModel
                                        .userAccounts?[index]
                                        .applications
                                        ?.length ??
                                    0,
                                itemBuilder: (BuildContext context, indexs) {
                                  return Text(
                                    widget
                                            .cubit
                                            .managerPersonalInformationModel
                                            .userAccounts?[index]
                                            .applications?[indexs]
                                            .applicationName ??
                                        '',
                                    style: textDetailHDSD(
                                      fontSize: 14.0,
                                      color: titleCalenderWork,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        spaceH6,
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                S.current.trang_thai,
                                style: textDetailHDSD(
                                  fontSize: 14.0,
                                  color: titleItemEdit,
                                  // textHeight: 2.5,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: daXuLyColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      paserString(
                                        widget
                                                .cubit
                                                .managerPersonalInformationModel
                                                .userAccounts?[index]
                                                .trangThai ??
                                            0,
                                      ),
                                      style: tokenDetailAmount(
                                        fontSize: 10.0.textScale(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget customSwitch(bool value, Function(bool) onToggle) {
  return FlutterSwitchWidget(
    height: 24,
    width: 42,
    toggleSize: 14,
    inactiveIcon: SvgPicture.asset(ImageAssets.icX),
    activeIcon: SvgPicture.asset(ImageAssets.icV),
    inactiveColor: AppTheme.getInstance().inactiveColor(),
    activeColor: AppTheme.getInstance().colorField(),
    value: value,
    onToggle: onToggle,
  );
}
