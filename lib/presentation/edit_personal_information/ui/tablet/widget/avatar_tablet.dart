import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/pick_image_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AvatarAndSignatureTablet extends StatelessWidget {
  final ManagerPersonalInformationCubit cubit;
  final FToast toast;

  const AvatarAndSignatureTablet({
    Key? key,
    required this.cubit,
    required this.toast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        pickAnhDaiDien(
          context,
          S.current.anh_dai_dien,
          () async {
            await upLoadImg(context, 1, toast);
          },
          cubit.managerPersonalInformationModel.anhDaiDienFilePath ?? '',
        ),
        pickChuKy(
          context,
          S.current.anh_chu_ky,
          () async {
            await upLoadChuKy(context, 2, toast);
          },
          cubit.managerPersonalInformationModel.anhChuKyFilePath ?? '',
        ),
        pickAnhKyNhay(
          context,
          S.current.anh_ky_nhay,
          () async {
            await upLoadKyNhay(context, 3, toast);
          },
          cubit.managerPersonalInformationModel.anhChuKyNhayFilePath ?? '',
        )
      ],
    );
  }

  Future<void> upLoadImg(
    BuildContext context,
    int loai,
    FToast toast,
  ) async {
    final _path = await cubit.pickAvatar();
    if (_path.path.isEmpty) {
      toast.showToast(
        child: ShowToast(
          text: S.current.file_khong_hop_le,
        ),
        gravity: ToastGravity.TOP_RIGHT,
      );
    } else {
      if (_path.size > MaxSizeFile.MAX_SIZE_20MB) {
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da_20,
          ),
          gravity: ToastGravity.TOP_RIGHT,
        );
      } else {
        cubit.avatarPathSubject.sink.add(_path);
        await cubit.uploadFile(_path.path);
      }
    }
  }

  Future<void> upLoadChuKy(
    BuildContext context,
    int loai,
    FToast toast,
  ) async {
    final _path = await cubit.pickAvatar();
    if (_path.path.isEmpty) {
      toast.showToast(
        child: ShowToast(
          text: S.current.file_khong_hop_le,
        ),
        gravity: ToastGravity.TOP_RIGHT,
      );
    } else {
      if (_path.size > MaxSizeFile.MAX_SIZE_20MB) {
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da_20,
          ),
          gravity: ToastGravity.TOP_RIGHT,
        );
      } else {
        cubit.chuKyPathSubject.sink.add(_path);
        await cubit.uploadFileChuKi(_path.path);
      }
    }
  }

  Future<void> upLoadKyNhay(
    BuildContext context,
    int loai,
    FToast toast,
  ) async {
    final _path = await cubit.pickAvatar();
    if (_path.path.isEmpty) {
      toast.showToast(
        child: ShowToast(
          text: S.current.file_khong_hop_le,
        ),
        gravity: ToastGravity.TOP_RIGHT,
      );
    } else {
      if (_path.size > MaxSizeFile.MAX_SIZE_20MB) {
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da_20,
          ),
          gravity: ToastGravity.TOP_RIGHT,
        );
      } else {
        cubit.kyNhayPathSubject.sink.add(_path);
        await cubit.uploadFileKiNhay(_path.path);
      }
    }
  }

  Widget errImage() {
    return Container(
      padding: const EdgeInsets.all(54.0),
      child: SvgPicture.asset(
        ImageAssets.icImage,
        color: AppTheme.getInstance().colorField(),
      ),
    );
  }

  Widget pickAnhDaiDien(
    BuildContext context,
    String text,
    Function() onTap,
    String url,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.hardEdge,
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
                if (!snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: cubit.managerPersonalInformationModel
                              .anhDaiDienFilePath ??
                          '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return errImage();
                      },
                    ),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
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

  Widget pickChuKy(
    BuildContext context,
    String text,
    Function() onTap,
    String url,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.hardEdge,
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
                if (!snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: cubit.managerPersonalInformationModel
                              .anhChuKyFilePath ??
                          '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return errImage();
                      },
                    ),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
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

  Widget pickAnhKyNhay(
    BuildContext context,
    String text,
    Function() onTap,
    String url,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.hardEdge,
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
                if (!snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: cubit.managerPersonalInformationModel
                              .anhChuKyNhayFilePath ??
                          '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return errImage();
                      },
                    ),
                  );
                } else {
                  cubit.pathAnhKyNhay = snapshot.data?.path ?? '';
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(50),
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
