import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart' show ButtonSelectFileLichLamViec;
import 'package:ccvc_mobile/widgets/button/select_file/select_file_cubit.dart';
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
  }) : super(key: key);
  final bool hasMultiFile;
  final double? maxSize;
  final List<String>? allowedExtensions;
  final Function(List<File> fileSelected) onChange;
  final List<FileModel>? initFileFromApi;
  final List<File>? initFileSystem;

  @override
  State<SelectFileBtn> createState() => _SelectFileBtnState();
}

class _SelectFileBtnState extends State<SelectFileBtn> {
  final SelectFileCubit cubit = SelectFileCubit();

  @override
  void initState() {
    super.initState();
    cubit.fileFromApi.add(widget.initFileFromApi ?? []);
    cubit.selectedFiles.addAll(widget.initFileSystem ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonSelectFileLichLamViec(
          isShowFile: false,
          hasMultipleFile: widget.hasMultiFile,
          maxSize: widget.maxSize,
          title: S.current.tai_lieu_dinh_kem,
          allowedExtensions: widget.allowedExtensions ??
              const [
                FileExtensions.DOC,
                FileExtensions.DOCX,
                FileExtensions.JPEG,
                FileExtensions.JPG,
                FileExtensions.PDF,
                FileExtensions.PNG,
                FileExtensions.PPTX,
                FileExtensions.XLSX,
              ],
          onChange: (List<File> files, bool validate) {
            if (validate) {
              return;
            }
            cubit.selectedFiles.addAll(files);
            cubit.needRebuildListFile.sink.add(true);
            widget.onChange(cubit.selectedFiles);
          },
        ),
        StreamBuilder<List<FileModel>>(
          stream: cubit.fileFromApi.stream,
          builder: (context, snapshot) {
            final listFile = snapshot.data ?? [];
            return Column(
              children: listFile
                  .map(
                    (e) => itemListFile(
                      onDelete: () {
                        cubit.fileFromApi.value.remove(e);
                        cubit.fileFromApi.sink.add(cubit.fileFromApi.value);
                      },
                      fileTxt: e.name ?? '',
                      lengthFile: e.fileLength?.toInt().getFileSize(2),
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
                    (e) => itemListFile(
                      onDelete: () {
                        cubit.selectedFiles.remove(e);
                        cubit.needRebuildListFile.add(true);
                      },
                      fileTxt: e.path.convertNameFile(),
                      lengthFile: e.lengthSync().getFileSize(2),
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
