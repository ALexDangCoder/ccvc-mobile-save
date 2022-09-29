import 'dart:io';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/view_pick_camera.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageDangKyXe extends StatefulWidget {
  final String? image;
  final Function(File? image) onTapImage;
  final Function() removeImage;
  final bool isTao;
  final bool isPhone;
  final ImagePermission imagePermission;

  const SelectImageDangKyXe({
    Key? key,
    required this.onTapImage,
    required this.removeImage,
    this.image,
    required this.isTao,
    required this.isPhone,
    required this.imagePermission,
  }) : super(key: key);

  @override
  State<SelectImageDangKyXe> createState() => _SelectImageDangKyXeWidgetState();
}

class _SelectImageDangKyXeWidgetState extends State<SelectImageDangKyXe> {
  ImagePicker picker = ImagePicker();
  File? imageChoosse;
  double sizeFile = 0;
  String? imageInit;

  @override
  void initState() {
    super.initState();
    imageInit = widget.image;
  }

  Future<void> pickImage(bool isImage) async {
    final XFile? pickImg = await picker.pickImage(
      source: isImage ? ImageSource.gallery : ImageSource.camera,
    );
    if (pickImg != null) {
      sizeFile = File(pickImg.path).lengthSync() / BYTE_TO_MB;
      if (sizeFile >= 5) {
        final toast = FToast();
        toast.init(context);
        toast.showToast(
          child: ShowToast(
            text: S.current.chi_nhan_anh_5MB,
          ),
          gravity: ToastGravity.TOP_RIGHT,
        );
      } else {
        if (isImage) {
          widget.onTapImage(File(pickImg.path));
          imageChoosse = File(pickImg.path);
        } else {
           await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewPickCamera(
                imagePath:
                  File(pickImg.path),
                title: S.current.tai_anh_giay_dang_ky_xe,
              ),
            ),
          ).then((value) {
            widget.onTapImage(value);
            imageChoosse = value;
          });
        }
      }
    }
    setState(() {});
  }

  void removeImg() {
    widget.onTapImage(null);
    imageChoosse = null;
    widget.removeImage();
    imageInit = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTao == true) {
      return widget.image != null
          ? Stack(
              children: [
                Container(
                  height: widget.isPhone
                      ? 200
                      : MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorE2E8F0),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      removeImg();
                    },
                    child: SvgPicture.asset(
                      ImageAssets.icRemoveImg,
                    ),
                  ),
                ),
              ],
            )
          : imageChoosse?.path != null
              ? Stack(
                  children: [
                    Container(
                      height: widget.isPhone
                          ? 200
                          : MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorE2E8F0),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                          image: FileImage(imageChoosse!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          removeImg();
                        },
                        child: SvgPicture.asset(
                          ImageAssets.icRemoveImg,
                        ),
                      ),
                    ),
                  ],
                )
              : emptyImage(onTapPickImage: () {
                  widget.imagePermission.checkFilePermission();
                  switch (widget.imagePermission.perrmission) {
                    case ImageSelection.PICK_IMAGE:
                      {
                        pickImage(true);
                        break;
                      }
                    case ImageSelection.NO_STORAGE_PERMISSION:
                      {
                        widget.imagePermission.requestFilePermission();
                        break;
                      }
                    case ImageSelection.NO_STORAGE_PERMISSION_PERMANENT:
                      {
                        widget.imagePermission.openSettingApp();
                        break;
                      }
                  }
                }, onTapPickCamera: () {
                  widget.imagePermission.checkFilePermission();
                  switch (widget.imagePermission.perrmission) {
                    case ImageSelection.PICK_IMAGE:
                      {
                        pickImage(false);
                        break;
                      }
                    case ImageSelection.NO_STORAGE_PERMISSION:
                      {
                        widget.imagePermission.requestFilePermission();
                        break;
                      }
                    case ImageSelection.NO_STORAGE_PERMISSION_PERMANENT:
                      {
                        widget.imagePermission.openSettingApp();
                        break;
                      }
                  }
                });
    } else {
      return imageChoosse != null
          ? Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: widget.isPhone
                      ? 200
                      : MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorE2E8F0),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                    image: DecorationImage(
                      image: FileImage(imageChoosse!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      removeImg();
                    },
                    child: SvgPicture.asset(
                      ImageAssets.icRemoveImg,
                    ),
                  ),
                ),
              ],
            )
          : imageInit != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: widget.isPhone
                          ? 200
                          : MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorE2E8F0),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            imageInit!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: widget.isPhone
                          ? 200
                          : MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: color000000.withOpacity(0.5)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.imagePermission.checkFilePermission();
                            switch (widget.imagePermission.perrmission) {
                              case ImageSelection.PICK_IMAGE:
                                {
                                  pickImage(true);
                                  break;
                                }
                              case ImageSelection.NO_STORAGE_PERMISSION:
                                {
                                  widget.imagePermission
                                      .requestFilePermission();
                                  break;
                                }
                              case ImageSelection
                                  .NO_STORAGE_PERMISSION_PERMANENT:
                                {
                                  widget.imagePermission.openSettingApp();
                                  break;
                                }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ImageAssets.icUpAnh,
                                color: colorFFFFFF,
                              ),
                              spaceH14,
                              Text(
                                S.current.tai_anh,
                                style: textNormal(
                                  colorFFFFFF,
                                  14.0.textScale(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        spaceW40,
                        GestureDetector(
                          onTap: () {
                            widget.imagePermission.checkFilePermission();
                            switch (widget.imagePermission.perrmission) {
                              case ImageSelection.PICK_IMAGE:
                                {
                                  pickImage(false);
                                  break;
                                }
                              case ImageSelection.NO_STORAGE_PERMISSION:
                                {
                                  widget.imagePermission
                                      .requestFilePermission();
                                  break;
                                }
                              case ImageSelection
                                  .NO_STORAGE_PERMISSION_PERMANENT:
                                {
                                  widget.imagePermission.openSettingApp();
                                  break;
                                }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                ImageAssets.icUpCamera,
                                color: colorFFFFFF,
                              ),
                              spaceH14,
                              Text(
                                S.current.chup_anh,
                                style: textNormal(
                                  colorFFFFFF,
                                  14.0.textScale(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : emptyImage(
                  onTapPickImage: () {
                    widget.imagePermission.checkFilePermission();
                    switch (widget.imagePermission.perrmission) {
                      case ImageSelection.PICK_IMAGE:
                        {
                          pickImage(true);
                          break;
                        }
                      case ImageSelection.NO_STORAGE_PERMISSION:
                        {
                          widget.imagePermission.requestFilePermission();
                          break;
                        }
                      case ImageSelection.NO_STORAGE_PERMISSION_PERMANENT:
                        {
                          widget.imagePermission.openSettingApp();
                          break;
                        }
                    }
                  },
                  onTapPickCamera: () {
                    widget.imagePermission.checkFilePermission();
                    switch (widget.imagePermission.perrmission) {
                      case ImageSelection.PICK_IMAGE:
                        {
                          pickImage(false);
                          break;
                        }
                      case ImageSelection.NO_STORAGE_PERMISSION:
                        {
                          widget.imagePermission.requestFilePermission();
                          break;
                        }
                      case ImageSelection.NO_STORAGE_PERMISSION_PERMANENT:
                        {
                          widget.imagePermission.openSettingApp();
                          break;
                        }
                    }
                  },
                );
    }
  }

  Widget emptyImage({
    required Function() onTapPickImage,
    required Function() onTapPickCamera,
  }) {
    return Container(
      height: widget.isPhone ? 200 : MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: colorE2E8F0),
        borderRadius: BorderRadius.circular(8.0),
        color: colorFFFFFF,
        boxShadow: const [
          BoxShadow(
            color: shadow,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTapPickImage,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.icUpAnh,
                  color: AppTheme.getInstance().colorField(),
                ),
                spaceH14,
                Text(
                  S.current.tai_anh,
                  style: textNormal(
                    color667793,
                    14.0.textScale(),
                  ),
                ),
              ],
            ),
          ),
          spaceW40,
          GestureDetector(
            onTap: onTapPickCamera,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.icUpCamera,
                  color: AppTheme.getInstance().colorField(),
                ),
                spaceH14,
                Text(
                  S.current.chup_anh,
                  style: textNormal(
                    color667793,
                    14.0.textScale(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
