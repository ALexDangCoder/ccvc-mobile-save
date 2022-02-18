import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class ButtonSelectFile extends StatefulWidget {
  final Color? background;
  final String title;
  final String? icon;
  final bool childDiffence;
  final Function(List<File>) onChange;
  final Widget? builder;
  final bool isBuilder;
  List<File> files;

  ButtonSelectFile({
    Key? key,
    this.background,
    required this.title,
    this.icon,
    this.childDiffence = false,
    this.builder,
    required this.onChange,
    this.isBuilder = false,
    this.files = const [],
  }) : super(key: key);

  @override
  State<ButtonSelectFile> createState() => _ButtonSelectFileState();
}

class _ButtonSelectFileState extends State<ButtonSelectFile> {
  final TaoLichLamViecCubit _cubit = TaoLichLamViecCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);

            if (result != null) {
              widget.files = result.paths.map((path) => File(path!)).toList();
            } else {
              // User canceled the picker
            }

            widget.onChange(widget.files);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.background ?? labelColor.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 6.0.textScale(),
              horizontal: 16.0.textScale(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(widget.icon ?? ImageAssets.icShareFile),
                SizedBox(
                  width: 11.25.textScale(),
                ),
                Text(
                  widget.title,
                  style: textNormalCustom(
                    color: labelColor,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.0.textScale(),
        ),
        if (widget.isBuilder)
          Column(
            children: widget.files.isNotEmpty
                ? widget.files
                    .map((e) => widget.builder ?? Container())
                    .toList()
                : [Container()],
          )
        else
          Column(
            children: widget.files.isNotEmpty
                ? widget.files
                    .map(
                      (e) => itemListFile(
                        file: e,
                        onTap: () {
                          _cubit.deleteFile(e, widget.files);
                          setState(() {});
                        },
                      ),
                    )
                    .toList()
                : [Container()],
          )
      ],
    );
  }
}

Widget itemListFile({
  required File file,
  required Function onTap,
}) {
  return Container(
    margin: EdgeInsets.only(top: 16.0.textScale()),
    padding: EdgeInsets.all(16.0.textScale()),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.0.textScale()),
      border: Border.all(color: bgDropDown),
    ),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            file.path.convertNameFile(),
            style: textNormalCustom(
              color: choXuLyColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: SvgPicture.asset(ImageAssets.icDelete),
        ),
      ],
    ),
  );
}
