import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class GhiChuKyHieuWidget extends StatelessWidget {
  const GhiChuKyHieuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            S.current.ghi_chu_ky_hieu_tren_lich_thang,
            style: textNormalCustom(
              fontSize: 16.0,
              color: color3D5586,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: const BoxDecoration(
                      color: choVaoSoColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    S.current.ngay_hoang_dao,
                    style: textNormalCustom(
                      fontSize: 14.0,
                      color: color3D5586,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: const BoxDecoration(
                      color: color3D5586,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    S.current.ngay_hach_dao,
                    style: textNormalCustom(
                      fontSize: 14.0,
                      color: color3D5586,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
