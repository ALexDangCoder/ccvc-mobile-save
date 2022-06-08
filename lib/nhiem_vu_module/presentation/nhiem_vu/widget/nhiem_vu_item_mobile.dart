import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NhiemVuItemMobile extends StatelessWidget {
  final PageData data;
  final Function onTap;

  const NhiemVuItemMobile({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColorApp,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 6.0),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusCalenderRed,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (data.noiDungTheoDoi ?? '').parseHtml(),
                        style: titleAppbar(
                            fontSize: 16.0,
                            color: data.trangThaiHanXuLy?.trangThaiHanXuLy() ??
                                textTitle),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      spaceH8,
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              data.hanXuLy ?? DateTime.now().formatDdMMYYYY,
                              style: textNormalCustom(
                                color: textBodyTime,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              data.ownerTypeName ?? '',
                              style: titleAppbar(fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      spaceH10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.nguoiGiaoViec ?? '',
                                  style: textNormalCustom(
                                    color: unselectedLabelColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${S.current.nhiem_vu}: ${data.loaiNhiemVu} ',
                                  style: textNormalCustom(
                                    color: unselectedLabelColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 101.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: data.maTrangThai?.trangThaiColorNhiemVu(),
                            ),
                            child: Center(
                              child: Text(
                                data.trangThai ?? '',
                                style: textNormalCustom(fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
