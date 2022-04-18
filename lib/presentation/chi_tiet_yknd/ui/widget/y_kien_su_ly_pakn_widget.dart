import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class YKienXuLyPAKNWidget extends StatefulWidget {
  final YKienXuLyYKNDModel object;

  const YKienXuLyPAKNWidget({Key? key, required this.object}) : super(key: key);

  @override
  _YKienXuLyPAKNWidgetState createState() => _YKienXuLyPAKNWidgetState();
}

class _YKienXuLyPAKNWidgetState extends State<YKienXuLyPAKNWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: toDayColor.withOpacity(0.1),
          border: Border.all(
            color: toDayColor.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(8.0.textScale(space: 4.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.textScale(space: 4.0)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(
                          'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png'),
                    ),
                    SizedBox(
                      width: 14.0.textScale(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.object.tenNguoiChoYKien ?? '',
                        style: textNormalCustom(
                          color: titleColor,
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          DateTime.parse(widget.object.ngayTao ?? '')
                              .formatDdMMYYYY,
                          softWrap: true,
                          style: textNormalCustom(
                            color: infoColor,
                            fontSize: 12.0.textScale(space: 4.0),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0.textScale(space: 4.0),
                ),
                Text(
                  widget.object.noiDung ?? '',
                  style: textNormalCustom(
                    color: titleColor,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0.textScale(space: 4.0)),
                    child: Text(
                      S.current.khong_co_file,
                      style: textNormalCustom(
                        color: toDayColor,
                        fontSize: 12.0.textScale(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}
