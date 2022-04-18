import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ItemThongBaoQuanTrong extends StatelessWidget {
  final String id;
  final String title;
  final String message;
  final String date;
  final bool seen;
  final ThongBaoCubit cubit;

  const ItemThongBaoQuanTrong({
    Key? key,
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.seen,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: seen ? Colors.white : statusNotify,
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
                      title,
                      style: textNormalCustom(
                        color: textTitle,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      message,
                      style: textNormalCustom(
                        color: infoColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      date,
                      style: textNormalCustom(
                        color: AqiColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  ImageAssets.ic_three_dot_doc,
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: borderColor.withOpacity(0.5),
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: shadowContainerColor.withOpacity(0.05),
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Column(
              //     children: cubit.listMenu
              //         .map(
              //           (e) => Container(
              //             padding: const EdgeInsets.all(7),
              //             child: SvgPicture.asset(e),
              //           ),
              //         )
              //         .toList(),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
