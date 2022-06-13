import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/widgets/thiep_back_ground_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ThiepChucMungSinhNhatWidget extends StatelessWidget {
  const ThiepChucMungSinhNhatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: ThiepBackgroundWidget(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      height: 72.0.textScale(space: 48),
                      width: 72.0.textScale(space: 48),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Cao Tiến Dũng',
                      style: textNormalCustom(
                          fontSize: 16.0.textScale(space: 4), color: textTitle),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Gửi thiệp mừng',
                      style: textNormal(color667793, 14.0.textScale()),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: borderColor.withOpacity(0.5)))),
            child: Text(
              "Chúc em tuổi mới thành công! Gặp nhiều may mắn trong cuộc sống!",
              style: textNormal(color3D5586, 14.0.textScale(space: 4)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
