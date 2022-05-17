import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:flutter/material.dart';

class YKienSuLyWidgetExpandTablet extends StatefulWidget {
  final CommentsDetailDocumentCubit cubit;
  final String processId;

  const YKienSuLyWidgetExpandTablet({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<YKienSuLyWidgetExpandTablet> createState() =>
      _YKienSuLyWidgetExpandTabletState();
}

class _YKienSuLyWidgetExpandTabletState
    extends State<YKienSuLyWidgetExpandTablet>
    with AutomaticKeepAliveClientMixin {

  int? indexActiveRelay;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 6,
                left: 16,
                right: 16,
                top: 3,
              ),
              child: const WidgetComments(),
            ),
            StreamBuilder<List<DanhSachYKienXuLy>>(
              stream: widget.cubit.danhSachYKienXuLyStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 6,
                        left: 13,
                        right: 13,
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: containerColorTab,
                        ),
                        color: containerColorTab.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: _itemViewDetail(
                        data: data[index],
                        index: index,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemViewDetail({
    required int index,
    required DanhSachYKienXuLy data,
    bool showChild = true,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  data.avatar ??
                      'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png',
                ),
              ),
              spaceW13,
              Expanded(
                child: Text(
                  data.tenNhanVien ?? '',
                  style: textNormalCustom(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppTheme.getInstance().titleColor(),
                  ), //infoColor
                ),
              ),
              Expanded(
                child: Align(
                  alignment:  Alignment.centerRight,
                  child: Text(
                    data.ngayTao ?? '',
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          spaceH12,
          Text(
            data.noiDung ?? '',
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceH10,
          Text(
            S.current.van_ban_dinh_kem,
            style: textNormalCustom(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceH6,
          Row(
            children: [
              if (data.yKienXuLyFileDinhKem?.isNotEmpty ?? false) ...[
                GestureDetector(
                  onTap: () {
                    //todo
                  },
                  child: Text(
                    data.yKienXuLyFileDinhKem
                        ?.map((e) => e.fileDinhKem?.ten ?? '')
                        .toList()
                        .join(',') ??
                        '',
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: textColorMangXaHoi,
                    ), //infoColor
                  ),
                ),
                spaceW16
              ],
              if (showChild)
                GestureDetector(
                  onTap: () {
                    if (index != indexActiveRelay) {
                      setState(() {
                        if (indexActiveRelay != null) {
                          widget.cubit.listComment[indexActiveRelay!].isInput =
                          false;
                        }
                        widget.cubit.listComment[index].isInput = true;
                        indexActiveRelay = index;
                      });
                    }
                  },
                  child: Text(
                    S.current.phan_hoi,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: textColorMangXaHoi,
                    ), //infoColor
                  ),
                ),
            ],
          ),
          // if ((data.listYKien?.isNotEmpty ?? false) && showChild == true) ...[
          //   ListView.builder(
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: data.listYKien?.length ?? 0,
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.only(left: 32, top: 24),
          //         child: _itemViewDetail(
          //           index: index,
          //           showChild: false,
          //           data: data.listYKien?[index] ?? ChiTietYKienXuLyModel(),
          //         ),
          //       );
          //     },
          //   ),
          //   spaceH24
          // ] else
          spaceH24,
          if (data.isInput)
            WidgetComments(
              onTab: () {},
              focus: true,
              onSend: (comment, listData) {},
            )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
