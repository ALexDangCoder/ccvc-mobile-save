import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotNewsTablet extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String content;
  final String url;

  const HotNewsTablet(this.image, this.title, this.date, this.content, this.url,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 241,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              title,
              style: textNormalCustom(
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
                color: titleCalenderWork,
              ).copyWith(height: 1.3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: url, title: ''),
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
                  fontSize: 14.0.textScale(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: textNormalCustom(
              color: color667793,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
