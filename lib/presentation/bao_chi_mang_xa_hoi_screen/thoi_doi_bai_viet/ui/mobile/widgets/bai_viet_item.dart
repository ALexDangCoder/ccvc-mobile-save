import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaiVietItem extends StatefulWidget {
  final BaiVietModel baiVietModel;

  const BaiVietItem({Key? key, required this.baiVietModel}) : super(key: key);

  @override
  _BaiVietItemState createState() => _BaiVietItemState();
}

class _BaiVietItemState extends State<BaiVietItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cellColorborder),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    widget.baiVietModel.iconUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(ImageAssets.icDongNai);
                    },
                  ),
                ),
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
                        widget.baiVietModel.domain,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textNormalCustom(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color:  AppTheme.getInstance().colorField(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.icCalendar),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateTime.parse(
                              widget.baiVietModel.publishedTime
                                  .replaceAll("/", "-"),
                            ).formatApiSSAM,
                            style: textNormalCustom(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: dateColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewScreen(url: widget.baiVietModel.url, title: ''),
                ),
              );
            },
            child: Container(
              height: 170,
              width: double.maxFinite,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColorTab,
              ),
              child: Image.network(
                widget.baiVietModel.imageSources,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        ImageAssets.icDongNai,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              widget.baiVietModel.title,
              style: textNormalCustom(
                color: titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewScreen(url: widget.baiVietModel.url, title: ''),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
