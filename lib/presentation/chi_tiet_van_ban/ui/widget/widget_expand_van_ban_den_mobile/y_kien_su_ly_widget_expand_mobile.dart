import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../comment_widget.dart';

class YKienXuLyExpandWidgetMobile extends StatefulWidget {
  final CommentsDetailDocumentCubit cubit;
  final String processId;

  const YKienXuLyExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<YKienXuLyExpandWidgetMobile> createState() =>
      _YKienXuLyExpandWidgetMobileState();
}

class _YKienXuLyExpandWidgetMobileState
    extends State<YKienXuLyExpandWidgetMobile>
    with AutomaticKeepAliveClientMixin {
  int? indexActiveRelay;

  @override
  void initState() {
    widget.cubit.getDanhSachYKienXuLy(widget.processId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          widget.cubit.getDanhSachYKienXuLy(widget.processId);
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.cubit.getDanhSachYKienXuLy(widget.processId);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                    if (data.isNotEmpty) {
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
                    }else {
                      return const SizedBox (height: 300,);
                    }
                  },
                ),
              ],
            ),
          ),
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
                  '$DO_MAIN_DOWLOAD_FILE${data.avatar ?? ''}',
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
                  alignment: Alignment.centerRight,
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
          Wrap(
            children: data.yKienXuLyFileDinhKem
                    ?.map(
                      (e) => GestureDetector(
                        onTap: () {
                          handleSaveFile(
                            url:
                                '$DO_MAIN_DOWLOAD_FILE${e.fileDinhKem?.duongDan ?? ''}',
                            name: e.fileDinhKem?.ten ?? '',
                          );
                        },
                        child: Text(
                          '${e.fileDinhKem?.ten ?? ''} ;',
                          style: textNormalCustom(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: textColorMangXaHoi,
                          ), //infoColor
                        ),
                      ),
                    )
                    .toList() ??
                [],
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
