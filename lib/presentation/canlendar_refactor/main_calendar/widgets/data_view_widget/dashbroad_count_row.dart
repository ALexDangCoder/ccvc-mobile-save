import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashBroadCountRow extends StatelessWidget {
  DashBroadCountRow({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final CalendarWorkCubit cubit;
  final List<String> img =  [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.icLichLamViec,
    ImageAssets.icLichCongTacNuocNgoai,
    ImageAssets.icLichTiepDan,
    ImageAssets.icAdminTao,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16 , left: 16 , bottom: 16,),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DashBoardLichHopModel>(
              stream: cubit.totalWorkStream,
              builder: (context, snapshot) {
                final data = snapshot.data?.countScheduleCaNhan  ?? 0;
                return itemDashBroad(
                  S.current.tong_so_lich_lam_viec,
                  ImageAssets.icTongSoLichLamviec,
                  data,
                );
              },
            ),
            StreamBuilder<List<LichLamViecDashBroadItem>>(
              stream: cubit.dashBroadStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return itemDashBroad(
                        img[index],
                        data[index].typeName ?? '',
                        data[index].numberOfCalendars ?? 0,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDashBroad(String name, String image, int countDashBroad) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        height: 88,
        width: 274,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: backgroundItemCalender,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceW16,
            Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColorApp,
              ),
              child: Center(
                child: SvgPicture.asset(image),
              ),
            ),
            spaceW16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  softWrap: true,
                  maxLines: 2,
                  style: textNormalCustom(color: titleCalenderWork),
                ),
                Text(
                  countDashBroad.toString(),
                  style: titleText(color: numberOfCalenders, fontSize: 26.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
