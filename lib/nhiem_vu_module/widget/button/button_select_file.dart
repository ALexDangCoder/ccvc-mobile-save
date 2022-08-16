import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class ButtonSelectFile extends StatefulWidget {
  final Color? background;
  final String title;
  final Color? titleColor;
  final String? icon;
  final bool isIcon;
  final bool childDiffence;
  final Function(List<File>) onChange;
  final Widget Function(BuildContext, File)? builder;
  List<File> files;
  final double? spacingFile;
  final bool isShowListFile;

  ButtonSelectFile({
    Key? key,
    this.background,
    required this.title,
    this.titleColor,
    this.icon,
    this.childDiffence = false,
    this.isIcon = true,
    required this.onChange,
    this.builder,
    this.files = const [],
    this.spacingFile,
    this.isShowListFile = true,
  }) : super(key: key);

  @override
  State<ButtonSelectFile> createState() => _ButtonSelectFileState();
}

class _ButtonSelectFileState extends State<ButtonSelectFile> {
  final CreateWorkCalCubit _cubit = CreateWorkCalCubit();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            try{
              final FilePickerResult? result =
              await FilePicker.platform.pickFiles(allowMultiple: true);

              if (result != null) {
                widget.files = result.paths.map((path) => File(path!)).toList();
              } else {
                // User canceled the picker
              }

              widget.onChange(widget.files);
              setState(() {});
            }
            catch(e){
              await MessageConfig.showDialogSetting();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color:AppTheme.getInstance().colorField().withOpacity(0.1),
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
                if (widget.isIcon)
                  Row(
                    children: [
                      SvgPicture.asset(widget.icon ?? ImageAssets.icShareFile,
                        color: AppTheme.getInstance().colorField(),

                      ),
                      SizedBox(
                        width: 11.25.textScale(),
                      ),
                    ],
                  )
                else
                  Container(),
                Text(
                  widget.title,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().colorField(),
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: widget.spacingFile == null ? 16.0.textScale() : 0,
        ),
        if (widget.isShowListFile)
          Column(
            children: widget.files.isNotEmpty
                ? widget.files.map((e) {
                    if (widget.builder == null) {
                      return itemListFile(
                          file: e,
                          onTap: () {
                            _cubit.deleteFile(e, widget.files);
                            setState(() {});
                          },
                          spacingFile: widget.spacingFile);
                    }
                    return widget.builder!(context, e);
                  }).toList()
                : [Container()],
          )
      ],
    );
  }
}

Widget itemListFile(
    {required File file, required Function onTap, double? spacingFile}) {
  return Container(
    margin: EdgeInsets.only(top: spacingFile ?? 16.0.textScale()),
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
              color: color5A8DEE,
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
