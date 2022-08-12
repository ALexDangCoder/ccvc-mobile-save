import 'dart:io';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageWidget extends StatefulWidget {
  final File? imageLocal;
  String? image;
  final Function(File? image) onTapImage;
  final Function() removeImage;
  final bool isShowLoading;
  final ImagePermission imagePermission;

  SelectImageWidget({
    Key? key,
    required this.onTapImage,
    required this.removeImage,
    this.image,
    this.isShowLoading = false,
    this.imageLocal,
    required this.imagePermission,
  }) : super(key: key);

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    final XFile? pickImg = await picker.pickImage(source: ImageSource.gallery);
    if (pickImg != null) {
      final File fileIamge = File(pickImg.path);
      final int fileSize = await fileIamge.length();

      if (fileSize < FileSize.MB5) {
        widget.onTapImage(File(pickImg.path));
      } else {
        widget.onTapImage(null);
        final toast = FToast();
        toast.init(context);
        toast.showToast(
          child: ShowToast(
            text: S.current.dung_luong_toi_da_5mb,
            withOpacity: 0.6,
          ),
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  void removeImg() {
    widget.onTapImage(null); //khi xoa thi call back tra ve null.
    widget.image = null;
    setState(() {});
    widget.removeImage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowLoading
        ? Container(
            height: 164.0.textScale(space: 56.0),
            decoration: BoxDecoration(
              border: Border.all(color: colorE2E8F0),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : widget.image != null
            ? Stack(
                children: [
                  Container(
                    height: 164.0.textScale(space: 56.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: colorE2E8F0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                      image: widget.imageLocal != null
                          ? DecorationImage(
                              image: FileImage(
                                widget.imageLocal!,
                              ),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
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
            : emptyImage(
                onTap: () {
                  widget.imagePermission.checkFilePermission();
                  switch(widget.imagePermission.perrmission) {
                    case ImageSelection.PICK_IMAGE : {
                      pickImage();
                      break;
                    }
                    case ImageSelection.NO_STORAGE_PERMISSION: {
                      widget.imagePermission.requestFilePermission();
                      break;
                    }
                    case ImageSelection.NO_STORAGE_PERMISSION_PERMANENT: {
                      widget.imagePermission.openSettingApp();
                      break;
                    }
                  }
                },
              );
  }

  Widget emptyImage({required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 164.0.textScale(space: 56.0),
        decoration: BoxDecoration(
          border: Border.all(color: colorE2E8F0),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAssets.icUpAnh,
            ),
            spaceH14,
            Text(
              S.current.tai_anh_len,
              style: textNormal(
                color667793,
                14.0.textScale(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
