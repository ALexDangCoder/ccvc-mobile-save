import 'package:ccvc_mobile/bao_cao_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danhSachCanBoBieuQuyetModel.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class DanhSachCanBoBieuQuyet extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;
  final String bieuQuyetId;
  final String luaChonId;

  const DanhSachCanBoBieuQuyet({
    Key? key,
    required this.cubit,
    required this.bieuQuyetId,
    required this.luaChonId,
  }) : super(key: key);

  @override
  State<DanhSachCanBoBieuQuyet> createState() => _DanhSachCanBoBieuQuyetState();
}

class _DanhSachCanBoBieuQuyetState extends State<DanhSachCanBoBieuQuyet> {
  @override
  void initState() {
    widget.cubit.danhSachCanBoBieuQuyet(
      bieuQuyetId: widget.bieuQuyetId,
      luaChonId: widget.luaChonId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ButtonBottom(
          text: S.current.dong,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: StreamBuilder<DanhSachCanBoBieuQuyetModel>(
          stream: widget.cubit.danhSachCanBoBieuQuyetSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? DanhSachCanBoBieuQuyetModel();
            if (data.data?.danhSachCanBoBieuQuyet?.isNotEmpty ?? false) {
              return ListView.builder(
                itemCount: data.data?.danhSachCanBoBieuQuyet?.length ?? 0,
                itemBuilder: (context, index) {
                  return itemListCanBo(
                    model: data.data?.danhSachCanBoBieuQuyet?[index] ??
                        DanhSachCanBoBieuQuyetMd(),
                  );
                },
              );
            } else {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: const NodataWidget(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget itemListCanBo({required DanhSachCanBoBieuQuyetMd model}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: borderItemCalender),
        color: borderItemCalender.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.ho_va_ten_can_bo,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW20,
              Expanded(
                flex: 7,
                child: Text(
                  '${model.hoTenCanBo}',
                  style: textNormalCustom(
                    fontSize: 16,
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          spaceH10,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.chuc_vu_can_bo,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW20,
              Expanded(
                flex: 7,
                child: Text(
                  '${model.chucVuCanBo}',
                  style: textNormalCustom(
                    fontSize: 16,
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          spaceH10,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S.current.dv_can_bo,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              spaceW20,
              Expanded(
                flex: 7,
                child: Text(
                  '${model.donViCanBo}',
                  style: textNormalCustom(
                    fontSize: 16,
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
