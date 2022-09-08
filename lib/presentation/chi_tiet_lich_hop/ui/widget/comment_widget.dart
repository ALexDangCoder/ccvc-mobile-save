import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/phan_hoi_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;
  final YkienCuocHopModel yKienCuocHop;

  const CommentWidget({
    Key? key,
    required this.yKienCuocHop,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.yKienCuocHop.traLoiYKien ?? [];
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: toDayColor.withOpacity(0.1),
        border: Border.all(
          color: toDayColor.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8.0.textScale(space: 4.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.textScale(space: 4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            yKienWidget(
              showIcReply: widget.cubit.isChuTriOrThamGia(),
              nguoiTao: widget.yKienCuocHop.nguoiTao ?? '',
              ngayTao: widget.yKienCuocHop.ngayTao ?? '',
              content: widget.yKienCuocHop.content ?? '',
              avatar: widget.yKienCuocHop.avatar ?? '',
              onTap: () {
                if (isMobile()) {
                  showBottomSheetCustom(
                    context,
                    title: S.current.y_kien,
                    child: PhanHoiWidget(
                      cubit: widget.cubit,
                      id: widget.cubit.idCuocHop,
                      scheduleOpinionId: widget.yKienCuocHop.id ?? '',
                    ),
                  );
                } else {
                  showDiaLogTablet(
                    context,
                    title: S.current.y_kien,
                    child: PhanHoiWidget(
                      cubit: widget.cubit,
                      id: widget.cubit.idCuocHop,
                      scheduleOpinionId: widget.yKienCuocHop.id ?? '',
                    ),
                    funcBtnOk: () {},
                    isBottomShow: false,
                  );
                }
              },
            ),
            SizedBox(
              height: 16.0.textScale(space: 4.0),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 48, bottom: 16),
                  child: yKienWidget(
                    nguoiTao: data[index].nguoiTao ?? '',
                    ngayTao: data[index].ngayTao ?? '',
                    content: data[index].content ?? '',
                    avatar: data[index].avatar ?? '',
                    showIcReply: false,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget yKienWidget({
    required String nguoiTao,
    required String ngayTao,
    required String content,
    required String avatar,
    Function()? onTap,
    bool showIcReply = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    Get.find<AppConstants>().baseImageUrl + avatar,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(ImageAssets.anhDaiDienMacDinh),
                    fit: BoxFit.cover,
                  ),
                ),
                spaceW8,
                Text(
                  nguoiTao,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // const Spacer(),
            const SizedBox(
              width: 6,
            ),
            Text(
              ngayTao,
              style: textNormalCustom(
                color: infoColor,
                fontSize: 12.0.textScale(space: 4.0),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                content,
                style: textNormalCustom(
                  color: color3D5586,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if (showIcReply)
              GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: borderColor.withOpacity(0.5),
                    ),
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    ImageAssets.ic_phan_hoi,
                    color: AppTheme.getInstance().colorField(),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
