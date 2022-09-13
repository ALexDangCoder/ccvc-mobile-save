import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/them_can_bo_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/them_don_vi_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/widgets/people_tham_gia_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/widgets/thanh_phan_tham_gia_tao_hop.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaWidget extends StatefulWidget {
  final List<RemoveItemTree> scheduleCoperatives;
  final List<DonViModel>? listPeopleInit;
  final Function(List<DonViModel>) onChange;
  final Function(DonViModel)? onDelete;
  final Function(bool) phuongThucNhan;
  final bool isPhuongThucNhan;
  final bool isTaoHop;
  final String noiDungCV;
  final TaoLichHopCubit? cubit;
  final bool isEditCalendarWord;

  const ThanhPhanThamGiaWidget({
    Key? key,
    required this.isPhuongThucNhan,
    required this.onChange,
    required this.phuongThucNhan,
    this.scheduleCoperatives = const [],
    this.listPeopleInit,
    this.isTaoHop = false,
    this.noiDungCV = '',
    this.cubit,
    this.onDelete,
    this.isEditCalendarWord = false,
  }) : super(key: key);

  @override
  _ThanhPhanThamGiaWidgetState createState() => _ThanhPhanThamGiaWidgetState();
}

class _ThanhPhanThamGiaWidgetState extends State<ThanhPhanThamGiaWidget> {
  final ThanhPhanThamGiaCubit _cubit = ThanhPhanThamGiaCubit();

  @override
  void initState() {
    super.initState();
    _cubit.getTree();
    _cubit.listPeopleThamGia.listen((event) {
      widget.onChange(event);
    });
    initDate();
    _cubit.phuongThucNhanStream.listen((event) {
      widget.phuongThucNhan(event);
    });
    widget.cubit?.requestSubject.stream.listen((event) {
      initDate();
    });
    _cubit.addPeopleThamGia(widget.listPeopleInit ?? []);
  }

  void initDate() {
    _cubit.timeStart = widget.cubit?.taoLichHopRequest.timeStart ?? '';
    _cubit.timeEnd = widget.cubit?.taoLichHopRequest.timeTo ?? '';
    _cubit.dateStart = widget.cubit?.taoLichHopRequest.ngayBatDau ?? '';
    _cubit.dateEnd = widget.cubit?.taoLichHopRequest.ngayKetThuc ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<DonViModel>>(
          stream: _cubit.listPeopleThamGia,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];
            final selectedNode =
                data.where((element) => element.canBoId.isEmpty).toList();
            return ThemDonViWidget(
              cubit: _cubit,
              listIdDonViRemove: widget.isEditCalendarWord
                  ? selectedNode
                      .map(
                        (e) => RemoveItemTree(donViId: e.donViId, canBoId: ''),
                      )
                      .toList()
                  : widget.scheduleCoperatives,
              listSelectNode: selectedNode,
              onChange: (value) {
                for (final Node<DonViModel> element in value) {
                  element.value.vaiTroThamGia = 1;
                  element.value.type = 2;
                  if (element.value.donViId.isEmpty) {
                    element.value.donViId = element.value.id;
                  }
                }
                _cubit.addPeopleThamGiaDonVi(
                  value.map((e) => e.value).toList(),
                  widget.isEditCalendarWord,
                );
              },
            );
          },
        ),
        SizedBox(
          height: 16.0.textScale(space: 8),
        ),
        ThemCanBoWidget(
          isEditCalendarWork: widget.isEditCalendarWord,
          cubit: _cubit,
          listCaNhanRemove: widget.scheduleCoperatives,
          onChange: (value) {
            for (final element in value) {
              element.vaiTroThamGia = 2;
              element.type = 1;
            }
            _cubit.addPeopleThamGia(value);
          },
          needCheckTrung: widget.isTaoHop,
        ),
        SizedBox(
          height: 20.0.textScale(space: -2),
        ),
        if (widget.isPhuongThucNhan)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    S.current.phuong_thuc_nhan_khac,
                    style: textNormal(textBodyTime, 14),
                  ),
                  spaceW25,
                  StreamBuilder<bool>(
                    stream: _cubit.phuongThucNhanStream,
                    builder: (context, snapshot) {
                      return CustomCheckBox(
                        title: S.current.gui_email,
                        onChange: (isCheck) {
                          _cubit.changePhuongThucNhan(value: isCheck);
                        },
                        isCheck: snapshot.data ?? false,
                      );
                    },
                  )
                ],
              ),
            ],
          )
        else
          Container(),
        StreamBuilder<List<DonViModel>>(
          stream: _cubit.listPeopleThamGia,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <DonViModel>[];
            return Column(
              children: List.generate(
                data.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical:
                        data[index].status != StatusOfficersConst.STATUS_THU_HOI
                            ? 16.0.textScale(space: -2)
                            : 0,
                  ),
                  child: widget.isTaoHop
                      ? StreamBuilder<bool>(
                          stream: _cubit.phuongThucNhanStream,
                          builder: (context, snapshot) {
                            return ItemPeopleThamGia(
                              noiDungCV: widget.noiDungCV,
                              cubit: _cubit,
                              donVi: data[index],
                              onDelete: () {
                                widget.onDelete?.call(data[index]);
                              },
                              isSendEmail: snapshot.data ?? false,
                            );
                          },
                        )
                      : !widget.isEditCalendarWord
                          ? itemListThamGia(data[index])
                          : data[index].status !=
                                  StatusOfficersConst.STATUS_THU_HOI
                              ? itemListThamGia(data[index])
                              : const SizedBox.shrink(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget itemListThamGia(DonViModel donViModel) => PeopleThamGiaWidget(
        donVi: donViModel,
        cubit: _cubit,
        onDelete: (DonViModel donViModel) {
          if (widget.isEditCalendarWord) {
            _cubit.listPeople.removeWhere(
              (element) {
                final isCaNhan = donViModel.canBoId.isNotEmpty;
                if (isCaNhan) {
                  return element.canBoId == donViModel.canBoId;
                } else {
                  return element.donViId == donViModel.donViId &&
                      element.canBoId.isEmpty;
                }
              },
            );
          }
        },
      );
}
