import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_select_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';

class MauMacDinhWidget extends StatefulWidget {
  const MauMacDinhWidget({Key? key}) : super(key: key);

  @override
  State<MauMacDinhWidget> createState() => _MauMacDinhWidgetState();
}

class _MauMacDinhWidgetState extends State<MauMacDinhWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          color: choTrinhKyColor,
          title: S.current.mau_mac_dinh,
          isColor: true,
          child: StreamBuilder<List<ItemSelectModel>>(
            stream: WidgetTaoLichLVInherited.of(context)
                .taoLichLamViecCubit
                .listColorDefaultStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final data = snapshot.data ?? [];

              return Column(
                children: data
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          WidgetTaoLichLVInherited.of(context)
                              .taoLichLamViecCubit
                              .selectColor(e);
                        },
                        child: ItemSelectWidget(
                          text: e.text,
                          isSelect: e.isSelect,
                          color: e.color,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
