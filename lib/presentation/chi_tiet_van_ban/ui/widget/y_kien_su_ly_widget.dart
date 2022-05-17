import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class YKienSuLyWidget extends StatefulWidget {
  final DanhSachYKienXuLy object;

  const YKienSuLyWidget({Key? key, required this.object}) : super(key: key);

  @override
  _YKienSuLyWidgetState createState() => _YKienSuLyWidgetState();
}

class _YKienSuLyWidgetState extends State<YKienSuLyWidget> {
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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      widget.object.avatar ??
                          'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png',
                    ),
                  ),
                  SizedBox(
                    width: 14.0.textScale(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.object.tenNhanVien ?? '',
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
              if (widget.object.yKienXuLyFileDinhKem?.isNotEmpty ?? true)
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
                      itemCount: widget.object.yKienXuLyFileDinhKem?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final status = await Permission.storage.status;
                                if (!status.isGranted) {
                                  await Permission.storage.request();
                                  await Permission.manageExternalStorage
                                      .request();
                                }
                                if (widget.object.yKienXuLyFileDinhKem?[index]
                                        .fileDinhKem?.pathIOC ==
                                    null) {
                                  await saveFile(
                                    widget.object.yKienXuLyFileDinhKem?[index]
                                            .fileDinhKem?.ten ??
                                        '',
                                    '$DO_MAIN_DOWLOAD_FILE${widget.object.yKienXuLyFileDinhKem?[index].fileDinhKem?.duongDan ?? ''}',
                                  )
                                      .then(
                                        (value) => MessageConfig.show(
                                            title:
                                                S.current.tai_file_thanh_cong),
                                      )
                                      .onError(
                                        (error, stackTrace) =>
                                            MessageConfig.show(
                                          title: S.current.tai_file_that_bai,
                                          messState: MessState.error,
                                        ),
                                      );
                                } else {
                                  await saveFile(
                                    widget.object.yKienXuLyFileDinhKem?[index]
                                            .fileDinhKem?.ten ??
                                        '',
                                    widget.object.yKienXuLyFileDinhKem?[index]
                                        .fileDinhKem?.pathIOC,
                                  )
                                      .then(
                                        (value) => MessageConfig.show(
                                          title: S.current.tai_file_thanh_cong,
                                        ),
                                      )
                                      .onError(
                                        (error, stackTrace) =>
                                            MessageConfig.show(
                                          title: S.current.tai_file_that_bai,
                                          messState: MessState.error,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                widget.object.yKienXuLyFileDinhKem?[index]
                                        .fileDinhKem?.ten ??
                                    '',
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
            ],
          ),
        ),
      ),
    );
  }
}
