import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_animation_widget.dart';
import 'package:flutter/material.dart';

class TaiLieuWidget extends StatefulWidget {
  const TaiLieuWidget({
    Key? key,
    required this.createCubit,
  }) : super(key: key);
  final CreateWorkCalCubit createCubit;

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.tai_lieu,
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.textScale(),
                  color: color667793,
                ),
              ),
              if (isExpand)
                const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AqiColor,
                )
              else
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AqiColor,
                )
            ],
          ),
        ),
        SizedBox(
          height: 16.5.textScale(),
        ),
        ExpandedSection(
          expand: isExpand,
          child: SelectFileBtn(
            onChange: (files) {
              widget.createCubit.filesTaoLich = files;
            },
            initFileFromApi: widget.createCubit.files
                    ?.map(
                      (file) => FileModel(
                        id: file.id ?? '',
                        fileLength: file.getSize(),
                        name: file.name,
                      ),
                    )
                    .toList() ??
                [],
            onDeletedFileApi: (fileDeleted) {
              widget.createCubit.filesDelete.add(
                fileDeleted.id ?? '',
              );
            },
          ),
        )
      ],
    );
  }
}
