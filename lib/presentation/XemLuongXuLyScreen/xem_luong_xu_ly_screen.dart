import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/appbar/app_bar_close.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/widgets/tree_view_widget.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/xem_luong_xu_ly_viewmodel.dart';
import 'package:flutter/material.dart';

class XemLuongXuLyScreen extends StatefulWidget {
  final String id;
  const XemLuongXuLyScreen({Key? key, required this.id}) : super(key: key);

  @override
  _XemLuongXuLyScreenState createState() => _XemLuongXuLyScreenState();
}

class _XemLuongXuLyScreenState extends State<XemLuongXuLyScreen> {
  XemLuongXuLyViewModel viewModel = XemLuongXuLyViewModel();

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
      // appBar: AppBarDefaultClose("Luồng cử lý"),
      body: Column(
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
                        return donViLuongModel.isCaNhanFunc()
                            ? Stack(
                                children: [
                                  Container(
                                    height: 190,
                                    width: 200,
                                    margin: const EdgeInsets.only(top: 0),
                                    decoration: BoxDecoration(
                                        color: donViLuongModel.vaiTroColor(),
                                        border: Border.all(
                                            color:
                                                donViLuongModel.vaiTroColor()),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100))),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: 200,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // color: Color(0xffDBDFEF).withOpacity(0.1),
                                          border: Border.all(
                                            color:
                                                donViLuongModel.vaiTroColor(),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100))),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: 48,
                                                  height: 48,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.red),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '',
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.network(
                                                          ''),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${donViLuongModel.ten ?? ''}',
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xff304261),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${donViLuongModel.chucVu ?? ''}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xff586B8B),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: donViLuongModel
                                                            .getColor(),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    30))),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 11),
                                                    child: FittedBox(
                                                      child: Text(
                                                        '${donViLuongModel.trangThai}',
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1
                                                            ?.copyWith(
                                                                color: donViLuongModel
                                                                    .textColor(),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            : Container(
                                width: 200,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: donViLuongModel.vaiTroColor()),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                // padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 4,
                                      width: double.infinity,
                                      color: donViLuongModel.vaiTroColor(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            '${donViLuongModel.tenDonVi ?? ''}',
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(
                                                    color:
                                                        const Color(0xff304261),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: donViLuongModel
                                                      .getColor(),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 11),
                                              child: FittedBox(
                                                child: Text(
                                                  '${donViLuongModel.trangThai}',
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          color: donViLuongModel
                                                              .textColor(),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    )
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
                  color: const Color(0xffDBDFEF).withOpacity(0.1),
                  border: Border.all(
                      color: const Color(0xffDBDFEF).withOpacity(0.5))),
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
                    children: [
                      rowChuThich(
                          color: const Color(0xff0034ff), title: 'Chờ vào sổ'),
                      rowChuThich(
                          color: const Color(0xff5252d4),
                          title: 'Chờ phân xử lý'),
                      rowChuThich(
                          color: const Color(0xff8b4db4), title: 'Chờ xử lý'),
                      rowChuThich(
                          color: const Color(0xff59c6fa), title: 'Đang xử lý'),
                      rowChuThich(
                          color: const Color(0xff42b432), title: 'Đã xử lý'),
                      rowChuThich(
                          color: const Color(0xff9b7938), title: 'Thu hồi'),
                      rowChuThich(
                          color: const Color(0xffe5f52f), title: 'Trả lại'),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    childAspectRatio: 6.7,
                    children: [
                      rowChuThich(
                          boxShape: BoxShape.rectangle,
                          color: const Color(0xff2467d2),
                          title: 'Chủ trì'),
                      rowChuThich(
                          boxShape: BoxShape.rectangle,
                          color: const Color(0xff2ed47a),
                          title: 'Phối hợp'),
                      rowChuThich(
                          boxShape: BoxShape.rectangle,
                          color: const Color(0xffEFECEC),
                          title: 'Nhận để biết'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowChuThich(
      {required Color color,
      required title,
      BoxShape boxShape = BoxShape.circle}) {
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
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: const Color(0xff586B8B)),
        )
      ],
    );
  }
}
