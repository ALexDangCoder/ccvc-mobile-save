import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class ButtonSelectFileLichLamViec extends StatefulWidget {
  final Color? background;
  final String title;
  final Color? titleColor;
  final String? icon;
  final bool isIcon;
  final bool childDiffence;
  final Function(List<File> files, bool validate) onChange;
  final Widget Function(BuildContext, File)? builder;
  List<File>? files;
  final double? spacingFile;
  final bool hasMultipleFile;
  final bool isShowFile;
  final double? maxSize;

  ButtonSelectFileLichLamViec({
    Key? key,
    this.background,
    required this.title,
    this.titleColor,
    this.icon,
    this.childDiffence = false,
    this.isIcon = true,
    required this.onChange,
    this.builder,
    this.files,
    this.spacingFile,
    this.hasMultipleFile = false,
    this.isShowFile = true,
    this.maxSize,
  }) : super(key: key);

  @override
  State<ButtonSelectFileLichLamViec> createState() =>
      _ButtonSelectFileLichLamViecState();
}

class _ButtonSelectFileLichLamViecState
    extends State<ButtonSelectFileLichLamViec> {
  final CreateWorkCalCubit _cubit = CreateWorkCalCubit();
  List<FileValidate> listFileValidate = [];

  @override
  void initState() {
    super.initState();
    widget.files ??= [];
    importDataValidate();
  }

  void importDataValidate() {
    (widget.files ?? []).forEach((element) {
      listFileValidate.add(FileValidate(file: element, isOversize: false));
    });
  }

  bool get isValidate => listFileValidate
      .firstWhere(
        (element) => element.isOversize == true,
        orElse: () => FileValidate(file: File(''), isOversize: false),
      )
      .isOversize;

  bool isFileError(List<String?> files) {
    for (final i in files) {
      if (i != null || (i ?? '').isNotEmpty) {
        if (!i!.isExensionOfFile) {
          return true;
        }
      }
    }
    return false;
  }

  String get convertData {
    final double value = (widget.maxSize ?? 0.0) / 1048576;
    return value.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final FilePickerResult? result =
                await FilePicker.platform.pickFiles(
              allowMultiple: true,
            );

            if (result != null) {
              if (!isFileError(result.paths)) {
                if (widget.hasMultipleFile) {
                  final listSelect =
                      result.paths.map((path) => File(path ?? '')).toList();
                  if (widget.maxSize != null) {
                    for (int i = 0; i < listSelect.length; i++) {
                      if (listSelect[i].lengthSync() > widget.maxSize!) {
                        listFileValidate.add(
                          FileValidate(
                            file: listSelect[i],
                            isOversize: true,
                          ),
                        );
                      } else {
                        listFileValidate.add(
                          FileValidate(
                            file: listSelect[i],
                            isOversize: false,
                          ),
                        );
                      }
                    }
                  } else {
                    listSelect.forEach((e) {
                      listFileValidate.add(
                        FileValidate(
                          file: e,
                          isOversize: false,
                        ),
                      );
                    });
                  }
                  listFileValidate.forEach((element) {
                    if (!element.isOversize) {
                      widget.files?.add(element.file);
                    }
                  });
                } else {
                  widget.files =
                      result.paths.map((path) => File(path!)).toList();
                  widget.files?.forEach((element) {
                    listFileValidate
                        .add(FileValidate(file: element, isOversize: false));
                  });
                }
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.current.file_khong_hop_le,
                      style: textNormalCustom(fontSize: 14),
                    ),
                  ),
                );
              }
            } else {
              // User canceled the picker
            }

            widget.onChange(widget.files ?? [], isValidate);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.background ??
                  AppTheme.getInstance().colorField().withOpacity(0.1),
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
                      SvgPicture.asset(
                        widget.icon ?? ImageAssets.icShareFile,
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
                    color: widget.titleColor ??
                        AppTheme.getInstance().colorField(),
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.isShowFile)
          const SizedBox()
        else
          Column(
            children: listFileValidate.isNotEmpty
                ? listFileValidate.map((e) {
                    if (widget.builder == null) {
                      return itemListFile(
                        isOverSize: e.isOversize,
                        file: e.file,
                        onTap: () {
                          _cubit.deleteFile(e.file, widget.files ?? []);
                          listFileValidate.remove(e);
                          if (widget.hasMultipleFile) {
                            widget.onChange(widget.files ?? [], isValidate);
                          }
                          setState(() {});
                        },
                        spacingFile: widget.spacingFile,
                      );
                    }
                    return widget.builder!(context, e.file);
                  }).toList()
                : [Container()],
          )
      ],
    );
  }

  Widget itemListFile({
    required File file,
    required Function onTap,
    bool isOverSize = false,
    double? spacingFile,
  }) {
    return Container(
      margin: EdgeInsets.only(top: spacingFile ?? 16.0.textScale()),
      padding: EdgeInsets.all(16.0.textScale()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0.textScale()),
        border: Border.all(color: bgDropDown),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  file.path.convertNameFile(),
                  style: isOverSize
                      ? textValidateStrikethrough(
                          color: color5A8DEE,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.textScale(),
                        )
                      : textNormalCustom(
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
          if (isOverSize)
            Text(
              '${S.current.file_khong_vuot_qua} $convertData MB',
              style: textNormalCustom(
                color: Colors.red,
                fontSize: 12.0.textScale(),
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}

class FileValidate {
  File file;
  bool isOversize;

  FileValidate({required this.file, required this.isOversize});
}
