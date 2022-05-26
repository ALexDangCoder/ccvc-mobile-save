import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHoiDapWidget extends StatelessWidget {
  final String tieuDe;
  final String chuDe;
  final String loaiHDSD;
  final Function onTapEdit;
  final Function onTapXoa;

  const CustomHoiDapWidget({
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
        border: Border.all(color: borderButtomColor),
        color: bgDropDown.withOpacity(0.1),
      ),
      height: 140,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.tieu_de,
                      style: textNormalCustom(
                        fontSize: 14.0,
                        color: color667793,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      tieuDe,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: textNormalCustom(
                        fontSize: 14.0,
                        color: textTitle,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.chu_de,
                      style: textNormalCustom(
                        fontSize: 14.0,
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
                        fontSize: 14.0,
                        color: textTitle,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.loai_hdsd,
                      style: textNormalCustom(
                        fontSize: 14.0,
                        color: color667793,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loaiHDSD,
                          style: textNormalCustom(
                            fontSize: 14.0,
                            color: textTitle,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                onTapEdit();
                              },
                              child: SvgPicture.asset(ImageAssets.icEditBlue,color: AppTheme.getInstance().colorField(),),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
