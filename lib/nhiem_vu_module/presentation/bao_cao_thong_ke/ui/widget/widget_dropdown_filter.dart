import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class WidgetDropdownFilter extends StatelessWidget {
  final BaoCaoThongKeCubit cubit;

  const WidgetDropdownFilter({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        right: 16,
        left: 16,
      ),
      child: Row(
        children: [
          boxTextFilter(
            streamText: cubit.textDonViXuLyFilter,
            title: S.current.don_vi_xu_ly,
            funClick: () {
              cubit.isShowDonVi.add(true);
              cubit.isShowCaNhan.add(false);
            },
          ),
          spaceW16,
          boxTextFilter(
            streamText: cubit.textCaNhanXuLyFilter,
            title: S.current.ca_nhan_xu_ly,
            funClick: () {
              cubit.isShowCaNhan.add(true);
              cubit.isShowDonVi.add(false);
            },
          ),
        ],
      ),
    );
  }

  Widget boxTextFilter({
    required BehaviorSubject<String> streamText,
    required Function funClick,
    required String title,
  }) =>
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: textNormal(titleItemEdit, 14.0),
              ),
            ),
            GestureDetector(
              onTap: () => funClick(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: cellColorborder),
                  borderRadius: BorderRadius.circular(4.0),
                  color: backgroundColorApp,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: StreamBuilder<String>(
                        stream: streamText,
                        builder: (context, snapshot) {
                          final String text = snapshot.data ?? '';
                          return Text(
                            text,
                            style: textNormalCustom(
                              color: color3D5586,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        ImageAssets.ic_drop_down,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
