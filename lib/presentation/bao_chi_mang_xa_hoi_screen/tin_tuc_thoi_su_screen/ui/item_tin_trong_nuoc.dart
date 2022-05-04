import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemTinTrongNuoc extends StatelessWidget {
  String imgTitle;
  String imgContent;
  String title;
  String content;
  String date;
  String url;
  Function() clickItem;

  ItemTinTrongNuoc({
    Key? key,
    required this.imgTitle,
    required this.imgContent,
    required this.title,
    required this.content,
    required this.date,
    required this.url,
    required this.clickItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFDBDFEF).withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imgTitle.isNotEmpty
                            ? NetworkImage(imgTitle)
                            : const AssetImage(ImageAssets.icDongNai)
                                as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textNormalCustom(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: indicatorColor,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(ImageAssets.icCalendar),
                          Text(
                            date,
                            style: textNormalCustom(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: dateColor,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(ImageAssets.icPlay.svgToTheme()),
                            onTap: () {
                              clickItem();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: url, title: ''),
                ),
              );
            },
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColorTab,
                image: DecorationImage(
                  image: imgContent.isNotEmpty
                      ? NetworkImage(imgContent)
                      : const AssetImage(ImageAssets.icDongNai)
                          as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: url, title: ''),
                ),
              );
            },
            child: Text(
              content,
              style: textNormalCustom(
                color: titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
