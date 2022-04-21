import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_close.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/widgets/tree_view_widget.dart';
import 'package:flutter/material.dart';

class XemLuongXuLyVbDi extends StatefulWidget {
  final String id;
  const XemLuongXuLyVbDi({Key? key, required this.id}) : super(key: key);

  @override
  _XemLuongXuLyVbDiState createState() => _XemLuongXuLyVbDiState();
}

class _XemLuongXuLyVbDiState extends State<XemLuongXuLyVbDi> {
  XemLuongXuLyVBDIViewModel viewModel = XemLuongXuLyVBDIViewModel();
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
      appBar: AppBarDefaultClose('Luồng xử lý'),
      body: Column(
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
                                // // color: Color(0xffDBDFEF).withOpacity(0.1),
                                border:
                                    Border.all(color: const Color(0xffDBDFEF)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, -1),
                                  child: Container(
                                    height: 6,
                                    width: double.infinity,
                                    color: data.getLoaiBanHanh().color,
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
                                              color: Colors.red),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${QLVBConstant.URLImage}${data.infoCanBo?.anhDaiDien}',
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(
                                                    QLVBConstant.defaultAvatar),
                                          ),
                                        ),
                                      ),
                                      (data.isDenLuot ?? false)
                                          ? Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                child: const Center(
                                                    child:
                                                        DotAnimationWidget()),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${data.infoCanBo?.hoTen ?? ''}',
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                          color: const Color(0xff304261),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${data.getLoaiBanHanh().title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                          color: const Color(0xff586B8B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${data.infoCanBo?.donVi ?? ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                          color: const Color(0xff586B8B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: data.getTrangThai().color,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 11),
                                    child: Text(
                                      data.getTrangThai().title,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                              color: data.colorText(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                    )),
                                const SizedBox(
                                  height: 17,
                                ),
                              ],
                            ));
                      },
                    );
                  }
                  return const SizedBox();
                }),
          ),
          Flexible(
            flex: 5,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffDBDFEF).withOpacity(0.1),
                    border: Border.all(
                        color: const Color(0xffDBDFEF).withOpacity(0.5))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chú thích:',
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: const Color(0xff586B8B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        childAspectRatio: 6.7,
                        children: List.generate(chuThichTrangThai.length, (index) {
                          return rowChuThich(index: index);
                        }),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: rowChuThich(boxShape: BoxShape.rectangle,index: 0)),
                            Expanded(child: rowChuThich(boxShape: BoxShape.rectangle,index: 1))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: rowChuThich(boxShape: BoxShape.rectangle,index: 2)),
                            Expanded(child: rowChuThich(boxShape: BoxShape.rectangle,index: 3))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: rowChuThich(boxShape: BoxShape.rectangle,index: 4)),

                          ],
                        )
                      ],
                    )
                      // GridView.count(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   crossAxisCount: 2,
                      //   // mainAxisSpacing: 5,
                      //   childAspectRatio: 3.2,
                      //   children:
                      //       List.generate(chuThichTrangThaiLuong.length, (index) {
                      //     final data = chuThichTrangThaiLuong[index];
                      //     return rowChuThich(
                      //         color: data.color,
                      //         title: data.title,
                      //         boxShape: BoxShape.rectangle);
                      //   }),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowChuThich(
      {
      BoxShape boxShape = BoxShape.circle,
      required int index}) {
    final data = boxShape == BoxShape.circle ?chuThichTrangThai[index] : chuThichTrangThaiLuong[index];
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
        Flexible(
            child: Text(
              data.title,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: const Color(0xff586B8B), fontSize: 16),
              maxLines: 2,
            ))
      ],
    );
  }
}
