import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/handing_comment.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final HandingComment object;

  const CommentWidget({Key? key, required this.object}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
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
          padding:  EdgeInsets.all(16.0.textScale(space: 4.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    CachedNetworkImageProvider(widget.object.avatar??''),
                  ),
                  SizedBox(
                    width: 14.0.textScale(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.object.tenNhanVien??'',
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
                  Text(
                    DateTime.parse(widget.object.ngayTao??'').formatDdMMYYYY,
                    style: textNormalCustom(
                      color: infoColor,
                      fontSize: 12.0.textScale(space: 4.0),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.0.textScale(space: 4.0),
              ),
              Text(
                widget.object.noiDung??'',
                style: textNormalCustom(
                  color: titleColor,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (widget.object.listFile.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      S.current.cac_van_ban_dinh_kem,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 12.0.textScale(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.object.listFile.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //xem file
                              },
                              child: Text(
                                widget.object.listFile[index],
                                style: textNormalCustom(
                                  color: textColorMangXaHoi,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0.textScale(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                )
              else
                Padding(
                  padding:  EdgeInsets.only(top: 10.0.textScale(space: 4.0)),
                  child: Text(
                    S.current.khong_co_file,
                    style: textNormalCustom(
                      color: toDayColor,
                      fontSize: 12.0.textScale(),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
  ]
          ),
        ),
      ),
    );
  }
}
