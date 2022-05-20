import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class HeaderMenuWidget extends StatelessWidget {
  final double paddingVertical;
  final String urlBackGround;
  final MenuCubit menuCubit;
  final Color overlayColor;
  const HeaderMenuWidget(
      {Key? key,
      this.paddingVertical = 29,
      this.urlBackGround = ImageAssets.headerMenu,
      required this.menuCubit,
      this.overlayColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: colorEDF0FD))),
      child: StreamBuilder<UserInformationModel>(
        stream: isMobile()
            ? keyHomeMobile.currentState?.homeCubit.getInforUser
            : keyHomeTablet.currentState?.homeCubit.getInforUser,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(31),
                  child: data?.anhDaiDienFilePath == null
                      ? const SizedBox()
                      : CachedNetworkImage(
                          imageUrl: data?.anhDaiDienFilePath ?? '',
                          errorWidget: (context, url, error) => Container(
                              color: Colors.black,
                              child:
                                  Image.asset(ImageAssets.anhDaiDienMacDinh)),
                        ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?.hoTen ?? '',
                    style: textNormalCustom(
                      color: color3D5586,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data?.chucVu ?? '',
                    style: textNormal(
                      color667793,
                      14,
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.navigate_next,
                color: colorA2AEBD,
              )
            ],
          );
        },
      ),
    );
  }
}
