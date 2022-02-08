import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
  @override
  Widget build(BuildContext context) {
    final cubit = DetailMeetCalendarInherited
        .of(context)
        .cubit;

    return SelectOnlyWidget(
        title: S.current.ket_luan_hop,
        child: StreamBuilder<KetLuanHopModel>(
            stream: cubit.ketLuanHopStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;

                return ItemKetLuanHopWidget(title: S.current.ket_luan_hop,
                    time: data?.thoiGian ?? '',
                    trangThai: data?.trangThai ?? TrangThai.ChoDuyet,
                    tinhTrang: data?.tinhTrang ?? TinhTrang.TrungBinh,);
              }

              else {
                return Container();
              }
            })
    );
  }
}

class ItemKetLuanHopWidget extends StatelessWidget {
  final String title;
  final String time;
  final TrangThai trangThai;
  final TinhTrang tinhTrang;

  const ItemKetLuanHopWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.trangThai,
    required this.tinhTrang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

                },

                child: SvgPicture.asset(ImageAssets.icThreeDotMenu),
              )
            ],
          )
        ],
      ),
    );
  }
}
