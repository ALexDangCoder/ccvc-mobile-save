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
  final ReportItem item;
  final ReportListCubit cubit;
  final bool isFavorite;
  final bool isIconClose;

  const ItemReportShareFavorite({
    Key? key,
    required this.item,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ItemFolder(
                    type: widget.item.type ?? 0,
                    isShare: widget.item.shareToMe ?? false,
                    isListView: true,
                    fileNumber: widget.item.childrenTotal ?? 0,
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
                              : MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            widget.item.name ?? '',
                            style: textNormalCustom(
                              color: textTitle,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        spaceH4,
                        Text(
                          (widget.item.dateTime ?? '').changeToNewPatternDate(
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
        if (widget.cubit.checkShare(listAccess: widget.item.accesses ?? []))
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
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ChiaSeBaoCaoTablet(
                          idReport: widget.item.id ?? '',
                          appId: widget.cubit.appId,
                          type: widget.item.type ?? 0,
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
                        idReport: widget.item.id ?? '',
                        appId: widget.cubit.appId,
                        type: widget.item.type ?? 0,
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
        if (widget.item.type == REPORT && !(widget.item.shareToMe ?? true))
          reportLine(),
        if (widget.item.type == REPORT) ...[
          spaceH18,
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
                              idReport: [widget.item.id ?? ''],
                            ).then((value) {
                              if (value) {
                                MessageConfig.show(
                                  title: S.current.yeu_thich_thanh_cong,
                                );
                                Navigator.pop(context);
                              } else {
                                MessageConfig.show(
                                  title: S.current.yeu_thich_that_bai,
                                  messState: MessState.error,
                                );
                                Navigator.pop(context);
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
                              idReport: [widget.item.id ?? ''],
                            ).then((value) {
                              if (value) {
                                MessageConfig.show(
                                  title: S.current.huy_yeu_thich_thanh_cong,
                                );
                                Navigator.pop(context);
                              } else {
                                MessageConfig.show(
                                  title: S.current.huy_yeu_thich_that_bai,
                                  messState: MessState.error,
                                );
                                Navigator.pop(context);
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
        ],
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
