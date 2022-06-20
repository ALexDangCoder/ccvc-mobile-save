import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/text/ellipsis_character_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemListNews extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String url;

  const ItemListNews(this.image, this.title, this.date, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColorTab,
              ),
              clipBehavior: Clip.antiAlias,
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Image.asset(ImageAssets.icDongNai);
                      },
                    )
                  : Image.asset(ImageAssets.icDongNai),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: EllipsisDoubleLineText(
                    title,
                    style: textNormalCustom(
                      color: AppTheme.getInstance().titleColor(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),


                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WebViewScreen(url: url, title: ''),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icCalendar),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date,
                      style: textNormalCustom(
                        color: color667793,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
