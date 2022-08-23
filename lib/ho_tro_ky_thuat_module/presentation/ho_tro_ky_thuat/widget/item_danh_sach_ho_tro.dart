import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDanhSachHoTro extends StatelessWidget {
  final bool isLine;
  final ThanhVien objThanhVien;
  final HoTroKyThuatCubit cubit;

  const ItemDanhSachHoTro({
    Key? key,
    this.isLine = false,
    required this.objThanhVien,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().choXuLyColor(),
              ),
              child: Center(
                child: Text(
                  cubit.subText(objThanhVien.tenThanhVien ?? ''),
                  style: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getInstance().dfBtnTxtColor(),
                  ),
                ),
              ),
            ),
            spaceW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      '${objThanhVien.tenThanhVien ?? ''}'
                          '${(objThanhVien.chucVu ?? '').isEmpty ? ''
                          : ' - ${objThanhVien.chucVu ?? ''}'}',
                      style: textNormalCustom(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.getInstance().infoColors(),
                      ),
                    ),
                  ),
                  spaceH6,
                  Text(
                    objThanhVien.soDienThoai ?? '',
                    style: textNormalCustom(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.getInstance().unselectColor(),
                    ),
                  )
                ],
              ),
            ),
            spaceW12,
            GestureDetector(
              onTap: () {
                if (objThanhVien.soDienThoai?.isNotEmpty ?? false) {
                  _makePhoneCall("tel://${objThanhVien.soDienThoai ?? ''}");
                }
              },
              child: SvgPicture.asset(
                ImageAssets.ic_call,
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
        spaceH16,
        if (!isLine) line(),
      ],
    );
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
