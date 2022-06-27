import 'dart:io';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageWidget extends StatefulWidget {
  final Function(File? image) selectImage;
  final File? image;

  const SelectImageWidget({Key? key, required this.selectImage, this.image})
      : super(key: key);

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  Future<void> pickImage() async {
    final XFile? pickImg = await picker.pickImage(source: ImageSource.gallery);
    if (pickImg != null) {
      image = File(pickImg.path);
      widget.selectImage(image);
    }
    setState(() {});
  }

  void removeImg() {
    image = null;
    widget.selectImage(image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return image != null
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
                  image: DecorationImage(
                    image: FileImage(image!),
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
              pickImage();
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
