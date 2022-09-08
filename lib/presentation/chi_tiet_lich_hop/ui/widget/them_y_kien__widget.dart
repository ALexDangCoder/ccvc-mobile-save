
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';

class ThemYKienWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const ThemYKienWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _ThemYKienWidgetState createState() => _ThemYKienWidgetState();
}

class _ThemYKienWidgetState extends State<ThemYKienWidget> {
  final TextEditingController yKien = TextEditingController();
  String phienHopId= '';

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomInset: 130,
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.them,
          onClickLeft: () {
            Navigator.pop(context);
          },
          onClickRight: () async {
            Navigator.pop(
              context,
              phienHopId,
            );
            await widget.cubit.themYKien(
              yKien: yKien.value.text,
              idLichHop: widget.id,
              phienHopId: phienHopId,
            );
          },
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Text(
              S.current.cuoc_hop,
              style: tokenDetailAmount(
                color: dateColor,
                fontSize: 14.0,
              ),
            ),
          ),
          StreamBuilder<List<ListPhienHopModel>>(
            stream: widget.cubit.danhSachChuongTrinhHop.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              final listCuocHop = data.map((e) => e.tieuDe ?? '').toList();
              return CustomDropDown(
                value: S.current.cuoc_hop,
                items: listCuocHop
                  ..insert(0, S.current.cuoc_hop)
                  ..toSet().toList(),
                onSelectItem: (index) {
                  //index - 1 do listCuocHop insert(0, S.current.cuoc_hop)
                  if (index > 0) {
                    phienHopId = data[index - 1].id ?? '';
                    widget.cubit.tenPhienHop = data[index - 1].tieuDe ?? '';
                  } else {
                    phienHopId = '';
                  }
                },
              );
            },
          ),
          spaceH16,
          ItemTextFieldWidget(
            hint: '',
            title: S.current.y_kien_cuop_hop,
            controller: yKien,
            maxLine: 6,
            validator: (String? value) {},
            onChange: (String value) {},
          ),
          spaceH24,
        ],
      ),
    );
  }
}
