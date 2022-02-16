import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/handing_comment.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget/them_y_kien_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:flutter/material.dart';

import '../icon_tiltle_widget.dart';

class YKienCuocHopWidgetTablet extends StatefulWidget {
  const YKienCuocHopWidgetTablet({Key? key}) : super(key: key);

  @override
  _YKienCuocHopWidgetTabletState createState() =>
      _YKienCuocHopWidgetTabletState();
}

class _YKienCuocHopWidgetTabletState extends State<YKienCuocHopWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60.0,
            ),
            IconWithTiltleWidget(
              icon: ImageAssets.icChartFocus,
              title: S.current.them_y_kien,
              onPress: () {
                showDiaLogTablet(
                  context,
                  funcBtnOk: () {},
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
                            fontSize: 14.0.textScale(),
                          ),
                        ),
                      ),
                      CustomDropDown(
                        value: 'Cuộc họp',
                        items: const ['Cuộc họp', 'Phiên họp'],
                        onSelectItem: (value) {},
                      ),
                    ],
                  ),
                  title: S.current.y_kien ,
                );
              },
            ),
            CommentWidget(
              object: handingComment,
            ),
          ],
        ));
  }
}
