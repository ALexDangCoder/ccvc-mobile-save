import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellListDanhBaToChuc extends StatefulWidget {
  final ItemsToChuc item;
  final int index;
  final DanhBaDienTuCubit cubit;

  const CellListDanhBaToChuc({
    Key? key,
    required this.item,
    required this.index,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CellListDanhBaToChuc> createState() => _CellListDanhBaToChucState();
}

class _CellListDanhBaToChucState extends State<CellListDanhBaToChuc> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: colorE2E8F0),
          color: colorE2E8F0.withOpacity(0.1),
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: color02C5DD,
                      ),
                      child: Center(
                        child: Text(
                          widget.cubit.subString(widget.item.hoTen ?? ''),
                          style: titleText(fontSize: 24),
                        ),
                      ),
                    )
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
                      widget.item.chucVuDetail?.chucVu ?? '',
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
                              color: color667793,
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceH12,
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icMail,
                            color: AppTheme.getInstance().colorField()),
                        spaceW16,
                        Flexible(
                          child: Text(
                            widget.item.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: tokenDetailAmount(
                              fontSize: 14,
                              color: color667793,
                            ),
                          ),
                        )
                      ],
                    ),
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
          border: Border.all(color: colorE2E8F0),
          color: colorE2E8F0.withOpacity(0.1),
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: color02C5DD,
                      ),
                      child: Center(
                        child: Text(
                          widget.cubit.subString(widget.item.hoTen ?? ''),
                          style: titleText(fontSize: 24),
                        ),
                      ),
                    )
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
                    spaceH24,
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icNhanVien),
                        spaceW16,
                        Text(
                          S.current.nhan_vien,
                          style: tokenDetailAmount(
                            fontSize: 16,
                            color: color667793,
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
                                color: color667793,
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
                                color: color667793,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
