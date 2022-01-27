import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_select_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/title_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaiLichWidget extends StatefulWidget {
  const LoaiLichWidget({Key? key}) : super(key: key);

  @override
  _LoaiLichWidgetState createState() => _LoaiLichWidgetState();
}

class _LoaiLichWidgetState extends State<LoaiLichWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ItemSelectModel>>(
        stream: WidgetTaoLichLVInherited.of(context)
            .taoLichLamViecCubit
            .listItemLoaiLichStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              TitleWidget(
                image: ImageAssets.icCalendarUnFocus,
                title: S.current.loai_lich,
                child:  Column(
                  children: listLoaiLich
                      .map(
                        (e) => GestureDetector(
                      onTap: () {
                        WidgetTaoLichLVInherited.of(context)
                            .taoLichLamViecCubit
                            .selectLoaiLich(e);
                      },
                      child: ItemSelectWidget(
                        isSelect: e.isSelect,
                        text: e.text,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          );
        },);
  }
}
