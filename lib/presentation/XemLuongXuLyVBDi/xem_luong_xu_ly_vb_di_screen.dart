import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/document/luong_xu_ly_vb_di.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/widgets/tree_view_widget.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyVBDi/widgets/dot_animation.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

import 'bloc/xem_luong_xu_ly_cubit.dart';

class XemLuongXuLyVbDi extends StatefulWidget {
  final String id;
  final bool isTablet;

  const XemLuongXuLyVbDi({Key? key, required this.id, this.isTablet = false})
      : super(key: key);

  @override
  _XemLuongXuLyVbDiState createState() => _XemLuongXuLyVbDiState();
}

class _XemLuongXuLyVbDiState extends State<XemLuongXuLyVbDi> {
  XemLuongXuLyVBDICubit viewModel = XemLuongXuLyVBDICubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getLuongXuLyVanBanDen(widget.id);
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
              child: StreamBuilder<NodePhanXuLy<LuongXuLyVBDiModel>>(
                stream: viewModel.luongXuLy,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data != null) {
                    return TreeViewWidget<LuongXuLyVBDiModel>(
                      scaleEnable: false,
                      tree: data,
                      builder: (value) {
                        final data = value as LuongXuLyVBDiModel;
                        return Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 190,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: borderColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -1),
                                child: Container(
                                  height: 6,
                                  width: double.infinity,
                                  color: LuongXuLyVBDiModel.getLoaiBanHanh(
                                          data.loaiXuLy)
                                      .color,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${data.infoCanBo?.pathAnhDaiDien}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.black,
                                            child: Image.asset(
                                              ImageAssets.anhDaiDienMacDinh,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (data.isDenLuot ?? false)
                                      const Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: DotAnimationWidget(),
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox()
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data.infoCanBo?.hoTen ?? '',
                                maxLines: 2,
                                style: textNormal(selectColorTabbar, 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  LuongXuLyVBDiModel.getLoaiBanHanh(
                                          data.loaiXuLy)
                                      .title,
                                  style: textNormal(borderCaneder, 14)),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(data.infoCanBo?.donVi ?? '',
                                  style: textNormalCustom(
                                    color: titleItemEdit,
                                    fontSize: 14,
                                  )),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: data.getTrangThai().color,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 11,
                                ),
                                child: Text(data.getTrangThai().title,
                                    maxLines: 1,
                                    style: textNormalCustom(
                                      color: data.colorText(),
                                      fontSize: 12,
                                    )),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            Flexible(
              flex: 5.textScale(space: -5),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: borderColor.withOpacity(0.1),
                    border: Border.all(
                      color: borderColor.withOpacity(0.5),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${S.current.chu_thich}:',
                            style: textNormalCustom(
                              color: titleItemEdit,
                              fontSize: 16,
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2.textScale(),
                          mainAxisSpacing: 5,
                          childAspectRatio: 6.7,
                          children:
                              List.generate(chuThichTrangThai.length, (index) {
                            return rowChuThich(
                                isTablet: widget.isTablet, index: index);
                          }),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2.textScale(space: 3),
                          mainAxisSpacing: 5,
                          childAspectRatio: 6.7,
                          children: List.generate(
                              chuThichTrangThaiLuong.length -
                                  (1.0.textScale(space: -1).toInt()), (index) {
                            return rowChuThich(
                              index: index,
                              boxShape: BoxShape.rectangle,
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        if (widget.isTablet)
                          const SizedBox()
                        else
                          rowChuThich(
                            index: chuThichTrangThaiLuong.length - 1,
                            boxShape: BoxShape.rectangle,
                          ),
                      ],
                    ),
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
    BoxShape boxShape = BoxShape.circle,
    required int index,
    bool isTablet = false,
  }) {
    final data = boxShape == BoxShape.circle
        ? isTablet
            ? chuThichTrangThaiTablet[index]
            : chuThichTrangThai[index]
        : chuThichTrangThaiLuong[index];
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(shape: boxShape, color: data.color),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              data.title,
              style: textNormal(titleItemEdit, 16),
            ),
          ),
        ),
      ],
    );
  }
}
