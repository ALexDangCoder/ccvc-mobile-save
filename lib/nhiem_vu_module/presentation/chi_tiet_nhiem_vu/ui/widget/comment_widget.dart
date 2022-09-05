import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/y_kien_su_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class YKienSuLyNhiemVuWidget extends StatefulWidget {
  final YKienSuLyNhiemVuModel object;

  const YKienSuLyNhiemVuWidget({Key? key, required this.object})
      : super(key: key);

  @override
  _YKienSuLyNhiemVuWidgetState createState() => _YKienSuLyNhiemVuWidgetState();
}

class _YKienSuLyNhiemVuWidgetState extends State<YKienSuLyNhiemVuWidget> {
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
                      widget.object.avatarCommon.isNotEmpty
                          ? Get.find<AppConstants>().baseImageUrl +
                              widget.object.avatarCommon
                          : AVATAR_DEFAULT,
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
                        color: color3D5586,
                        fontSize: 14.0.textScale(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateTime.parse(widget.object.ngayTao ?? '')
                            .formatApiListBieuQuyetMobile,
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
                  color: color3D5586,
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
                                      fileName: widget
                                              .object
                                              .yKienXuLyFileDinhKem?[index]
                                              .fileDinhKem
                                              ?.ten ??
                                          '',
                                      url: widget
                                              .object
                                              .yKienXuLyFileDinhKem?[index]
                                              .fileDinhKem
                                              ?.duongDan ??
                                          '',
                                      downloadType: DomainDownloadType.QLNV);
                                } else {
                                  await saveFile(
                                    fileName: widget
                                            .object
                                            .yKienXuLyFileDinhKem?[index]
                                            .fileDinhKem
                                            ?.ten ??
                                        '',
                                    url: widget
                                            .object
                                            .yKienXuLyFileDinhKem?[index]
                                            .fileDinhKem
                                            ?.pathIOC ??
                                        '',
                                    // http: true,
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
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
