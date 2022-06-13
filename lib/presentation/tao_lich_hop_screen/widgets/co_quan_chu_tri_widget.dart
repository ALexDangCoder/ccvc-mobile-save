
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/container_toggle_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoQuanChuTri extends StatefulWidget {
  const CoQuanChuTri({Key? key, required this.cubit}) : super(key: key);
  final TaoLichHopCubit cubit;

  @override
  State<CoQuanChuTri> createState() => _CoQuanChuTriState();
}

class _CoQuanChuTriState extends State<CoQuanChuTri> {
  bool isTrongDonVi = false;
  bool isNgoaiDonVi = false;
  int indexSelected = -1;

  @override
  void initState() {
    super.initState();
    widget.cubit.taoLichHopRequest.bitTrongDonVi = false;
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
            // key: UniqueKey(),
            showDivider: false,
            title: S.current.trong_don_vi,
            onChange: (value) {
              isTrongDonVi = value;
              widget.cubit.taoLichHopRequest.bitTrongDonVi = isTrongDonVi;
              if (value && isNgoaiDonVi) {
                isNgoaiDonVi = false;
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
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 12),
                  child: Text(
                    S.current.nguoi_chu_tri,
                    style: textNormal(titleItemEdit, 16),
                  ),
                ),
                spaceH20,
                StreamBuilder<List<DonViModel>>(
                  stream: widget.cubit.danhSachCB,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <DonViModel>[];
                    return data.isEmpty
                        ? const NodataWidget()
                        : Column(
                            children: List.generate(
                              data.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  left: 30,
                                  top: index == 0 ? 0 : 8,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    indexSelected = index;
                                    widget.cubit.taoLichHopRequest.chuTri
                                      ?..tenCanBo = data[index].tenCanBo
                                      ..tenCoQuan = data[index].tenDonVi
                                      ..canBoId = data[index].userId
                                      ..donViId = data[index].donViId;
                                    widget.cubit.chuTri = data[index];
                                    widget.cubit.danhSachCB.sink
                                        .add(widget.cubit.danhSachCB.value);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data[index].title,
                                            style: textNormal(color3D5586, 16),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (indexSelected == index)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 4,
                                            ),
                                            child: SvgPicture.asset(
                                              ImageAssets.icCheck,
                                              color: AppTheme.getInstance()
                                                  .colorField(),
                                            ),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
                ContainerToggleWidget(
                  title: S.current.chu_tri_duyet,
                  onChange: (value) {
                    widget.cubit.taoLichHopRequest.bitYeuCauDuyet = value;
                  },
                ),
              ],
            ),
          ),
          spaceH5,
          ContainerToggleWidget(
            showDivider: false,
            initData: isNgoaiDonVi,
            // key: UniqueKey(),
            title: S.current.ngoai_don_vi,
            onChange: (value) {
              isNgoaiDonVi = value;
              if (value && isTrongDonVi) {
                isTrongDonVi = false;
                widget.cubit.taoLichHopRequest.bitYeuCauDuyet = false;
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
                    urlIcon: ImageAssets.icWork,
                    hintText: S.current.ten_co_quan,
                    onChange: (value) {
                      widget.cubit.taoLichHopRequest.chuTri?.tenCoQuan = value;
                    },
                  ),
                  spaceH12,
                  TextFieldStyle(
                    urlIcon: ImageAssets.icPeople,
                    hintText: S.current.nguoi_chu_tri,
                    onChange: (value) {
                      widget.cubit.taoLichHopRequest.chuTri?.tenCanBo = value;
                    },
                  ),
                  spaceH20,
                  Text(S.current.upload_thu_moi_hop,
                    style: textNormal(titleItemEdit, 16),
                  ),
                  spaceH24,
                  ButtonSelectFile(
                    files: [],
                    spacingFile: 16,
                    title: S.current.files_dinh_kem,
                    icon: ImageAssets.icShareFile,
                    onChange: (list) {
                      widget.cubit.listThuMoi = list;
                    },
                    hasMultipleFile: true,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
