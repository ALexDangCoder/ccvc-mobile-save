import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellBieuQuyet extends StatefulWidget {
  final DanhSachBietQuyetModel infoModel;

  const CellBieuQuyet({
    Key? key,
    required this.infoModel,
  }) : super(key: key);

  @override
  State<CellBieuQuyet> createState() => _CellBieuQuyetState();
}

class _CellBieuQuyetState extends State<CellBieuQuyet> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          color: borderItemCalender.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.ten_bieu_quyet,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.thoi_gian,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.thoi_gian_bq,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.loai_bieu_quyet,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    S.current.danh_sach_lua_chon,
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            spaceW8,
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${widget.infoModel.noiDung}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  Text(
                    '${DateTime.parse(widget.infoModel.thoiGianBatDau ?? '').formatApiListBieuQuyetMobile} - '
                    '${DateTime.parse(widget.infoModel.thoiGianKetThuc ?? '').formatApiFixMeet}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  Text(
                    '00:00:00',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: statusCalenderRed,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  Text(
                    loaiBieuQuyetFunc(
                      widget.infoModel.loaiBieuQuyet ?? true,
                    ),
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          widget.infoModel.danhSachKetQuaBieuQuyet?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ContainerState(
                            name: widget
                                    .infoModel
                                    .danhSachKetQuaBieuQuyet?[index]
                                    .tenLuaChon ??
                                '',
                            number: widget
                                    .infoModel
                                    .danhSachKetQuaBieuQuyet?[index]
                                    .soLuongLuaChon ??
                                0,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderItemCalender),
            color: borderItemCalender.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.ten_bieu_quyet} : ${widget.infoModel.noiDung}',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                    spaceH16,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.thoi_gian,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.thoi_gian_bq,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.loai_bieu_quyet,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.danh_sach_lua_chon,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: color667793,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateTime.parse(widget.infoModel.thoiGianBatDau ?? '').formatApiListBieuQuyet} - '
                                '${DateTime.parse(widget.infoModel.thoiGianKetThuc ?? '').formatApiListBieuQuyet}',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH14,
                              Text(
                                '00:00:00',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: statusCalenderRed,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH14,
                              Text(
                                loaiBieuQuyetFunc(
                                  widget.infoModel.loaiBieuQuyet ?? true,
                                ),
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH14,
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.infoModel
                                      .danhSachKetQuaBieuQuyet?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: ContainerState(
                                        name: widget
                                                .infoModel
                                                .danhSachKetQuaBieuQuyet?[index]
                                                .tenLuaChon ??
                                            '',
                                        number: widget
                                                .infoModel
                                                .danhSachKetQuaBieuQuyet?[index]
                                                .soLuongLuaChon ??
                                            0,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerState extends StatelessWidget {
  final int number;
  final String name;

  const ContainerState({
    Key? key,
    required this.number,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.textScale(),
            vertical: 4.0.textScale(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: textDefault,
            border: Border.all(
              color: textDefault,
            ),
          ),
          child: Text(
            name,
            style: textNormalCustom(
              color: backgroundColorApp,
              fontSize: 14.0.textScale(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        spaceH6,
        Text(
          '$number',
          style: textNormalCustom(
            color: textDefault,
            fontSize: 14.0.textScale(),
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
