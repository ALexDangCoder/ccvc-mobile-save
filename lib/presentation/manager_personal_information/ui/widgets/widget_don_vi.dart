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

class WidgetDonVi extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;
  final bool isCheckTitle;

  const WidgetDonVi({Key? key, required this.cubit, required this.isCheckTitle})
      : super(key: key);

  @override
  _WidgetDonViState createState() => _WidgetDonViState();
}

class _WidgetDonViState extends State<WidgetDonVi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isCheckTitle)
          Text(
            S.current.don_vi,
            style: titleAppbar(fontSize: 16.0.textScale()),
          )
        else
          Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cubit.managerPersonalInformationModel
                      .departments?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.stt,
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleItemEdit,
                              textHeight: 2.5,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            S.current.don_vi,
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleItemEdit,
                              textHeight: 2.5,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            S.current.chuc_vu,
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleItemEdit,
                              textHeight: 2.5,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            S.current.trang_thai,
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleItemEdit,
                              textHeight: 2.5,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            S.current.mac_dinh,
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleItemEdit,
                              textHeight: 2.5,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}',
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleCalenderWork,
                              textHeight: 2.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.cubit.managerPersonalInformationModel
                                    .departments?[index].tenDonVi ??
                                '',
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleCalenderWork,
                              textHeight: 2.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.cubit.managerPersonalInformationModel
                                    .departments?[index].tenChucVu ??
                                '',
                            style: textDetailHDSD(
                              fontSize: 16.0,
                              color: titleCalenderWork,
                              textHeight: 2.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          spaceH16,
                          Container(
                            decoration: BoxDecoration(
                              color: widget
                                          .cubit
                                          .managerPersonalInformationModel
                                          .departments?[index]
                                          .trangThai !=
                                      0
                                  ? daXuLyColor
                                  : subTitle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 4,
                                bottom: 4,
                              ),
                              child: Text(
                                paserString(
                                  widget.cubit.managerPersonalInformationModel
                                          .departments?[index].trangThai ??
                                      0,
                                ),
                                style: tokenDetailAmount(
                                  fontSize: 10.0.textScale(),
                                ),
                              ),
                            ),
                          ),
                          spaceH16,
                          Row(
                            children: [
                              customSwitch(
                                widget.cubit.managerPersonalInformationModel
                                        .departments?[index].isDefault ??
                                    false,
                                (value) {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        )
      ],
    );
  }

  Widget customSwitch(bool value, Function(bool) onToggle) {
    return FlutterSwitchWidget(
      height: 24,
      width: 42,
      toggleSize: 14,
      inactiveIcon: SvgPicture.asset(ImageAssets.icX),
      activeIcon: SvgPicture.asset(ImageAssets.icV),
      inactiveColor: borderColor,
      activeColor: AppTheme.getInstance().colorField(),
      value: value,
      onToggle: onToggle,
    );
  }
}
