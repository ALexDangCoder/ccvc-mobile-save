import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/pick_image_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/pick_image_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuaAvatarDanhBa extends StatefulWidget {
  final FToast toast;
  final DanhBaDienTuCubit cubit;
  final Items item;

  const SuaAvatarDanhBa({
    Key? key,
    required this.toast,
    required this.cubit,
    required this.item,
  }) : super(key: key);

  @override
  State<SuaAvatarDanhBa> createState() => _SuaAvatarDanhBaState();
}

class _SuaAvatarDanhBaState extends State<SuaAvatarDanhBa> {
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
              await upLoadImg(context, 1, widget.toast);
            },
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
              await upLoadImg(context, 1, widget.toast);
            },
            '',
            true,
          ),
        ],
      ),
    );
  }

  Future<void> upLoadImg(
    BuildContext context,
    int loai,
    FToast toast,
  ) async {
    final _path = await widget.cubit.pickAvatar();
    if (_path.path.isNotEmpty) {
      if (_path.size > 15000000) {
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da,
          ),
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        widget.cubit.anhDanhBaCaNhan.sink.add(_path);
        await widget.cubit.uploadFiles(_path.path);
      }
    } else {}
  }

  Widget pickAnhDaiDien(
    BuildContext context,
    String text,
    Function() onTap,
  ) {
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
                  color: bgImage.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: bgImage.withOpacity(0.1),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: StreamBuilder<ModelAnh>(
                  stream: widget.cubit.anhDanhBaCaNhan,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: widget.item.anhDaiDienFilePath ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                children: [
                                  SvgPicture.asset(ImageAssets.icImage),
                                  spaceH6,
                                  Text(
                                    S.current.them,
                                    style: tokenDetailAmount(
                                      fontSize: 14,
                                      color:
                                          AppTheme.getInstance().colorField(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(snapshot.data?.path ?? ''),
                          fit: BoxFit.cover,
                        ),
                      );
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
            color: bgImage,
            dashPattern: const [5, 5],
            strokeWidth: 2,
            radius: const Radius.circular(12),
            borderType: BorderType.RRect,
            child: Container(
              height: 152,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: textColorBaoChi.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: bgImage.withOpacity(0.1),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: StreamBuilder<ModelAnh>(
                stream: widget.cubit.anhDanhBaCaNhan,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
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
                        ));
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(snapshot.data?.path ?? ''),
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
