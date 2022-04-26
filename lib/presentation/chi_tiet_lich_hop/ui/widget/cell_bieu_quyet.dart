import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${S.current.phien_hop}:',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: unselectedLabelColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${S.current.ten_can_bo}:',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: unselectedLabelColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${S.current.noi_dung}:',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: unselectedLabelColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${S.current.thoi_gian}:',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: unselectedLabelColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${widget.infoModel.id}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${widget.infoModel.id}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${widget.infoModel.id}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${widget.infoModel.thoiGianKetThuc}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
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
                                  color: unselectedLabelColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.thoi_gian_bq,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: unselectedLabelColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.loai_bieu_quyet,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: unselectedLabelColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                S.current.danh_sach_lua_chon,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: unselectedLabelColor,
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
                                '${widget.infoModel.thoiGianBatDau}-'
                                '${widget.infoModel.thoiGianKetThuc}',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
                              Text(
                                '${widget.infoModel.id}',
                                style: textNormalCustom(
                                  fontSize: 16,
                                  color: infoColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              spaceH16,
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
                              spaceH16,
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
                                        index: widget
                                                .infoModel
                                                .danhSachKetQuaBieuQuyet?[index]
                                                .soLuongLuaChon ??
                                            0,
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
  final int index;

  const ContainerState({
    Key? key,
    required this.number,
    required this.index,
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
            '$index',
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
