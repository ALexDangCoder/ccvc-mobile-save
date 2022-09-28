import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/sua_danh_ba_ca_nhan/sua_danh_ba_ca_nhan.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellListCaNhan extends StatefulWidget {
  final Items item;
  final int index;
  final DanhBaDienTuCubit cubit;

  const CellListCaNhan({
    Key? key,
    required this.item,
    required this.index,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CellListCaNhan> createState() => _CellListCaNhanState();
}

class _CellListCaNhanState extends State<CellListCaNhan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderButtomColor),
          color: bgDropDown.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: colorLineSearch.withOpacity(0.3)),
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: bgImage.withOpacity(0.1),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.anhDaiDienFilePath ?? '',
                          errorWidget: (_, __, ___) {
                            return Container(
                              height: 56,
                              width: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: choTrinhKyColor,
                              ),
                              child: Center(
                                child: Text(
                                  widget.cubit
                                      .subString(widget.item.hoTen ?? ''),
                                  style: titleText(fontSize: 24),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // SvgPicture.asset(ImageAssets.icTron),
                  ],
                ),
              ),
              spaceW16,
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.hoTen ?? '',
                      style: textNormalCustom(fontSize: 16, color: color3D5586),
                    ),
                    spaceH6,
                    Text(
                      S.current.nhan_vien,
                      style: tokenDetailAmount(
                        fontSize: 14,
                        color: colorA2AEBD,
                      ),
                    ),
                    spaceH12,
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icPhone,
                          color: AppTheme.getInstance().colorField(),
                        ),
                        spaceW16,
                        Flexible(
                          child: Text(
                            widget.item.phoneDiDong ??
                                widget.item.phoneCoQuan ??
                                widget.item.phoneNhaRieng ??
                                '',
                            style: tokenDetailAmount(
                              fontSize: 14,
                              color: dateColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceH12,
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icMail,
                          color: AppTheme.getInstance().colorField(),
                        ),
                        spaceW16,
                        Flexible(
                          child: Text(
                            widget.item.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: tokenDetailAmount(
                              fontSize: 14,
                              color: dateColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.sua_danh_ba_ca_nhan,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: SuaDanhBaCaNhan(
                              item: widget.item,
                              id: widget.item.id ?? '',
                              cubit: widget.cubit,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        ImageAssets.icEdit,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDiaLog(
                          context,
                          title: S.current.xoa_danh_ba,
                          icon: SvgPicture.asset(ImageAssets.icXoaDanhBa),
                          btnLeftTxt: S.current.huy,
                          btnRightTxt: S.current.xoa,
                          funcBtnRight: () {
                            widget.cubit
                                .xoaDanhBa(id: widget.item.id ?? '')
                                .then((value) {
                              if (value == true) {
                                if (widget.cubit.loadMoreListController.hasValue) {
                                  final data =
                                      widget.cubit.loadMoreListController.value;
                                  data.removeWhere((element) =>
                                      element.id == widget.item.id);
                                  widget.cubit.loadMoreListController.sink
                                      .add(data);
                                }
                              }
                              Navigator.pop(context, true);
                            });
                          },
                          textContent: S.current.content_xoa_danh_ba,
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.icDelete),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      tabletScreen: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderButtomColor),
          color: backgroundColorApp,
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: colorLineSearch.withOpacity(0.3)),
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: bgImage.withOpacity(0.1),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.anhDaiDienFilePath ?? '',
                          errorWidget: (_, __, ___) {
                            return Container(
                              height: 56,
                              width: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: choTrinhKyColor,
                              ),
                              child: Center(
                                child: Text(
                                  widget.cubit
                                      .subString(widget.item.hoTen ?? ''),
                                  style: titleText(fontSize: 24),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceW16,
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.hoTen ?? '',
                      style: textNormalCustom(fontSize: 16, color: color3D5586),
                    ),
                    spaceH24,
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icNhanVien),
                        spaceW16,
                        Text(
                          S.current.nhan_vien,
                          style: tokenDetailAmount(
                            fontSize: 16,
                            color: dateColor,
                          ),
                        )
                      ],
                    ),
                    spaceH24,
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icCalling),
                            spaceW16,
                            Text(
                              widget.item.phoneDiDong ??
                                  widget.item.phoneCoQuan ??
                                  widget.item.phoneNhaRieng ??
                                  '',
                              style: tokenDetailAmount(
                                fontSize: 16,
                                color: dateColor,
                              ),
                            )
                          ],
                        ),
                        spaceW30,
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icMessage),
                            spaceW16,
                            Text(
                              widget.item.email ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: tokenDetailAmount(
                                fontSize: 16,
                                color: dateColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDiaLogTablet(
                          context,
                          title: S.current.sua_danh_ba_ca_nhan,
                          isBottomShow: false,
                          child: SuaDanhBaCaNhan(
                            item: widget.item,
                            id: widget.item.id ?? '',
                            cubit: widget.cubit,
                          ),
                          funcBtnOk: () {},
                          maxHeight: 844,
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.icEdit),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDiaLog(
                          context,
                          showTablet: true,
                          title: S.current.xoa_danh_ba,
                          icon: SvgPicture.asset(ImageAssets.icXoaDanhBa),
                          btnLeftTxt: S.current.huy,
                          btnRightTxt: S.current.xoa,
                          funcBtnRight: () {
                            widget.cubit
                                .xoaDanhBa(id: widget.item.id ?? '')
                                .then((value) {
                              Navigator.pop(context, true);
                            });
                          },
                          textContent: S.current.content_xoa_danh_ba,
                        );
                      },
                      child: SvgPicture.asset(ImageAssets.icDelete),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
