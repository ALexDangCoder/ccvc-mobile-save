import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/widgets/thiep_back_ground_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThiepChucMungSinhNhatWidget extends StatelessWidget {
  const ThiepChucMungSinhNhatWidget({
    Key? key,
    required this.data,
    this.isTablet = false,
  }) : super(key: key);
  final BirthdayModel data;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ThiepBackgroundWidget(
                  isTablet: isTablet,
                  pathImage: data.anhThiepChuc,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      height: 72.0.textScale(space: 48),
                      width: 72.0.textScale(space: 48),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl:
                            Get.find<AppConstants>().baseImageUrl + data.avatar,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          color: Colors.black,
                          child: Image.asset(
                            ImageAssets.anhDaiDienMacDinh,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      data.tenNguoiGui,
                      style: textNormalCustom(
                        fontSize: 16.0.textScale(space: 4),
                        color: textTitle,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      S.current.gui_thiep_mung,
                      style: textNormal(color667793, 14.0.textScale()),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor.withOpacity(0.5)),
              ),
            ),
            child: Text(
              data.loiChuc,
              style: textNormal(color3D5586, 14.0.textScale(space: 4)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
