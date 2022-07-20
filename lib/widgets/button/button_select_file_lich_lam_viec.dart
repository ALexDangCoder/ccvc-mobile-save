import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/file_extension.dart';
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
  final Function(List<File> files, bool validate,) onChange;
  final Function(int index)? getIndexFunc;
  final Widget Function(BuildContext, File)? builder;
  List<Files>? files;
  final double? spacingFile;
  final bool hasMultipleFile;
  final bool isShowFile;
  final double? maxSize;
  final List<String>? allowedExtensions;
  List<File>? initFileSystem;

  ButtonSelectFileLichLamViec({
    Key? key,
    this.background,
    this.getIndexFunc,
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
    this.allowedExtensions,
    this.initFileSystem,
  }) : super(key: key);

  @override
  State<ButtonSelectFileLichLamViec> createState() =>
      _ButtonSelectFileLichLamViecState();
}

class _ButtonSelectFileLichLamViecState
    extends State<ButtonSelectFileLichLamViec> {
  List<FileModel> selectFiles = [];
  bool isOverSize = false;
  double total = 0;

  @override
  void initState() {
    super.initState();
    widget.files ??= [];
    selectFiles = widget.files!
        .map(
          (file) => FileModel(
            file: File(file.path ?? ''),
            size: double.tryParse(file.size ?? '')?.toInt() ?? 0,
          ),
        )
        .toList();
    selectFiles.addAll(
      widget.initFileSystem?.map((e) => e.convertToFiles()).toList() ?? [],
    );
  }

  bool isFileError(List<String?> files) {
    for (final file in files) {
      if (file != null || (file ?? '').isNotEmpty) {
        if (!file!.isExensionOfFile) {
          return true;
        }
      }
    }
    return false;
  }

  String get convertData {
    final double value = (widget.maxSize ?? 0.0) / BYTE_TO_MB;
    return value.toInt().toString();
  }

  void sumListFileSize(List<FileModel> files) {
    for (final element in files) {
      total += element.size;
    }
    setState(() {
      isOverSize = total > widget.maxSize!;
      total = 0;
    });
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
              allowedExtensions: widget.allowedExtensions,
              type: (widget.allowedExtensions ?? []).isNotEmpty
                  ? FileType.custom
                  : FileType.any,
            );
            if (result != null) {
              if (!isFileError(result.paths)) {
                if (widget.hasMultipleFile) {
                  setState(() {
                    selectFiles.addAll(
                      result.files
                          .map(
                            (file) => FileModel(
                              file: File(file.path ?? ''),
                              size: file.size,
                            ),
                          )
                          .toSet()
                          .toList(),
                    );
                  });
                  if (widget.maxSize != null) {
                    sumListFileSize(selectFiles);
                  }
                }
              } else {
                MessageConfig.show(
                  messState: MessState.error,
                  title: S.current.file_khong_hop_le,
                );
              }
            } else {
              // User canceled the picker
            }

            widget.onChange(
              List.generate(
                selectFiles.length,
                (index) => selectFiles[index].file,
              ),
              isOverSize,
            );
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
        Visibility(
          visible: isOverSize,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              '${S.current.tong_file_khong_vuot_qua} $convertData MB',
              style: textNormalCustom(
                color: Colors.red,
                fontSize: 12.0.textScale(),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        if (selectFiles.isNotEmpty)
          ...selectFiles.map((item) {
            if (widget.builder == null) {
              return itemListFile(
                file: item.file,
                onTap: () {
                  if(widget.getIndexFunc != null) {
                    widget.getIndexFunc!(selectFiles.indexOf(item));
                  }
                  selectFiles.remove(item);
                  sumListFileSize(selectFiles);
                  widget.onChange(
                    List.generate(
                      selectFiles.length,
                      (index) => selectFiles[index].file,
                    ),
                    isOverSize,
                  );
                },
                spacingFile: widget.spacingFile,
              );
            }
            return widget.builder!(context, item.file);
          }).toList()
      ],
    );
  }

  Widget itemListFile({
    required File file,
    required Function onTap,
    double? spacingFile,
  }) {
    return Container(
      margin: EdgeInsets.only(top: spacingFile ?? 16.0.textScale()),
      padding: EdgeInsets.symmetric(vertical: 16.0.textScale()),
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
              spaceW16,
              Expanded(
                child: Text(
                  file.path.nameOfFile,
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
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    ImageAssets.icDelete,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FileModel {
  final File file;
  final int size;

  FileModel({required this.file, required this.size});
}
