import 'dart:async';
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
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
    this.replaceFile = false,
    this.overSizeTextMessage,
    this.isShowFile = true,
    this.needClearAfterPick = false,
  }) : super(key: key);

  final bool hasMultiFile;
  final bool replaceFile;

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
  final bool isShowFile;
  final bool needClearAfterPick;

  @override
  State<SelectFileBtn> createState() => SelectFileBtnState();
}

class SelectFileBtnState extends State<SelectFileBtn> {
  final SelectFileCubit cubit = SelectFileCubit();
  late final FToast toast;
  Directory? pathTmp;

  @override
  void initState() {
    super.initState();
    cubit.filesFromApi.addAll(widget.initFileFromApi ?? []);
    cubit.fileFromApiSubject.add(cubit.filesFromApi);
    cubit.selectedFiles.addAll(widget.initFileSystem ?? []);
    toast = FToast();
    toast.init(context);
    getTemporaryDirectory().then((value) => pathTmp = value);
  }

  void clearData (){
    cubit.selectedFiles.clear();
    cubit.needRebuildListFile.sink.add(true);
  }

  void showToast({required String message}) {
    toast.removeQueuedCustomToasts();
    toast.showToast(
      child: ShowToast(
        text: message,
        withOpacity: 0.4,
      ),
      gravity: ToastGravity.TOP_RIGHT,
    );
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      return await sourceFile.rename(newPath);
    } catch (e) {
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
  Future<bool> handleFilePermission() async {
    final permission =
    Platform.isAndroid ? await Permission.storage.request() : true;
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.permanentlyDenied) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> handleButtonFileClicked() async {
    final allowedExtensions = widget.allowedExtensions ??
        const [
          FileExtensions.DOC,
          FileExtensions.DOCX,
          FileExtensions.JPEG,
          FileExtensions.JPG,
          FileExtensions.PDF,
          FileExtensions.PNG,
          FileExtensions.XLSX,
        ];
    for (final element in allowedExtensions) {
      element.toLowerCase();
    }
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.hasMultiFile,
      allowedExtensions: allowedExtensions,
      type: widget.allowedExtensions?.isNotEmpty ?? true
          ? FileType.custom
          : FileType.any,
    );
    if (result == null) {
      return;
    }
    if (!widget.hasMultiFile &&
        (cubit.selectedFiles.isNotEmpty || cubit.filesFromApi.isNotEmpty) &&
        !widget.replaceFile) {
      showToast(
        message: widget.errMultipleFileMessage ?? '',
      );
      return;
    }

    List<File> newFiles = [];

    if (Platform.isIOS) {
      for (final file in result.files) {
        final newFile = await moveFile(
          File(file.path ?? ''),
          '${pathTmp?.path}/${path.basename(file.path ?? '')}',
        );
        newFiles.add(newFile);
      }
    } else {
      newFiles = result.files
          .map(
            (file) => File(file.path ?? ''),
          )
          .toList();
    }

    newFiles.removeWhere(
      (element) {
        final result = !allowedExtensions.contains(
          path.extension(element.path).replaceAll('.', '').toLowerCase(),
        );
        if (result) {
          showToast(
            message: S.current.file_khong_hop_le,
          );
        }
        return result;
      },
    );
    if (widget.replaceFile){
      cubit.selectedFiles.clear();
    }
    final bool isOverMaxSize = cubit.checkOverMaxSize(
      maxSize: widget.maxSize,
      newFiles: newFiles,
    );
    if (isOverMaxSize) {
      showToast(
        message: widget.overSizeTextMessage ?? S.current.dung_luong_toi_da_20,
      );
      return;
    }
    if (widget.replaceFile){
      cubit.selectedFiles = newFiles;
    }else{
      cubit.selectedFiles.addAll(newFiles);
    }

    cubit.needRebuildListFile.sink.add(true);
    widget.onChange(cubit.selectedFiles);
    if (widget.needClearAfterPick) {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        cubit.selectedFiles.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final permission = await handleFilePermission();
            if(permission){
              unawaited(handleButtonFileClicked());
            }else{
              await MessageConfig.showDialogSetting();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getInstance().colorField().withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
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
        if (widget.isShowFile) ...[
          StreamBuilder<List<FileModel>>(
            stream: cubit.fileFromApiSubject.stream,
            builder: (context, snapshot) {
              final listFile = snapshot.data ?? [];
              return Column(
                children: listFile
                    .map(
                      (file) => itemListFile(
                        onDelete: () {
                          cubit.filesFromApi.remove(file);
                          cubit.fileFromApiSubject.sink.add(cubit.filesFromApi);
                          widget.onDeletedFileApi?.call(file);
                        },
                        fileTxt: file.name?.convertNameFile() ?? '',
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
