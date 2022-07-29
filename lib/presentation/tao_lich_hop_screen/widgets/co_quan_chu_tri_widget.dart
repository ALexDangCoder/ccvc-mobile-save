import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/select_file/select_file.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/select_only_expand_model.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class CoQuanChuTri extends StatefulWidget {
  const CoQuanChuTri({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final TaoLichHopCubit cubit;

  @override
  State<CoQuanChuTri> createState() => _CoQuanChuTriState();
}

class _CoQuanChuTriState extends State<CoQuanChuTri> {
  bool isTrongDonVi = false;
  bool isNgoaiDonVi = false;
  String initValue = '';

  @override
  void initState() {
    super.initState();
    if (widget.cubit.taoLichHopRequest.bitTrongDonVi != null) {
      isTrongDonVi = widget.cubit.taoLichHopRequest.bitTrongDonVi!;
      isNgoaiDonVi = !widget.cubit.taoLichHopRequest.bitTrongDonVi!;
    }
    widget.cubit.danhSachCB.listen((value) {
      initValue = value
          .firstWhere(
            (e) =>
                e.userId ==
                (widget.cubit.taoLichHopRequest.chuTri?.canBoId?.isEmpty ?? true
                    ? HiveLocal.getDataUser()?.userId ?? ''
                    : widget.cubit.taoLichHopRequest.chuTri?.canBoId),
            orElse: () => DonViModel(),
          )
          .userId;
    });
  }

  //Kiểm tra chủ trì có phải là tài khoản đang login
  BehaviorSubject<bool> isCurrrenUser = BehaviorSubject.seeded(false);

  void handleDropDownSelected({required DonViModel donVi, required int index}) {
    widget.cubit.taoLichHopRequest.chuTri
      ?..tenCanBo = donVi.tenCanBo
      ..tenCoQuan = donVi.tenDonVi
      ..canBoId = donVi.userId
      ..donViId = donVi.donViId;
    widget.cubit.chuTri = donVi;
    if (donVi.userId == HiveLocal.getDataUser()?.userId) {
      isCurrrenUser.add(true);
    } else {
      isCurrrenUser.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: Colors.transparent,
            child: SvgPicture.asset(
              ImageAssets.icPeople,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Text(
              S.current.co_quan_chu_tri,
              style: textNormal(titleItemEdit, 16),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          spaceH12,
          ContainerToggleWidget(
            initData: isTrongDonVi,
            showDivider: false,
            title: S.current.trong_don_vi,
            onChange: (value) {
              isTrongDonVi = value;
              widget.cubit.taoLichHopRequest.bitTrongDonVi = isTrongDonVi;
              if (value && isNgoaiDonVi) {
                isNgoaiDonVi = false;
              }
              if (!value) {
                widget.cubit.taoLichHopRequest.chuTri
                  ?..tenCanBo = null
                  ..tenCoQuan = null
                  ..canBoId = null
                  ..donViId = null;
              }
              if(!value && !isNgoaiDonVi){
                widget.cubit.taoLichHopRequest.bitTrongDonVi = null;
              }
              setState(() {});
            },
          ),
          if (!isTrongDonVi)
            const Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Divider(
                color: colorECEEF7,
                thickness: 1,
              ),
            ),
          Visibility(
            visible: isTrongDonVi,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<List<DonViModel>>(
                  stream: widget.cubit.danhSachCB,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <DonViModel>[];
                    return data.isEmpty
                        ? const NodataWidget()
                        : ExpandGroup(
                      child: SelectOnlyExpandModel(
                              urlIcon: '',
                              title: S.current.nguoi_chu_tri,
                              listSelect: data
                                  .map(
                                    (e) => e.convertToNguoiChuTriModel(),
                                  )
                                  .toList(),
                              onChange: (index) {
                                handleDropDownSelected(
                                  donVi: data[index],
                                  index: index,
                                );
                              },
                              userId: initValue,
                            ),
                          );
                  },
                ),
                StreamBuilder<bool>(
                  stream: isCurrrenUser,
                  builder: (context, snapshot) {
                    final isEnable = snapshot.data ?? false;
                    return IgnorePointer(
                      ignoring: isEnable,
                      child: Stack(
                        children: [
                          ContainerToggleWidget(
                            initData: !isEnable ?
                                widget.cubit.taoLichHopRequest.bitYeuCauDuyet ??
                                    false : false,
                            title: S.current.chu_tri_duyet,
                            onChange: (value) {
                              widget.cubit.taoLichHopRequest.bitYeuCauDuyet =
                                  value;
                            },
                          ),
                          if (isEnable)
                            Positioned.fill(
                              child: Container(
                                color: Colors.white.withOpacity(0.6),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          spaceH5,
          ContainerToggleWidget(
            showDivider: false,
            initData: isNgoaiDonVi,
            title: S.current.ngoai_don_vi,
            onChange: (value) {
              isNgoaiDonVi = value;
              if (value && isTrongDonVi) {
                isTrongDonVi = false;
                widget.cubit.taoLichHopRequest.bitYeuCauDuyet = false;
              }
              if(!value && !isNgoaiDonVi){
                widget.cubit.taoLichHopRequest.bitTrongDonVi = null;
              }
              widget.cubit.taoLichHopRequest.bitTrongDonVi = isTrongDonVi;
              setState(() {});
            },
          ),
          if(!isNgoaiDonVi)
            const Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Divider(
                color: colorECEEF7,
                thickness: 1,
              ),
            ),
          if(isNgoaiDonVi)
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldStyle(
                    initValue: widget.cubit.taoLichHopRequest.chuTri?.tenCoQuan,
                    urlIcon: ImageAssets.icWork,
                    hintText: S.current.ten_co_quan,
                    onChange: (value) {
                      widget.cubit.taoLichHopRequest.chuTri?.tenCoQuan = value;
                    },
                    validate: (value) {
                      if (isNgoaiDonVi && value.isEmpty) {
                        return value.pleaseEnter(
                          S.current.ten_co_quan.toLowerCase(),
                        );
                      }
                    },
                  ),
                  spaceH12,
                  TextFieldStyle(
                    initValue: widget.cubit.taoLichHopRequest.chuTri?.tenCanBo,
                    urlIcon: ImageAssets.icPeople,
                    hintText: S.current.nguoi_chu_tri,
                    onChange: (value) {
                      widget.cubit.taoLichHopRequest.chuTri?.tenCanBo = value;
                    },
                  ),
                  spaceH20,
                  Text(
                    S.current.upload_thu_moi_hop,
                    style: textNormal(titleItemEdit, 16),
                  ),
                  spaceH24,
                  SelectFileBtn(
                    onChange: (files) {
                      widget.cubit.listThuMoi = files;
                    },
                    hasMultiFile: false,
                    errMultipleFileMessage: S.current.validate_thu_hop,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
