import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class HeaderMenuMobileWidget extends StatelessWidget {
  final MenuCubit menuCubit;
  const HeaderMenuMobileWidget({Key? key, required this.menuCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorECEEF7),
        ),
      ),
      child: StreamBuilder<UserInformationModel>(
          stream: keyHomeMobile.currentState?.homeCubit.getInforUser,
          builder: (context, snapshot) {
            final data = snapshot.data;
            return Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.tealAccent),
                  child: data == null
                      ? const SizedBox()
                      : CachedNetworkImage(
                          imageUrl: data.anhDaiDienFilePath ?? '',
                          errorWidget: (context, url, error) => Container(
                            color: Colors.black,
                            child: Image.asset(ImageAssets.anhDaiDienMacDinh),
                          ),
                        ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data?.hoTen ?? '',
                        style: textNormalCustom(color: textTitle, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data?.chucVu ?? '',
                        style: textNormal(infoColor, 14),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Visibility(
                  visible: data?.isSinhNhat() ?? false,
                  child: Expanded(
                    child: Container(
                        color: Colors.transparent,
                        child: Image.asset(
                          ImageAssets.icHappyBirthday,
                          height: 40,
                        )),
                  ),
                ),
                const Icon(
                  Icons.navigate_next,
                  color: colorA2AEBD,
                )
              ],
            );
          }),
    );
  }
}
