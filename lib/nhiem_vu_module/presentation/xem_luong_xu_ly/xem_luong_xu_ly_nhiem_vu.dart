import 'package:cached_network_image/cached_network_image.dart';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/luong_xu_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/xem_luong_xu_ly/bloc/xem_luong_xu_ly_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/xem_luong_xu_ly/widgets/tree_view_widget.dart';

import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
class XemLuongXuLyNhiemVu extends StatefulWidget {
  final String id;
  const XemLuongXuLyNhiemVu({Key? key,required this.id}) : super(key: key);

  @override
  _XemLuongXuLyNhiemVuState createState() => _XemLuongXuLyNhiemVuState();
}

class _XemLuongXuLyNhiemVuState extends State<XemLuongXuLyNhiemVu> {
  XemLuongXuLyNhiemVuCubit viewModel = XemLuongXuLyNhiemVuCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.xemLuongXuLyVbDen(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.luong_xu_ly),
      body:Column(
        children: [
          Expanded(
            flex: 7,
            child: StreamBuilder<NodePhanXuLy<DonViLuongNhiemVuModel>>(
                stream: viewModel.getPhanXuLy,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data != null) {
                    return TreeViewWidget<DonViLuongNhiemVuModel>(
                      tree: data,
                      builder: (donViLuongModel) {
                        final value = donViLuongModel as DonViLuongNhiemVuModel;

                        return value.tenNguoiTao ==null? Container(
                          width: 200,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            children: [

                              Text(
                                donViLuongModel.tenDonVi ?? '',
                                maxLines: 2,
                                style: textNormal(
                                  fontColorTablet2,
                                  14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: donViLuongModel.getColor(),
                                  borderRadius:
                                  const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 11,
                                ),
                                child: FittedBox(
                                  child: Text(
                                    '${donViLuongModel.trangThai}',
                                    maxLines: 1,
                                    style: textNormalCustom(
                                      color: donViLuongModel
                                          .textColor(),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ):  Container(
                          width: 200,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: borderColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 4,
                                width: double.infinity,
                                color: donViLuongModel.vaiTroColor(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      '${donViLuongModel.tenDonVi ?? ''}',
                                      maxLines: 2,
                                      style: textNormal(
                                        selectColorTabbar,
                                        14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: donViLuongModel.getColor(),
                                        borderRadius:
                                        const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 11,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          '${donViLuongModel.trangThai}',
                                          maxLines: 1,
                                          style: textNormalCustom(
                                            color: donViLuongModel
                                                .textColor(),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                }),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: borderColor.withOpacity(0.1),
                  border: Border.all(color: borderColor.withOpacity(0.5))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.chu_thich}:',
                      style: textNormalCustom(
                        color: titleItemEdit,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2.textScale(),
                      mainAxisSpacing: 5,
                      childAspectRatio: 6.7,
                      children: [
                        rowChuThich(
                          color: choXuLyColor,
                          title: S.current.cho_phan_xu_ly,
                        ),
                        rowChuThich(
                          color: chuaThucHienColor,
                          title: S.current.chua_thuc_hien,
                        ),
                        rowChuThich(
                          color: choTrinhKyColor,
                          title: S.current.dang_thuc_hien,
                        ),
                        rowChuThich(
                          color: itemWidgetUsing,
                          title: S.current.da_thuc_hien,
                        ),
                        rowChuThich(
                          color: pinkColor,
                          title: S.current.tra_lai,
                        ),
                        rowChuThich(
                          color: unselectedLabelColor,
                          title: S.current.thu_hoi,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2.textScale(space: 1),
                      mainAxisSpacing: 5,
                      childAspectRatio: 6.7,
                      children: [
                        rowChuThich(
                          boxShape: BoxShape.rectangle,
                          color: chuTriColor,
                          title: S.current.chu_tri,
                        ),
                        rowChuThich(
                            boxShape: BoxShape.rectangle,
                            color: phoiHopColor,
                            title: S.current.phoi_hop),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget rowChuThich({
    required Color color,
    required String title,
    BoxShape boxShape = BoxShape.circle,
  }) {

    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(shape: boxShape, color: color),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: textNormal(titleItemEdit, 16),
        ),
      ],
    );
  }
}
