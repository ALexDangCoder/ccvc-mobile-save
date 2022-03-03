import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/tong_hop_nhiem_vu_model.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NhiemVuWidget extends StatelessWidget {
  final String? urlIcon;
  final String title;
  final String value;
  final TongHopNhiemVuType type;
  const NhiemVuWidget({
    Key? key,
    this.value = '0',
    this.title = '',
    this.urlIcon,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: backgroundRowColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (urlIcon == null)
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: tabSelected,
              ),
            )
          else
            SvgPicture.asset(urlIcon ?? ''),
          SizedBox(
            height: 12.0.textScale(space: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: textNormal(
                textTitle,
                12.0.textScale(space: 4),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 4.0.textScale(space: 8),
          ),
          Text(
            value,
            style: titleText(
                color: type == TongHopNhiemVuType.dangThucHienQuaHan
                    ? statusCalenderRed
                    : numberOfCalenders,
                fontSize: 22),
          )
        ],
      ),
    );
  }
}
