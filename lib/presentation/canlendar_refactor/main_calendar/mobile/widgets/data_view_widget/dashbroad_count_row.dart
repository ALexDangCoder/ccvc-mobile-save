import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum TypeDashBroad {
  LICH_CONG_TAC_TRONG_NUOC,
  LICH_LAM_VIEC,
  LICH_CONG_TAC_NUOC_NGOAI,
  LICH_TIEP_DAN,
  ADMIN_TAO,
}

class DashBroadCountRow extends StatelessWidget {
  const DashBroadCountRow({
    Key? key,
    this.isTablet = false,
    required this.cubit,
  }) : super(key: key);
  final CalendarWorkCubit cubit;
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
            StreamBuilder<DashBoardLichHopModel>(
              stream: cubit.totalWorkStream,
              builder: (context, snapshot) {
                final data = snapshot.data?.countScheduleCaNhan ?? 0;
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
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      data.length,
                      (index) => itemDashBroad(
                        data[index].typeName ?? '',
                        getTypeFromString(
                                (data[index].typeName ?? '').textToCode)
                            .getImage(),
                        data[index].numberOfCalendars ?? 0,
                      ),
                    ),
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

extension TypeDashBroadUltis on TypeDashBroad {
  String getImage() {
    switch (this) {
      case TypeDashBroad.LICH_CONG_TAC_TRONG_NUOC:
        return ImageAssets.icLichCongTacTrongNuoc;
      case TypeDashBroad.LICH_CONG_TAC_NUOC_NGOAI:
        return ImageAssets.icLichCongTacNuocNgoai;
      case TypeDashBroad.LICH_LAM_VIEC:
        return ImageAssets.icLichLamViec;
      case TypeDashBroad.LICH_TIEP_DAN:
        return ImageAssets.icLichTiepDan;
      case TypeDashBroad.ADMIN_TAO:
        return ImageAssets.icAdminTao;
    }
  }
}

TypeDashBroad getTypeFromString(String value) {
  switch (value) {
    case 'LICH_CONG_TAC_TRONG_NUOC':
      return TypeDashBroad.LICH_CONG_TAC_TRONG_NUOC;
    case 'LICH_CONG_TAC_NUOC_NGOAI':
      return TypeDashBroad.LICH_CONG_TAC_NUOC_NGOAI;
    case 'LICH_LAM_VIEC':
      return TypeDashBroad.LICH_LAM_VIEC;
    case 'LICH_TIEP_DAN':
      return TypeDashBroad.LICH_TIEP_DAN;
    case 'ADMIN_TAO':
      return TypeDashBroad.ADMIN_TAO;
    default:
      return TypeDashBroad.LICH_CONG_TAC_TRONG_NUOC;
  }
}
