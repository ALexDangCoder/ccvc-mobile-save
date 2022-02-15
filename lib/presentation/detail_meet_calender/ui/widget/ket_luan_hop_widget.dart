import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/extension_status.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/item_menu_ket_thuc.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KetLuanHopWidget extends StatefulWidget {
  const KetLuanHopWidget({Key? key}) : super(key: key);

  @override
  _KetLuanHopWidgetState createState() => _KetLuanHopWidgetState();
}

class _KetLuanHopWidgetState extends State<KetLuanHopWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited.of(context).cubit;

    return Container(
      color: Colors.transparent,
      child: SelectOnlyWidget(
        title: S.current.ket_luan_hop,
        child: Stack(
          children: [
            StreamBuilder<KetLuanHopModel>(
              stream: cubit.ketLuanHopStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  return ItemKetLuanHopWidget(
                    title: S.current.ket_luan_hop,
                    time: data?.thoiGian ?? '',
                    trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                    tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,
                    onTap: () {
                      isShow = !isShow;
                      setState(() {});
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            if (isShow)
              Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: const Alignment(0.5, 0.5),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.0.textScale(),
                        horizontal: 17.0.textScale(),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: listKetThucView
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return e.ketThuc.getScreen();
                                      },);
                                },
                                child: itemListKetThuc(
                                  name: e.name,
                                  icon: e.icon,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container()
          ],
        ),
      ),
    );
  }

  Widget itemListKetThuc({required String icon, required String name}) {
    return Container(
      width: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SvgPicture.asset(icon)),
          SizedBox(
            width: 10.0.textScale(),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textNormalCustom(
                    color: textTitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                SizedBox(
                  height: 14.0.textScale(),
                ),
                Container(
                  height: 1,
                  color: borderColor.withOpacity(0.5),
                ),
                SizedBox(
                  height: 14.0.textScale(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemKetLuanHopWidget extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;
  final Function onTap;

  const ItemKetLuanHopWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.trangThai,
    required this.tinhTrang,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        border: Border.all(color: bgDropDown),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap();
                },
                child: SvgPicture.asset(ImageAssets.icThreeDotMenu),
              )
            ],
          ),
          widgetRow(
            name: S.current.thoi_gian,
            child: Text(
              time,
              style: textNormalCustom(
                color: textTitle,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          widgetRow(
            name: S.current.trang_thai,
            child: trangThai.getWidget(),
          ),
          widgetRow(
            name: S.current.tinh_trang,
            child: tinhTrang.getWidget(),
          ),
          widgetRow(
            name: S.current.file,
            child: Text(
              'filename.docx',
              style: textNormalCustom(
                color: choXuLyColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetRow({required String name, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: 10.0.textScale()),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: textNormalCustom(
                color: titleColumn,
                fontWeight: FontWeight.w400,
                fontSize: 14.0.textScale(),
              ),
            ),
          ),
          Expanded(flex: 3, child: child),
        ],
      ),
    );
  }
}
