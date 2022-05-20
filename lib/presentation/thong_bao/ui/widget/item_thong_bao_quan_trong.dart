import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ItemThongBaoQuanTrong extends StatefulWidget {
  final String id;
  final String title;
  final String message;
  final String date;
  final bool seen;
  final Function onTap;
  final ThongBaoCubit cubit;

  const ItemThongBaoQuanTrong({
    Key? key,
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.seen,
    required this.cubit,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ItemThongBaoQuanTrong> createState() => _ItemThongBaoQuanTrongState();
}

class _ItemThongBaoQuanTrongState extends State<ItemThongBaoQuanTrong> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        color: widget.seen ? Colors.white : statusNotify,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.textScale(),
          vertical: 12.0.textScale(),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    ImageAssets.icNotifyHome,
                  ),
                  SizedBox(
                    width: 12.0.textScale(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          color: textTitle,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0.textScale(),
                        ),
                      ),
                      SizedBox(
                        height: 6.0.textScale(),
                      ),
                      Text(
                        widget.message,
                        style: textNormalCustom(
                          color: infoColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.textScale(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0.textScale(),
                      ),
                      Text(
                        widget.date,
                        style: textNormalCustom(
                          color: AqiColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0.textScale(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12.0.textScale(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    isVisible = !isVisible;
                    setState(() {});
                  },
                  child: SvgPicture.asset(
                    ImageAssets.ic_three_dot_doc,
                  ),
                ),
                if (isVisible)
                  GestureDetector(
                    onTap: () {
                      showDiaLog(
                        context,
                        title: S.current.xoa_thong_bao,
                        textContent: S.current.ban_co_muon_xoa_thong_bao,
                        icon: Container(),
                        btnRightTxt: S.current.xac_nhan,
                        btnLeftTxt: S.current.dong,
                        funcBtnRight: () {
                          widget.cubit.deleteNoti(widget.id);
                          isVisible = !isVisible;
                          setState(() {});
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: widget.cubit.listMenu
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.all(7),
                                child: SvgPicture.asset(e),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                else
                  Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
