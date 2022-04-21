
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/widget/item_row.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NguoiPhanAnhTablet extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;
  final int indexCheck;

  const NguoiPhanAnhTablet(
      {Key? key, required this.listRow, required this.indexCheck})
      : super(key: key);

  @override
  _ThongTinNguoiPhanAnhState createState() => _ThongTinNguoiPhanAnhState();
}

class _ThongTinNguoiPhanAnhState extends State<NguoiPhanAnhTablet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                S.current.doi_tuong_nop,
                style: textNormalCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: titleCalenderWork,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  RadioImage(
                    type: S.current.ca_nhan,
                    isSelect: widget.indexCheck==0?true:false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(
                      isSelect: widget.indexCheck==2?true:false,
                      type: S.current.to_chuc),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(
                  isSelect: widget.indexCheck==1?true:false,
                      type: S.current.doanh_nghiep),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(
                    isSelect: widget.indexCheck==3?true:false,
                    type: S.current.co_quan_nha_muoc,),
                   const SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.listRow.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: ItemRow(
                title: widget.listRow[index].title,
                content: widget.listRow[index].content,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ThongTinNguoiPhanAnhTablet extends StatefulWidget {
  final List<DataRowChiTietKienNghi> listRow;

  const ThongTinNguoiPhanAnhTablet({
    Key? key,
    required this.listRow,
  }) : super(key: key);

  @override
  _ThongTinNguoiPhanAnhTabletState createState() =>
      _ThongTinNguoiPhanAnhTabletState();
}

class _ThongTinNguoiPhanAnhTabletState
    extends State<ThongTinNguoiPhanAnhTablet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                S.current.doi_tuong_nop,
                style: textNormalCustom(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: titleCalenderWork,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  RadioImage(
                    type: S.current.ca_nhan,
                    isSelect: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(type: S.current.to_chuc),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(type: S.current.doanh_nghiep),
                  const SizedBox(
                    height: 16,
                  ),
                  RadioImage(type: S.current.co_quan_nha_muoc)
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.listRow.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: ItemRow(
                title: widget.listRow[index].title,
                content: widget.listRow[index].content,
              ),
            );
          },
        ),
      ],
    );
  }
}

class RadioImage extends StatelessWidget {
  final bool isSelect;
  final String type;
  const RadioImage({
    Key? key,
    this.isSelect = false,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          isSelect ? ImageAssets.ic_CheckedDate : ImageAssets.ic_unChecked,
          height: 16.0.textScale(),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          type,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: titleCalenderWork,
          ),
        )
      ],
    );
  }
}