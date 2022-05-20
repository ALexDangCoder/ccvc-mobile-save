import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellListDanhBaToChucTablet extends StatefulWidget {
  final ItemsToChuc item;
  final int index;
  final DanhBaDienTuCubit cubit;

  const CellListDanhBaToChucTablet({
    Key? key,
    required this.item,
    required this.index,
    required this.cubit,
  }) : super(key: key);

  @override
  State<CellListDanhBaToChucTablet> createState() =>
      _CellListDanhBaToChucTabletState();
}

class _CellListDanhBaToChucTabletState
    extends State<CellListDanhBaToChucTablet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
        color: colorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: colorE5E5E5.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 96,
                  width: 96,
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
                spaceH26,
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icNhanVien),
                    spaceW16,
                    Text(
                      S.current.nhan_vien,
                      style: tokenDetailAmount(
                        fontSize: 16,
                        color: color3D5586,
                      ),
                    )
                  ],
                ),
                spaceH26,
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
                        color: color3D5586,
                      ),
                    )
                  ],
                ),
                spaceH26,
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icMessage),
                    spaceW16,
                    Flexible(
                      child: Text(
                        widget.item.email ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tokenDetailAmount(
                          fontSize: 16,
                          color: color3D5586,
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
    );
  }
}
