import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/chia_se_bao_cao.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/tablet/chia_se_bao_cao_tablet.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_folder.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart'
    as bao_cao;
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/mobile/widget/widget_ung_dung_mobile.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemReportShareFavorite extends StatefulWidget {
  final ReportItem reportItem;
  final ReportListCubit cubit;
  final bool isFavorite;
  final bool isIconClose;

  const ItemReportShareFavorite({
    Key? key,
    required this.reportItem,
    required this.cubit,
    required this.isFavorite,
    this.isIconClose = false,
  }) : super(key: key);

  @override
  State<ItemReportShareFavorite> createState() =>
      _ItemReportShareFavoriteState();
}

class _ItemReportShareFavoriteState extends State<ItemReportShareFavorite> {
  late bool isLove;

  @override
  void initState() {
    isLove = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 22.5,
            bottom: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ItemFolder(
                    type: widget.reportItem.type ?? 0,
                    isShare: widget.cubit.checkStatus(
                      widget.reportItem.status ?? 0,
                      widget.reportItem.type ?? 0,
                    ),
                    isListView: true,
                    fileNumber: widget.reportItem.childrenTotal ?? 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.isIconClose
                              ? MediaQuery.of(context).size.width / 4
                              : MediaQuery.of(context).size.width / 2,
                          child: Text(
                            widget.reportItem.name ?? '',
                            maxLines: 1,
                            style: textNormalCustom(
                              color: textTitle,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        spaceH4,
                        Text(
                          (widget.reportItem.dateTime ?? '')
                              .changeToNewPatternDate(
                            DateFormatApp.dateTimeBackEnd,
                            DateFormatApp.date,
                          ),
                          style: textNormalCustom(
                            color: infoColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.isIconClose)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    ImageAssets.icClose,
                    width: 16,
                    height: 16,
                    color: AppTheme.getInstance().unselectColor(),
                  ),
                ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: borderColor.withOpacity(0.5),
        ),
        if (widget.cubit.checkStatus(
          widget.reportItem.status ?? 0,
          widget.reportItem.type ?? 0,
        ))
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 18,
              bottom: 18,
            ),
            child: GestureDetector(
              onTap: () {
                if (widget.isIconClose) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: ChiaSeBaoCaoTablet(
                            idReport: widget.reportItem.id ?? '',
                            appId: widget.cubit.appId,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return ChiaSeBaoCaoMobile(
                        idReport: widget.reportItem.id ?? '',
                        appId: widget.cubit.appId,
                      );
                    },
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.icUploadSvg,
                      width: 20,
                      height: 20,
                      color: AppTheme.getInstance().unselectColor(),
                    ),
                    spaceW13,
                    Text(
                      S.current.chia_se,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().unselectedColor(),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (widget.cubit.checkStatus(
          widget.reportItem.status ?? 0,
          widget.reportItem.type ?? 0,
        ))
          reportLine(),
        if (widget.reportItem.type == REPORT) spaceH18,
        if (widget.reportItem.type == REPORT)
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.icStarFocus,
                      width: 16,
                      height: 16,
                      color: AppTheme.getInstance().unselectColor(),
                    ),
                    spaceW13,
                    Text(
                      S.current.yeu_thich,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().unselectedColor(),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                customSwitch(
                  isLove,
                  (value) {
                    isLove = !isLove;
                    setState(() {
                      if (isLove) {
                        showDiaLog(
                          context,
                          title: S.current.yeu_thich_thu_muc,
                          isClose: false,
                          btnLeftTxt: S.current.huy,
                          btnRightTxt: S.current.dong_y,
                          showTablet: true,
                          textContent: S.current.ban_co_chac_chan_yeu_thich,
                          icon: SvgPicture.asset(
                            bao_cao.ImageAssets.ic_star_bold,
                          ),
                          funcBtnLeft: () {
                            isLove = widget.isFavorite;
                            setState(() {});
                          },
                          funcBtnRight: () {
                            widget.cubit.postFavorite(
                              idReport: [widget.reportItem.id ?? ''],
                            ).then((value) {
                              if (value) {
                                MessageConfig.show(
                                  title: S.current.yeu_thich_thanh_cong,
                                );
                              } else {
                                MessageConfig.show(
                                  title: S.current.yeu_thich_that_bai,
                                  messState: MessState.error,
                                );
                              }
                            });
                          },
                        ).then((value) {});
                      } else {
                        showDiaLog(
                          context,
                          isClose: false,
                          title: S.current.yeu_thich_thu_muc,
                          btnLeftTxt: S.current.huy,
                          btnRightTxt: S.current.dong_y,
                          showTablet: true,
                          textContent: S.current.ban_co_bo_chac_chan_yeu_thich,
                          icon: SvgPicture.asset(
                            bao_cao.ImageAssets.ic_star_bold,
                          ),
                          funcBtnRight: () {
                            widget.cubit.putDislikeFavorite(
                              idReport: [widget.reportItem.id ?? ''],
                            ).then((value) {
                              if (value) {
                                MessageConfig.show(
                                  title: S.current.huy_yeu_thich_thanh_cong,
                                );
                              } else {
                                MessageConfig.show(
                                  title: S.current.huy_yeu_thich_that_bai,
                                  messState: MessState.error,
                                );
                              }
                            });
                          },
                          funcBtnLeft: () {
                            isLove = widget.isFavorite;
                            setState(() {});
                          },
                        ).then((value) {});
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        spaceH30,
      ],
    );
  }
}

Widget reportLine({double left = 48}) => Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: left,
      ),
      child: Container(
        height: 1,
        width: double.infinity,
        color: borderColor.withOpacity(0.5),
      ),
    );