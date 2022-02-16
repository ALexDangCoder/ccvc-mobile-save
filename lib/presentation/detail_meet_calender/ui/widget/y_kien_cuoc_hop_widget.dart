import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/handing_comment.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget/send_comment_widget_lich_hop.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/y_kien_cuoc_hop_widget/them_y_kien_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'icon_tiltle_widget.dart';

class YKienCuocHopWidget extends StatefulWidget {
  const YKienCuocHopWidget({Key? key}) : super(key: key);

  @override
  _YKienCuocHopWidgetState createState() => _YKienCuocHopWidgetState();
}

class _YKienCuocHopWidgetState extends State<YKienCuocHopWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.y_kien_cuop_hop,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            IconWithTiltleWidget(
              icon: ImageAssets.icChartFocus,
              title: S.current.them_y_kien,
              onPress: () {
                showBottomSheetCustom(
                  context,
                  title: S.current.them_y_kien,
                  child: const ThemYKienWidget(),
                );
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            CommentWidget(
              object: handingComment,
            ),


            // CommentChildWidget(
            //   Avatar: "",
            //   HoTenNguoiXin: "hung",
            //   NoiDungXinYKien: "haahah",
            //   opShowReply: (isShow){
            //
            //   },
            //   showMoreComment: true,
            //   otherPeople: "hunga",
            //   showReply: true,
            //   ThoiGianTao: "dasdasd",
            //   toggleReplyControl: true,
            //
            // )
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: widget.listComment.length,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) {
            //       return CommentWidget(
            //         object: widget.listComment[index],
            //         opTapCallBack: (comment) {
            //           widget.opTapDowloadFile(comment);
            //         },
            //       );
            //     })

          ],
        ),
      )
    );
  }
}
