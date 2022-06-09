import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ItemAnhKhongDeoKinh extends StatelessWidget {
  final String image;
  final String title;
  const ItemAnhKhongDeoKinh({Key? key, required this.image, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.goc_anh,
            style: textNormalCustom(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: color3D5586),
          ),
          spaceH14,
          Text(
            title,
            style: textNormalCustom(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: color667793),
          ),
          spaceH16,
          SizedBox(
            height: 164,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Container(
                          height: 164,
                          decoration: BoxDecoration(
                            border: Border.all(color: colorE2E8F0),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],

                          ),
                          child: Image.asset(image,fit: BoxFit.cover,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: color3D5586.withOpacity(0.8),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: Text(
                              S.current.anh_mau,
                              style: TextStyle(color: colorFFFFFF),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                spaceW16,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: colorE2E8F0),
                        borderRadius: BorderRadius.circular(8.0),
                         color: colorFFFFFF,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.icUpAnh,
                        ),
                        spaceH14,
                        Text(
                          S.current.tai_anh_len,
                          style: textNormal(
                            color667793,
                            14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
