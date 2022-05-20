import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHoiDapWidgetTablet extends StatelessWidget {
  final String tieuDe;
  final String chuDe;
  final String loaiHDSD;
  final Function onTapEdit;
  final Function onTapXoa;

  const CustomHoiDapWidgetTablet({
    Key? key,
    required this.tieuDe,
    required this.chuDe,
    required this.loaiHDSD,
    required this.onTapEdit,
    required this.onTapXoa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
        color: colorFFFFFF,
      ),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '${S.current.tieu_de} :',
                style: textNormalCustom(
                  fontSize: 16.0,
                  color: color667793,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tieuDe,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: textNormalCustom(
                      fontSize: 18.0,
                      color: color3D5586,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.current.chu_de,
                          style: textNormalCustom(
                            fontSize: 16.0,
                            color: color667793,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          chuDe,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: textNormalCustom(
                            fontSize: 16.0,
                            color: color3D5586,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.current.loai_hdsd,
                          style: textNormalCustom(
                            fontSize: 16.0,
                            color: color667793,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          loaiHDSD,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: textNormalCustom(
                            fontSize: 16.0,
                            color: color3D5586,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onTapEdit();
                  },
                  child: SvgPicture.asset(
                    ImageAssets.icEditBlue,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    onTapXoa();
                  },
                  child: SvgPicture.asset(ImageAssets.icDeleteRed),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
