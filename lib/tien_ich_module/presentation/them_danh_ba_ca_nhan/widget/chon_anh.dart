import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/pick_image_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarDanhBa extends StatefulWidget {
  const AvatarDanhBa({
    Key? key,
  }) : super(key: key);

  @override
  State<AvatarDanhBa> createState() => _AvatarDanhBaState();
}

class _AvatarDanhBaState extends State<AvatarDanhBa> {
  final DanhBaDienTuCubit cubit = DanhBaDienTuCubit();

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pickAnhDaiDien(
            context,
            S.current.anh_dai_dien,
            () async {
              await upLoadImg(context, 1);
            },
            '',
            true,
          ),
        ],
      ),
      tabletScreen: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pickAnhDaiDienTablet(
            context,
            S.current.anh_dai_dien,
            () async {
              await upLoadImg(context, 1);
            },
            '',
            true,
          ),
        ],
      ),
    );
  }

  Future<void> upLoadImg(BuildContext context, int loai) async {
    final _path = await cubit.pickAvatar();
    if (_path.isNotEmpty) {
      cubit.anhDanhBaCaNhan.sink.add(_path);
    } else {}
  }

  Widget pickAnhDaiDien(BuildContext context, String text, Function() onTap,
      String url, bool isAvatarUser) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
              color: bgImage,
              dashPattern: const [5, 5],
              strokeWidth: 2,
              radius: const Radius.circular(10),
              borderType: BorderType.RRect,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: bgImage.withOpacity(0.1),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: StreamBuilder<String>(
                  stream: cubit.anhDanhBaCaNhan,
                  builder: (context, snapshot) {
                    final _data = snapshot.data ?? '';
                    if (_data.isEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: isAvatarUser
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(ImageAssets.icImage),
                                    spaceH6,
                                    Text(
                                      S.current.them,
                                      style: tokenDetailAmount(
                                        fontSize: 14,
                                        color: AqiColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    'https://vcdn-vnexpress.vnecdn.net/2021/11/20/Co-Moon-Nguyen-6518-1637375803.jpg',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_data),
                          fit: BoxFit.cover,
                        ),
                      );

                      //Image.file(File(_data));
                    }
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget pickAnhDaiDienTablet(BuildContext context, String text,
      Function() onTap, String url, bool isAvatarUser) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            color: bgTag,
            dashPattern: const [5, 5],
            strokeWidth: 2,
            radius: const Radius.circular(12),
            borderType: BorderType.RRect,
            child: Container(
              height: 152,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: labelColor.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: bgImage.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: StreamBuilder<String>(
                stream: cubit.anhDanhBaCaNhan,
                builder: (context, snapshot) {
                  final _data = snapshot.data ?? '';
                  if (_data.isEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: isAvatarUser
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.icImage),
                                spaceH12,
                                Text(
                                  S.current.them_anh,
                                  style: tokenDetailAmount(
                                    fontSize: 16,
                                    color: AqiColor,
                                  ),
                                ),
                              ],
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  'https://vcdn-vnexpress.vnecdn.net/2021/11/20/Co-Moon-Nguyen-6518-1637375803.jpg',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                  ),
                                );
                              },
                            ),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(_data),
                        fit: BoxFit.cover,
                      ),
                    );

                    //Image.file(File(_data));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
