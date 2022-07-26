import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectFileBtn extends StatefulWidget {
  const SelectFileBtn({
    Key? key,
    this.hasMultiFile = true,
    this.maxSize,
    this.allowedExtensions,
    required this.onChange,
    this.initFileSystem,
    this.initFileFromApi,
    this.onDeletedFileApi,
    this.errMultipleFileMessage,
    this.textButton,
    this.iconButton,
    this.overSizeTextMessage,
  }) : super(key: key);

  final bool hasMultiFile;
  final double? maxSize;
  final List<String>? allowedExtensions;
  final String? textButton;
  final Function(List<File> fileSelected) onChange;
  final List<FileModel>? initFileFromApi;
  final List<File>? initFileSystem;
  final Function(FileModel fileDeleted)? onDeletedFileApi;
  final String? errMultipleFileMessage;
  final String? iconButton;
  final String? overSizeTextMessage;

  @override
  State<SelectFileBtn> createState() => _SelectFileBtnState();
}

class _SelectFileBtnState extends State<SelectFileBtn> {
  final SelectFileCubit cubit = SelectFileCubit();

  @override
  void initState() {
    super.initState();
    cubit.fileFromApiSubject.add(widget.initFileFromApi ?? []);
    cubit.selectedFiles.addAll(widget.initFileSystem ?? []);
  }

  String get convertData {
    final double value = (widget.maxSize ?? 0) / BYTE_TO_MB;
    return value.toInt().toString();
  }

  Future<void> handleButtonFileClicked() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.hasMultiFile,
      allowedExtensions: widget.allowedExtensions,
      type: (widget.allowedExtensions ?? []).isNotEmpty
          ? FileType.custom
          : FileType.any,
    );

    if (result == null) {
      return;
    }

    if (!widget.hasMultiFile &&
        (cubit.selectedFiles.isNotEmpty || cubit.filesFromApi.isNotEmpty)) {
      cubit.errMessageSubject.add(
        widget.errMultipleFileMessage ?? '',
      );
      return;
    }

    final newFiles = result.files
        .map(
          (file) => File(file.path ?? ''),
        )
        .toList();
    final bool isOverMaxSize = cubit.checkOverMaxSize(
      maxSize: widget.maxSize,
      newFiles: newFiles,
    );
    if (isOverMaxSize) {
      cubit.errMessageSubject.add(
        widget.overSizeTextMessage ??
            '${S.current.tong_file_khong_vuot_qua} '
                '$convertData MB',
      );
      return;
    }

    cubit.errMessageSubject.add('');
    cubit.selectedFiles.addAll(newFiles);
    cubit.needRebuildListFile.sink.add(true);
    widget.onChange(cubit.selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            handleButtonFileClicked();
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
                SvgPicture.asset(
                  widget.iconButton ?? ImageAssets.icShareFile,
                  color: AppTheme.getInstance().colorField(),
                ),
                SizedBox(
                  width: 11.25.textScale(),
                ),
                Text(
                  widget.textButton ?? S.current.tai_lieu_dinh_kem,
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
        StreamBuilder<String>(
          stream: cubit.errMessageSubject,
          builder: (context, snapshot) {
            final errMessage = snapshot.data ?? '';
            return errMessage.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      errMessage,
                      style: textNormalCustom(
                        color: Colors.red,
                        fontSize: 12.0.textScale(),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
          },
        ),
        StreamBuilder<List<FileModel>>(
          stream: cubit.fileFromApiSubject.stream,
          builder: (context, snapshot) {
            final listFile = snapshot.data ?? [];
            return Column(
              children: listFile
                  .map(
                    (file) => itemListFile(
                      onDelete: () {
                        cubit.fileFromApiSubject.value.remove(file);
                        cubit.fileFromApiSubject.sink
                            .add(cubit.fileFromApiSubject.value);
                        widget.onDeletedFileApi?.call(file);
                        final bool isOverMaxSize = cubit.checkOverMaxSize(
                          maxSize: widget.maxSize,
                        );
                        if (!isOverMaxSize) {
                          cubit.errMessageSubject.add(
                            '',
                          );
                          return;
                        }
                      },
                      fileTxt: file.name ?? '',
                      lengthFile: file.fileLength?.toInt().getFileSize(2),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        StreamBuilder(
          stream: cubit.needRebuildListFile.stream,
          builder: (context, snapshot) {
            return Column(
              children: cubit.selectedFiles
                  .map(
                    (file) => itemListFile(
                      onDelete: () {
                        cubit.selectedFiles.remove(file);
                        cubit.needRebuildListFile.add(true);
                        widget.onChange(cubit.selectedFiles);
                        final bool isOverMaxSize = cubit.checkOverMaxSize(
                          maxSize: widget.maxSize,
                        );
                        if (!isOverMaxSize) {
                          cubit.errMessageSubject.add(
                            '',
                          );
                          return;
                        }
                      },
                      fileTxt: file.path.convertNameFile(),
                      lengthFile: file.lengthSync().getFileSize(2),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget itemListFile({
    required String fileTxt,
    required Function onDelete,
    String? lengthFile,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileTxt,
                  style: textNormalCustom(
                    color: color5A8DEE,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
                Visibility(
                  visible: lengthFile != null,
                  child: Text(
                    '$lengthFile',
                    style: textNormal(redChart, 14),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onDelete();
            },
            child: SvgPicture.asset(ImageAssets.icDelete),
          ),
        ],
      ),
    );
  }
}
