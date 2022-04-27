import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/pick_image_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarAndSignature extends StatelessWidget {
  final ManagerPersonalInformationCubit cubit;

  const AvatarAndSignature({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        pickAnhDaiDien(
          context,
          S.current.anh_dai_dien,
              () async {
            await upLoadImg(context, 1);
          },
          cubit.managerPersonalInformationModel.anhDaiDienFilePath ?? '',
          true,
        ),
        pickChuKy(
          context,
          S.current.anh_chu_ky,
              () async {
            await upLoadChuKy(context, 2);
          },
          cubit.managerPersonalInformationModel.anhChuKyFilePath ?? '',
          true,
        ),
        pickAnhKyNhay(
          context,
          S.current.anh_ky_nhay,
              () async {
            await upLoadKyNhay(context, 3);
          },
          cubit.managerPersonalInformationModel.anhChuKyNhayFilePath ?? '',
          true,
        )
      ],
    );
  }

  Future<void> upLoadImg(BuildContext context, int loai) async {
    final _anh = await cubit.pickAvatar();
    // if (_anh) {
    //   cubit.avatarPathSubject.sink.add(_path);
    // } else {}
    cubit.avatarPathSubject.sink.add(_anh);
  }

  Future<void> upLoadChuKy(BuildContext context, int loai) async {
    final _path = await cubit.pickAvatar();
    // if (_path.isNotEmpty) {
    //   cubit.chuKyPathSubject.sink.add(_path);
    // } else {}
    cubit.avatarPathSubject.sink.add(_path);
  }

  Future<void> upLoadKyNhay(BuildContext context, int loai) async {
    final _path = await cubit.pickAvatar();
    // if (_path.isNotEmpty) {
    //   cubit.kyNhayPathSubject.sink.add(_path);
    // } else {}
    cubit.avatarPathSubject.sink.add(_path);
  }

  Widget pickAnhDaiDien(BuildContext context, String text, Function() onTap,
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
                  color: bgImage.withOpacity(0.1),
                  blurRadius: 7,
                ),
              ],
            ),
            child: StreamBuilder<ModelAnh>(
              stream: cubit.avatarPathSubject,
              builder: (context, snapshot) {
                final _data = snapshot.data ?? ModelAnh();
                if (_data == null) {
                  return ClipRRect(
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
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(_data.path ?? ''),
                      fit: BoxFit.cover,
                    ),
                  );

                  //Image.file(File(_data));
                }
              },
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

  Widget pickChuKy(BuildContext context, String text, Function() onTap,
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
                  color: bgImage.withOpacity(0.1),
                  blurRadius: 7,
                  // offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: StreamBuilder<ModelAnh>(
              stream: cubit.chuKyPathSubject,
              builder: (context, snapshot) {
                final _data = snapshot.data ?? ModelAnh();
                if (_data == null) {
                  return ClipRRect(
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
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(_data.path ?? ''),
                      fit: BoxFit.cover,
                    ),
                  );

                  //Image.file(File(_data));
                }
              },
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

  Widget pickAnhKyNhay(BuildContext context, String text, Function() onTap,
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
                  color: bgImage.withOpacity(0.1),
                  blurRadius: 7,
                  // offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: StreamBuilder<ModelAnh>(
              stream: cubit.kyNhayPathSubject,
              builder: (context, snapshot) {
                final _data = snapshot.data ?? ModelAnh();
                if (_data == null) {
                  return ClipRRect(
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
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(_data.path ?? ''),
                      fit: BoxFit.cover,
                    ),
                  );

                  //Image.file(File(_data));
                }
              },
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
