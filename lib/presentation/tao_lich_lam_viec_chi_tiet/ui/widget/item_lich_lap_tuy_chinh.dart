import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class LichLapTuyChinh extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const LichLapTuyChinh({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _LichLapTuyChinhState createState() => _LichLapTuyChinhState();
}

class _LichLapTuyChinhState extends State<LichLapTuyChinh> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 14.0,top: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.taoLichLamViecCubit.listDayOffWeek
            .map((e) => GestureDetector(
                  onTap: () {
                    e.isChoose = !(e.isChoose ?? false);
                    setState(() {});
                    final a = widget.taoLichLamViecCubit.lichLapItem
                        .add(e.index ?? 0);
                    if (!a) {
                      widget.taoLichLamViecCubit.lichLapItem
                          .remove(e.index ?? 0);
                    }
                    final b = widget.taoLichLamViecCubit.lichLapItem.toList();
                    b.sort();
                    widget.taoLichLamViecCubit.lichLapItem1 = b;
                  },
                  child: itemLichLapTuyChinh(e.isChoose ?? false, e.name ?? ''),
                ))
            .toList(),
      ),
    );
  }
}

Widget itemLichLapTuyChinh(bool isCheck, String title) {
  return Container(
      margin: EdgeInsets.only(left: 14.0),
      height: 32.0,
      width: 32.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCheck ? textDefault : textDefault.withOpacity(0.1)),
      child: Center(
        child: Text(
          title,
          style: textNormal(isCheck ? backgroundColorApp : textDefault, 14),
        ),
      ));
}