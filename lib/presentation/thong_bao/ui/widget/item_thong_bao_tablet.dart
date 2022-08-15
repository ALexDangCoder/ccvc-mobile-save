import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/thong_bao_screen.dart';

import 'package:ccvc_mobile/presentation/webview/web_view_screen.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemThongBaoTablet extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final String time;
  final bool status;
  final String typeNotify;

  const ItemThongBaoTablet({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
    required this.time,
    required this.status,
    required this.typeNotify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(image),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: textNormalCustom(
                            color: color3D5586,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          time,
                          style: textNormalCustom(
                            color: AqiColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        if (ThongBaoInherted.of(context)
                                .thongBaoCubit
                                .typeContent(title) ==
                            ThongBaoType.TinNhanMoi)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.current.vao_hop_truc_tuyen,
                                  style: textNormalCustom(
                                    color: titleColumn,
                                    fontSize: 14.0.textScale(),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3.0.textScale(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            WebViewScreen(
                                          title: '',
                                          url: content,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    content,
                                    style: textNormalCustom(
                                      color: textColorMangXaHoi,
                                      fontSize: 14.0.textScale(),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              content,
                              style: textNormalCustom(
                                color: titleColumn,
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const SizedBox(
                          width: 16,
                        ),
                        if (status)
                          Container()
                        else
                          const Icon(
                            Icons.circle,
                            size: 12,
                            color: textDefault,
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: double.maxFinite,
            color: bgDropDown,
          )
        ],
      ),
    );
  }
}
