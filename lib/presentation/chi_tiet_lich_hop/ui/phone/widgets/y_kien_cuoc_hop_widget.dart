import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/them_y_kien__widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class YKienCuocHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const YKienCuocHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _YKienCuocHopWidgetState createState() => _YKienCuocHopWidgetState();
}

class _YKienCuocHopWidgetState extends State<YKienCuocHopWidget> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        title: S.current.y_kien_cuop_hop,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              IconWithTiltleWidget(
                icon: ImageAssets.Comment_ic,
                title: S.current.them_y_kien,
                onPress: () {
                  showBottomSheetCustom(
                    context,
                    title: S.current.them_y_kien,
                    child: ThemYKienWidget(
                      cubit: widget.cubit,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              if (widget.cubit.handingCommentLichHop.TenNhanVien != '')
                CommentWidget(
                  object: widget.cubit.handingCommentLichHop,
                )
              else
                const SizedBox(
                  height: 200,
                  child: NodataWidget(),
                )
            ],
          ),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            IconWithTiltleWidget(
              icon: ImageAssets.icChartFocus,
              title: S.current.them_y_kien,
              onPress: () {
                showBottomSheetCustom(
                  context,
                  title: S.current.them_y_kien,
                  child: ThemYKienWidget(
                    cubit: widget.cubit,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            if (widget.cubit.handingCommentLichHop.TenNhanVien != '')
              CommentWidget(
                object: widget.cubit.handingCommentLichHop,
              )
            else
              const SizedBox(
                height: 200,
                child: NodataWidget(),
              )
          ],
        ),
      ),
    );
  }
}
