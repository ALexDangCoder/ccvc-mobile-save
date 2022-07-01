import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/them_y_kien__widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

class YKienCuocHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const YKienCuocHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _YKienCuocHopWidgetState createState() => _YKienCuocHopWidgetState();
}

class _YKienCuocHopWidgetState extends State<YKienCuocHopWidget> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isMobile()) {
      widget.cubit.callApiYkienCuocHop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value) {
            widget.cubit.callApiYkienCuocHop();
          }
        },
        title: S.current.y_kien_cuop_hop,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ThemYKienWidgetForPhoneAndTab(widget.cubit),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SingleChildScrollView(
          child: ThemYKienWidgetForPhoneAndTab(widget.cubit),
        ),
      ),
    );
  }

  Widget ThemYKienWidgetForPhoneAndTab(DetailMeetCalenderCubit cubit) => Column(
        children: [
          IconWithTiltleWidget(
            icon: ImageAssets.Comment_ic,
            title: S.current.them_y_kien,
            onPress: () {
              showBottomSheetCustom(
                context,
                title: S.current.y_kien,
                child: ThemYKienWidget(
                  cubit: cubit,
                  id: cubit.idCuocHop,
                ),
              );
            },
          ),
          StreamBuilder<List<YkienCuocHopModel>>(
            stream: cubit.listYKienCuocHop.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              if (data.isEmpty) {
                return const SizedBox();
              }
              return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CommentWidget(
                    object: data[index],
                    cubit: cubit,
                    id: cubit.idCuocHop,
                  );
                },
              );
            },
          )
        ],
      );
}
