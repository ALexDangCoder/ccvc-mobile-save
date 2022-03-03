import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongTinNguoiPhanAnh extends StatefulWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const ThongTinNguoiPhanAnh({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThongTinNguoiPhanAnhState createState() => _ThongTinNguoiPhanAnhState();
}

class _ThongTinNguoiPhanAnhState extends State<ThongTinNguoiPhanAnh> {
  @override
  Widget build(BuildContext context) {
    final data = widget.cubit.getMapDataNguoiPhananh();
    return Column(
      children: [
        Row(
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
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        RadioImage(
                          type: S.current.ca_nhan,
                          isSelect: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioImage(type: S.current.to_chuc),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        RadioImage(type: S.current.doanh_nghiep),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioImage(type: S.current.co_quan_nha_muoc),
                      ],
                    ),
                  )
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
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ItemRow(
              title: data[index].title,
              content: data[index].content,
            );
          },
        ),
      ],
    );
  }
}


class ThongTinNguoiPhanAnhTablet extends StatefulWidget {
  final ChiTietYKienNguoiDanCubit cubit;
  const ThongTinNguoiPhanAnhTablet({Key? key,required this.cubit}) : super(key: key);

  @override
  _ThongTinNguoiPhanAnhTabletState createState() => _ThongTinNguoiPhanAnhTabletState();
}

class _ThongTinNguoiPhanAnhTabletState extends State<ThongTinNguoiPhanAnhTablet> {
  @override
  Widget build(BuildContext context) {
    final data = widget.cubit.getMapDataNguoiPhananh();
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
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ItemRow(
              title: data[index].title,
              content: data[index].content,
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

  const RadioImage({Key? key, this.isSelect = false, required this.type})
      : super(key: key);

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
