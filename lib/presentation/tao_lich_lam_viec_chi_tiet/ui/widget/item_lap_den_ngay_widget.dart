import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_date_picker.dart';
import 'package:flutter/material.dart';

class ItemLapDenNgayWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const ItemLapDenNgayWidget({Key? key, required this.taoLichLamViecCubit}) : super(key: key);

  @override
  _ItemLapDenNgayWidgetState createState() => _ItemLapDenNgayWidgetState();
}

class _ItemLapDenNgayWidgetState extends State<ItemLapDenNgayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.current.lap_den_ngay,style: textNormal(titleColor,16.0),),
              GestureDetector(
                  onTap: () {
                    CupertinoRoundedDatePickerWidget.show(
                      context,
                      minimumYear: 2022,
                      maximumYear: 2060,
                      initialDate: DateTime.now(),
                      onTap: (dateTime) async {
                        widget.taoLichLamViecCubit.dateTimeLapDenNgay =
                            dateTime;
                        widget.taoLichLamViecCubit.changeDateTimeSubject
                            .add(dateTime);
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: StreamBuilder<DateTime>(
                      stream: widget.taoLichLamViecCubit.changeDateTimeSubject.stream,
                      builder: (context, snapshot) {
                        return Text(widget.taoLichLamViecCubit.dateTimeLapDenNgay
                            .toStringWithListFormat,style: textNormal(titleColor,16.0),);
                      }
                  )),
            ],
          ),
          const Divider(
            thickness: 1,
            color: lineColor,
          ),
        ],
      ),
    );
  }
}
