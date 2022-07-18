import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/detail_status.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusWidget extends StatelessWidget {
  final StatusDetail status;

  const StatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 17.0.textScale(),
          height: 17.0.textScale(),
          child: Center(
            child: SvgPicture.asset(
              status.getIcon,
              width: 17.0.textScale(),
              height: 17.0.textScale(),
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        if (isMobile())
          Expanded(
            child: textVl(),
          )
        else
          textVl(),
      ],
    );
  }

  Widget textVl() => Text(
        status.getText,
        style: textNormal(status.getColorText, 16),
        overflow: TextOverflow.ellipsis,
      );
}
