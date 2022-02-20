import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarAndSignatureTablet extends StatelessWidget {
  final ManagerPersonalInformationCubit cubit;

  const AvatarAndSignatureTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        treeWidget(
          context,
          S.current.anh_dai_dien,
          () async {
            await upLoadImg(context, 1);
          },
          cubit.managerPersonalInformationModel.anhDaiDienFilePath ?? '',
          true,
        ),
        spaceW78,
        treeWidget(
          context,
          S.current.anh_chu_ky,
          () async {
            await upLoadImg(context, 2);
          },
          cubit.managerPersonalInformationModel.anhChuKyFilePath ?? '',
          true,
        ),
        spaceW78,
        treeWidget(
          context,
          S.current.anh_ky_nhay,
          () async {
            await upLoadImg(context, 3);
          },
          cubit.managerPersonalInformationModel.anhChuKyNhayFilePath ?? '',
          true,
        )
      ],
    );
  }

  Future<void> upLoadImg(BuildContext context, int loai) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      final File file = File(result.files.single.path ?? '');
      await cubit.uploadImage(xFile: file);
    } else {}

    //print(result);
  }

  Widget treeWidget(BuildContext context, String text, Function() onTap,
      String url, bool isAvatarUser) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: colorLineSearch.withOpacity(0.3)),
              shape: BoxShape.circle,
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: bgImage.withOpacity(0.2),
                  blurRadius: 7,
                  // offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: isAvatarUser
                  ? Padding(
                      padding: const EdgeInsets.all(34.0),
                      child: SvgPicture.asset(ImageAssets.icImage),
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
            ),
          ),
        ),
        spaceH16,
        Text(
          text,
          style: tokenDetailAmount(
            fontSize: 12.0.textScale(),
            color: infoColor,
          ),
        )
      ],
    );
  }
}
