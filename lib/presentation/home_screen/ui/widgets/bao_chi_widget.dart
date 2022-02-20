
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaoChiWidget extends StatelessWidget {
  final PressNetWorkModel data;

 const BaoChiWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 90,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child:  CachedNetworkImage(
              imageUrl: data.avatar,
              fit: BoxFit.cover,
              errorWidget: (context, _, err) {
                return Image.network(
                  ImageConstants.noImageFound,
                  fit: BoxFit.cover,
                );
              },

            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: textNormal(
                    titleColor,
                    14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.icCalendarUnFocus),
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      DateTime.parse(data.publishedTime).formatDdMMYYYY,
                      style: textNormal(
                        infoColor,
                        14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Text(
                    data.domain,
                    style: textNormal(
                      linkColor,
                      14,
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
