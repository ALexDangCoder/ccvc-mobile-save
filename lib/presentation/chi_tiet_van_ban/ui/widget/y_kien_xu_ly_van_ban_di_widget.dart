import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class YKienSuLyVanBanDiWidget extends StatefulWidget {
  final DanhSachChoYKien object;

  const YKienSuLyVanBanDiWidget({Key? key, required this.object}) : super(key: key);

  @override
  _YKienSuLyVanBanDiWidgetState createState() => _YKienSuLyVanBanDiWidgetState();
}

class _YKienSuLyVanBanDiWidgetState extends State<YKienSuLyVanBanDiWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colorDBDFEF.withOpacity(0.1),
          border: Border.all(
            color: colorDBDFEF.withOpacity(0.4),
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
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(widget
                          .object.anhDaiDien ??
                          'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png'),
                    ),
                    SizedBox(
                      width: 14.0.textScale(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.object.tenCanBo ?? '',
                        style: textNormalCustom(
                          color: color3D5586,
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
                          // widget.object.ngayTao??'',
                          softWrap: true,
                          style: textNormalCustom(
                            color: color667793,
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
                    color: color3D5586,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.object.danhSachFiles?.isNotEmpty ?? true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        S.current.cac_van_ban_dinh_kem,
                        style: textNormalCustom(
                          color: color586B8B,
                          fontSize: 12.0.textScale(),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.object.danhSachFiles?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: ()  {



                                },
                                child: Text(
                                  widget.object.danhSachFiles?[index]
                                      .ten ??
                                      '',
                                  style: textNormalCustom(
                                    color: color2F80ED,
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
                    padding: EdgeInsets.only(top: 10.0.textScale(space: 4.0)),
                    child: Text(
                      S.current.khong_co_file,
                      style: textNormalCustom(
                        color: colorDBDFEF,
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
