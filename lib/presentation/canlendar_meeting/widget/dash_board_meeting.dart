import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBroadMeeting extends StatelessWidget {
  const DashBroadMeeting({
    Key? key,
    required this.cubit,
    this.isChartView = false,
    this.isTablet = false,
  }) : super(key: key);
  final CalendarMeetingCubit cubit;
  final bool isChartView;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isTablet ? 30 : 16,
        left: isTablet ? 30 : 16,
        bottom: isTablet ? 30 : 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isChartView)
              StreamBuilder<List<DashBoardThongKeModel>>(
                stream: cubit.listDashBoardThongKeStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      data.length,
                      (index) => itemDashBroad(
                        name: data[index].name ?? '',
                        image: data[index].getImageUrl(),
                        countDashBroad: data[index].quantities ?? 0,
                      ),
                    ),
                  );
                },
              )
            else
              StreamBuilder<DashBoardLichHopModel>(
                stream: cubit.totalWorkStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? DashBoardLichHopModel.empty();
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      itemDashBroad(
                        name: S.current.lich_chu_tri,
                        image: ImageAssets.icLichCongTacTrongNuoc,
                        countDashBroad: data.soLichChuTri ?? 0,
                      ),
                      itemDashBroad(
                        name: S.current.lich_can_klch,
                        image: ImageAssets.lichCanKlch,
                        countDashBroad: data.soLichCanKLCH ?? 0,
                      ),
                      itemDashBroad(
                        name: S.current.lich_sap_toi,
                        image: ImageAssets.lichSapToi,
                        countDashBroad: data.soLichSapToi ?? 0,
                      ),
                      itemDashBroad(
                        name: S.current.lich_bi_trung,
                        image: ImageAssets.icLichCongTacNuocNgoai,
                        countDashBroad: data.soLichTrung ?? 0,
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget itemDashBroad({
    required String name,
    required String image,
    required int countDashBroad,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        height: 88,
        width: 274,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet ? 12.0 : 6),
          color: isTablet ? backgroundColorApp : backgroundItemCalender,
          border: isTablet ?  Border.all(
            color: borderColor.withOpacity(0.5),
          ) : null ,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceW16,
            Container(
              height: 56,
              width: 56,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color:isTablet ? backgroundItemCalender  : backgroundColorApp ,
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
                SizedBox(
                  child: Text(
                    name,
                    softWrap: true,
                    maxLines: 2,
                    style: textNormalCustom(color: titleCalenderWork),
                  ),
                ),
                SizedBox(
                  child: Text(
                    countDashBroad.toString(),
                    style: titleText(color: numberOfCalenders, fontSize: 26.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
