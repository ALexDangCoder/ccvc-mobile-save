import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ItemThongBaoGuiNhan extends StatelessWidget {
  final ThongTinGuiNhanModel model;
  final int flexValue;

  const ItemThongBaoGuiNhan({
    Key? key,
    required this.model,
    this.flexValue = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: EdgeInsets.only(
          top: 16.0.textScale(),
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: bgDropDown.withOpacity(0.1),
          border: Border.all(
            color: bgDropDown.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(6.0.textScale(space: 6)),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.nguoi_gui,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.nguoiGui}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.don_vi_gui,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.donViGui}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.thoi_gian,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.thoiGian}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.nguoi_nhan,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.nguoiNhan}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.don_vi_nhan,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.donViNhan}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.vai_tro_xu_ly,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${model.vaiTroXuLy}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      S.current.trang_thai,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: model.trangTBGN?.getColor(),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            '${model.trangThai}',
                            style: textNormalCustom(
                              color: colorFFFFFF,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              spaceH16,
            ],
          ),
        ),
      ),
      tabletScreen: Container(
        margin: EdgeInsets.only(
          top: 16.0.textScale(),
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: bgDropDown.withOpacity(0.1),
          border: Border.all(
            color: bgDropDown.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(6.0.textScale(space: 6)),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.nguoi_gui,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.nguoiGui}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.don_vi_gui,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.donViGui}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.thoi_gian,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.thoiGian}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.nguoi_nhan,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.nguoiNhan}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.don_vi_nhan,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.donViNhan}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.vai_tro_xu_ly,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      '${model.vaiTroXuLy}',
                      style: textNormalCustom(
                        color: textDropDownColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              spaceH16,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.trang_thai,
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: model.trangTBGN?.getColor(),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            '${model.trangThai}',
                            style: textNormalCustom(
                              color: colorFFFFFF,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              spaceH16,
            ],
          ),
        ),
      ),
    );
  }
}
