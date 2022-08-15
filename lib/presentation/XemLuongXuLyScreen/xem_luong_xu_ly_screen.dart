import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/bloc/xem_luong_xu_ly_cubit.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/widgets/container_status_luong_xu_ly_widget.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/widgets/tree_view_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class XemLuongXuLyScreen extends StatefulWidget {
  final String id;

  const XemLuongXuLyScreen({Key? key, required this.id}) : super(key: key);

  @override
  _XemLuongXuLyScreenState createState() => _XemLuongXuLyScreenState();
}

class _XemLuongXuLyScreenState extends State<XemLuongXuLyScreen> {
  XemLuongXuLyCubit viewModel = XemLuongXuLyCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.xemLuongXuLyVbDen(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefaultBack(S.current.luong_xu_ly),
      body: StateStreamLayout(
        stream: viewModel.stateStream,
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: StreamBuilder<NodePhanXuLy<DonViLuongModel>>(
                  stream: viewModel.getPhanXuLy,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data != null) {
                      return TreeViewWidget<DonViLuongModel>(
                        tree: data,
                        builder: (donViLuongModel) {
                          final result = donViLuongModel as DonViLuongModel;
                          return result.isRoot()
                              ? Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 200,
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 13, bottom: 10),
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
                                        height: 6,
                                      ),
                                      Text(
                                        '${S.current.nguoi_tao}:${donViLuongModel.ten}',
                                        style: textNormal(
                                          infoColor,
                                          12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: donViLuongModel.getColor(),
                                          borderRadius: const BorderRadius.all(
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
                                              color:
                                                  donViLuongModel.textColor(),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ContainerStatusLuongXuLyWidget(
                                  colorBorder: donViLuongModel.vaiTroColor(),
                                  child: Column(
                                    children: [
                                      if (result.isCanBo())
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          width: 48,
                                          height: 48,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                          child: CachedNetworkImage(
                                            imageUrl: '',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.black,
                                              child: Image.asset(
                                                ImageAssets.anhDaiDienMacDinh,
                                              ),
                                            ),
                                          ),
                                        )
                                      else
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
                                        height: 6,
                                      ),
                                      Visibility(
                                        visible: result.isCanBo(),
                                        child: Text(
                                          '${donViLuongModel.ten}- ${donViLuongModel.chucVu}',
                                          style: textNormal(infoColor, 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: donViLuongModel.getColor(),
                                          borderRadius: const BorderRadius.all(
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
                                              color:
                                                  donViLuongModel.textColor(),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
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
                        S.current.chu_thich,
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
                            color: color9B8DFF,
                            title: S.current.cho_vao_so,
                          ),
                          rowChuThich(
                            color: color5A8DEE,
                            title: S.current.cho_phan_xu_ly,
                          ),
                          rowChuThich(
                            color: choVaoSoColor,
                            title: S.current.cho_xu_ly,
                          ),
                          rowChuThich(
                            color: color02C5DD,
                            title: S.current.dang_xu_ly,
                          ),
                          rowChuThich(
                            color: daXuLyColor,
                            title: S.current.da_hoan_thanh_s,
                          ),
                          rowChuThich(
                            color: infoColor,
                            title: S.current.thu_hoi,
                          ),
                          rowChuThich(
                            color: pinkColor,
                            title: S.current.tra_lai,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3.textScale(),
                        mainAxisSpacing: 5,
                        childAspectRatio: 6.7,
                        // scrollDirection: Axis.horizontal,
                        children: [
                          rowChuThich(
                            boxShape: BoxShape.rectangle,
                            color: color6FCF97,
                            title: S.current.chu_tri_luong_xu_ly,
                          ),
                          rowChuThich(
                            boxShape: BoxShape.rectangle,
                            color: dangThucHienPurble,
                            title: S.current.phoi_hop,
                          ),
                          rowChuThich(
                            boxShape: BoxShape.rectangle,
                            color: color979797,
                            title: S.current.nhan_de_biet,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              title,
              style: textNormal(titleItemEdit, 16),
            ),
          ),
        ),
      ],
    );
  }
}
