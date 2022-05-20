import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/title_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MauMacDinhWidget extends StatefulWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const MauMacDinhWidget({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _MauMacDinhWidgetState createState() => _MauMacDinhWidgetState();
}

class _MauMacDinhWidgetState extends State<MauMacDinhWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ItemSelectModel>>(
        stream: widget.taoLichLamViecCubit.listColorDefaultStream,
        builder: (context, snapshot) {
          final index =
              snapshot.data?.indexWhere((element) => element.isSelect == true) ?? 0;

          return TitleWidget(
            isColor: true,
            isLine: true,
            color: listColorDefault[index].color,
            title: listColorDefault[index].text,
            child: Column(
              children: listColorDefault
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        widget.taoLichLamViecCubit.selectColor(e);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 12.0.textScale(),
                                      width: 12.0.textScale(),
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.5.textScale(),
                                    ),
                                    Text(
                                      e.text,
                                      style: textNormal(color3D5586, 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                if (e.isSelect)
                                  SvgPicture.asset(ImageAssets.icCheck)
                                else
                                  Container(),
                              ],
                            ),
                            const SizedBox(height: 21,),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
