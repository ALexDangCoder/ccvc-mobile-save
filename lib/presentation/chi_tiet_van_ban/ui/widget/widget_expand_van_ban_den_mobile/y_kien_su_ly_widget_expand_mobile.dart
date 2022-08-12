import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YKienXuLyExpandWidgetMobile extends StatefulWidget {
  final CommentsDetailDocumentCubit cubit;
  final String processId;
  final String taskId;

  const YKienXuLyExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
    required this.taskId,
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
    widget.cubit.getListCommend(widget.processId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          widget.cubit.getListCommend(widget.processId);
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.cubit.getListCommend(widget.processId);
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
                  child: WidgetComments(
                    onSend: (comment, listData) {
                      widget.cubit.comment(
                        comment,
                        listData,
                        widget.processId,
                        widget.taskId,
                      );
                    },
                  ),
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
                            child: _itemCommend(
                              id: data[index].id ?? '',
                              avatar: data[index].avatar ?? '',
                              tenNhanVien: data[index].tenNhanVien ?? '',
                              ngayTao: data[index].ngayTao ?? '',
                              noiDung: data[index].noiDung ?? '',
                              fileDinhKem:
                                  data[index].yKienXuLyFileDinhKem ?? [],
                              listTraLoi: data[index].listTraloiYKien ?? [],
                              canRelay: data[index].canRelay,
                              index: index,
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox(
                        height: 300,
                      );
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

  List<Widget> commentView({
    int? index,
    required String avatar,
    required String tenNhanVien,
    required String ngayTao,
    required String noiDung,
    required List<YKienXuLyFileDinhKem> fileDinhKem,
    required List<TraLoiYKien> listTraLoi,
    bool canRelay = false,
  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              avatar,
            ),
          ),
          spaceW13,
          Expanded(
            child: Text(
              tenNhanVien,
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
                ngayTao,
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
        noiDung,
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
          Expanded(child: _listFile(fileDinhKem)),
          spaceW13,
          _relayButton(canRelay, index)
        ],
      ),
      _listRelayIcon(listTraLoi, canRelay, index),
      spaceH12,
    ];
  }

  Widget _itemCommend({
    int? index,
    String? id,
    required String avatar,
    required String tenNhanVien,
    required String ngayTao,
    required String noiDung,
    required List<YKienXuLyFileDinhKem> fileDinhKem,
    required List<TraLoiYKien> listTraLoi,
    bool canRelay = false,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...commentView(
            index: index,
            listTraLoi: listTraLoi,
            tenNhanVien: tenNhanVien,
            fileDinhKem: fileDinhKem,
            avatar: avatar,
            ngayTao: ngayTao,
            noiDung: noiDung,
            canRelay: canRelay,
          ),
          if (canRelay && indexActiveRelay == index)
            WidgetComments(
              focus: true,
              onSend: (comment, listData) {
                widget.cubit.relay(
                  listFile: listData,
                  comment: comment,
                  documentId: widget.processId,
                  taskId: widget.taskId,
                  commentId: id ?? '',
                );
              },
            )
        ],
      ),
    );
  }

  Widget commentRelay({
    int? index,
    String? id,
    required String avatar,
    required String tenNhanVien,
    required String ngayTao,
    required String noiDung,
    required List<YKienXuLyFileDinhKem> fileDinhKem,
    required List<TraLoiYKien> listTraLoi,
    required bool canRelay,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...commentView(
            index: index,
            listTraLoi: listTraLoi,
            tenNhanVien: tenNhanVien,
            fileDinhKem: fileDinhKem,
            avatar: avatar,
            ngayTao: ngayTao,
            noiDung: noiDung,
            canRelay: canRelay,
          ),
        ],
      ),
    );
  }

  Widget _listRelayIcon(
    List<TraLoiYKien> listTraLoi,
    bool canRelay,
    int? index,
  ) {
    if (listTraLoi.isNotEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listTraLoi.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 32, top: 12),
            child: commentRelay(
              index: index,
              canRelay: canRelay,
              avatar: listTraLoi[i].avatar,
              tenNhanVien: listTraLoi[i].hoTenNguoiTraLoi,
              ngayTao: listTraLoi[i].thoiGianTraLoiStr,
              noiDung: listTraLoi[i].noiDungTraLoi,
              fileDinhKem: listTraLoi[i].lstFileDinhKemTraLoi ?? [],
              listTraLoi: [],
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _listFile(List<YKienXuLyFileDinhKem> data) {
    if (data.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data
            .map(
              (e) => GestureDetector(
                onTap: () {
                  saveFile(
                    url: e.fileDinhKem?.duongDan ?? '',
                    fileName: e.fileDinhKem?.ten ?? '',
                    downloadType: DomainDownloadType.QLNV,
                  );
                },
                child: SizedBox(
                  child: Text(
                    e.fileDinhKem?.ten ?? '',
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: textColorMangXaHoi,
                    ), //infoColor
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return SizedBox(
        child: Text(
          S.current.khong_co_tep_nao,
          style: textNormal(
            textBodyTime,
            14,
          ),
        ),
      );
    }
  }

  Widget _relayButton(bool canRelay, int? index) {
    if (canRelay) {
      return Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              indexActiveRelay = index;
            });
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
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
