import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expands.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaiLichWidget extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final bool isEdit;

  const LoaiLichWidget({
    Key? key,
    required this.taoLichLamViecCubit,
    this.callback,
    this.isEdit = false,
  }) : super(key: key);
  final Function(bool)? callback;

  @override
  _LoaiLichWidgetState createState() => _LoaiLichWidgetState();
}

class _LoaiLichWidgetState extends State<LoaiLichWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LoaiSelectModel>>(
      stream: widget.taoLichLamViecCubit.loaiLich,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectOnlyExpand(
              onChange: (value) {
                widget.taoLichLamViecCubit.selectLoaiLichId = data[value].id;
                if (data[value].id == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
                  widget.taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
                } else {
                  widget.taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
                }
                widget.taoLichLamViecCubit.changeOption.sink
                    .add(data[value].name);
                widget.taoLichLamViecCubit.checkChooseTypeCal.sink.add(false);
              },
              value: widget.isEdit
                  ? (widget.taoLichLamViecCubit.selectLoaiLich?.name ?? '')
                  : '',
              hintText: S.current.chon_loai_lich,
              urlIcon: ImageAssets.icCalendarUnFocus,
              listSelect: data.map((e) => e.name).toList(),
              title: S.current.loai_lich,
            ),
            spaceH12,
            StreamBuilder<bool>(
              stream: widget.taoLichLamViecCubit.checkChooseTypeCal.stream,
              builder: (context, snapshot) {
                widget.callback?.call(snapshot.data ?? true);
                return Visibility(
                  visible: snapshot.data ?? false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      S.current.vui_long_chon_loai_lich,
                      style: textNormalCustom(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
