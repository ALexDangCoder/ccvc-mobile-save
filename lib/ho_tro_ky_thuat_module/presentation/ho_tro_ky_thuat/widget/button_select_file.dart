import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

import 'file_widget.dart';

class ButtonSelectFile extends StatefulWidget {
  final String title;
  final Function(
    List<HTKTFileModel> files,
    bool validate,
  ) onChange;
  final Widget Function(BuildContext, HTKTFileModel)? builder;
  List<HTKTFileModel>? files;
  final double? maxSize;
  final List<String>? allowedExtensions;
  List<HTKTFileModel>? initFileSystem;
  final String errMultipleFileMessage;
  final String? errOverSizeMessage;

  ButtonSelectFile({
    Key? key,
    required this.title,
    required this.onChange,
    this.builder,
    this.files,
    this.maxSize,
    this.allowedExtensions,
    this.initFileSystem,
    this.errMultipleFileMessage = '',
    this.errOverSizeMessage,
  }) : super(key: key);

  @override
  State<ButtonSelectFile> createState() => _ButtonSelectFileState();
}

class _ButtonSelectFileState extends State<ButtonSelectFile> {
  List<HTKTFileModel> selectFiles = [];
  bool isShowErr = false;
  double total = 0;
  String errMessage = '';

  @override
  void initState() {
    super.initState();
    widget.files ??= [];
    selectFiles = widget.files ?? [];
    selectFiles.addAll(widget.initFileSystem ?? []);
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

  void sumListFileSize(List<HTKTFileModel> files, String? message) {
    for (final element in files) {
      total += element.size;
    }
    setState(() {
      isShowErr = total > widget.maxSize!;
      if (isShowErr) {
        errMessage = widget.errOverSizeMessage ??
            '${S.current.tong_file_khong_vuot_qua} $convertData MB';
      }
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
              if (isFileError(result.paths)) {
                MessageConfig.show(
                  messState: MessState.error,
                  title: S.current.file_khong_hop_le,
                );
                return;
              }
              errMessage = '';
              isShowErr = false;
              selectFiles.addAll(
                result.files
                    .map(
                      (file) => HTKTFileModel(
                        name: basename(file.path ?? ''),
                        path: file.path ?? '',
                        size: file.size,
                      ),
                    )
                    .toSet()
                    .toList(),
              );
              if (widget.maxSize != null) {
                sumListFileSize(selectFiles, widget.errOverSizeMessage);
              }
              setState(() {});
            }
            widget.onChange(
              List.generate(
                selectFiles.length,
                (index) => selectFiles[index],
              ),
              isShowErr,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getInstance().colorField().withOpacity(0.1),
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
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.icShareFile,
                      color: AppTheme.getInstance().colorField(),
                    ),
                    SizedBox(
                      width: 11.25.textScale(),
                    ),
                  ],
                ),
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
        Visibility(
          visible: isShowErr,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              errMessage,
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
                file: item,
                onTap: () {
                  selectFiles.remove(item);
                  sumListFileSize(selectFiles, widget.errOverSizeMessage);
                  widget.onChange(
                    List.generate(
                      selectFiles.length,
                      (index) => selectFiles[index],
                    ),
                    isShowErr,
                  );
                },
              );
            }
            return widget.builder!(context, item);
          }).toList()
      ],
    );
  }

  Widget itemListFile({
    required HTKTFileModel file,
    required Function onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 16.0.textScale()),
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
                  file.name,
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
