import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemListTrongNuoc extends StatefulWidget {
  final ItemTrongNuocModel model;

  const ItemListTrongNuoc({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ItemListTrongNuocState createState() => _ItemListTrongNuocState();
}

class _ItemListTrongNuocState extends State<ItemListTrongNuoc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.textScale(space: 8)),
      margin: isMobile()
          ? EdgeInsets.only(
              bottom: 16.0.textScale(space: 10),
              left: 16.0.textScale(space: 14),
              right: 16.0.textScale(space: 14),
            )
          : const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: isMobile() ? colorE2E8F0.withOpacity(0.1) : Colors.white,
        border: Border.all(color: colorE2E8F0),
        borderRadius: BorderRadius.circular(6.0.textScale()),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.model.imageUrlPath ?? '',
            height: 64.0.textScale(space: 32),
            width: 64.0.textScale(space: 32),
          ),
          SizedBox(
            width: 18.0.textScale(space: 10),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  rowData(
                    image: ImageAssets.icChinhPhu,
                    value: widget.model.tenCoQuanLienHe ??
                        S.current.khong_co_du_lieu,
                  ),
                  SizedBox(
                    height: 8.0.textScale(space: 20),
                  ),
                  rowData(
                    image: ImageAssets.icViTri,
                    value: widget.model.diaChi ?? S.current.khong_co_du_lieu,
                  ),
                  SizedBox(
                    height: 8.0.textScale(space: 20),
                  ),
                  rowData(
                    image: ImageAssets.icCalling,
                    value: widget.model.sdt ?? S.current.khong_co_du_lieu,
                  ),
                  SizedBox(
                    height: 8.0.textScale(space: 20),
                  ),
                  rowData(
                    image: ImageAssets.ic_email,
                    value: widget.model.email ?? S.current.khong_co_du_lieu,
                  ),
                  SizedBox(
                    height: 8.0.textScale(space: 20),
                  ),
                  rowData(
                    image: ImageAssets.icFax,
                    value: widget.model.fax ?? S.current.khong_co_du_lieu,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowData({
    required String image,
    required String value,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: 17.0.textScale(space: 3),
          width: 17.0.textScale(space: 3),
        ),
        const SizedBox(
          width: 14.0,
        ),
        Expanded(
          child: Text(
            value,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
