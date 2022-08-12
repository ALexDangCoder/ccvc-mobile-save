import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class VBDiYKienXuLyExpandWidget extends StatefulWidget {
  final CommentDetailDocumentGoCubit cubit;
  final String idDocument;
  final bool isTablet;

  const VBDiYKienXuLyExpandWidget({
    Key? key,
    required this.cubit,
    required this.idDocument,
    this.isTablet = false,
  }) : super(key: key);

  @override
  State<VBDiYKienXuLyExpandWidget> createState() =>
      _VBDiYKienXuLyExpandWidgetState();
}

class _VBDiYKienXuLyExpandWidgetState extends State<VBDiYKienXuLyExpandWidget> {
  int? indexActiveRelay;

  @override
  void initState() {
    widget.cubit.getDanhSachYKien(widget.idDocument);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getDanhSachYKien(widget.idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getDanhSachYKien(widget.idDocument);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 6,
                  left: widget.isTablet ? 42 : 16,
                  right: widget.isTablet ? 42 : 16,
                  top: widget.isTablet ? 32 : 8,
                ),
                child: WidgetComments(
                  onSend: (comment, listData) {
                    widget.cubit.comment(
                      comment: comment,
                      listData: listData,
                      processId: widget.idDocument,
                    );
                  },
                ),
              ),
              Container(
                color: Colors.transparent,
                constraints: const BoxConstraints(
                  minHeight: 500,
                ),
                child: StreamBuilder<List<DanhSachChoYKien>>(
                  stream: widget.cubit.yKienXuLYSubject,
                  builder: (context, snapshot) {
                    final dataDSCYK = snapshot.data ?? [];
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataDSCYK.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 6,
                            left: 16,
                            right: 16,
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
                            id: dataDSCYK[index].id ?? '',
                            avatar: dataDSCYK[index].anhDaiDien ?? '',
                            tenNhanVien: dataDSCYK[index].tenCanBo ?? '',
                            ngayTao: dataDSCYK[index].ngayTao ?? '',
                            noiDung: dataDSCYK[index].noiDung ?? '',
                            fileDinhKem: dataDSCYK[index].danhSachFiles ?? [],
                            listTraLoi: dataDSCYK[index].traLoi,
                            canRelay:
                                dataDSCYK[index].isNguoiDangNhapCoTheTraLoi ??
                                    false,
                            index: index,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
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
    required List<DanhSachFiles> fileDinhKem,
    required List<DanhSachChoYKien> listTraLoi,
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
          Text(
            tenNhanVien,
            style: textNormalCustom(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppTheme.getInstance().titleColor(),
            ), //infoColor
          ),
          spaceW30,
          Expanded(
            child: Text(
              ngayTao,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: infoColor,
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
      _listRelayIcon(
        listTraLoi,
        canRelay,
        index,
      ),
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
    required List<DanhSachFiles> fileDinhKem,
    required List<DanhSachChoYKien> listTraLoi,
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
                widget.cubit.comment(
                  comment: comment,
                  listData: listData,
                  processId: widget.idDocument,
                  idParent: id,
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
    required List<DanhSachFiles> fileDinhKem,
    required List<DanhSachChoYKien> listTraLoi,
    required bool canRelay,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: commentView(
          index: index,
          listTraLoi: listTraLoi,
          tenNhanVien: tenNhanVien,
          fileDinhKem: fileDinhKem,
          avatar: avatar,
          ngayTao: ngayTao,
          noiDung: noiDung,
          canRelay: canRelay,
        ),
      ),
    );
  }

  Widget _listRelayIcon(
    List<DanhSachChoYKien> listTraLoi,
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
              avatar: listTraLoi[i].anhDaiDien ?? '',
              tenNhanVien: listTraLoi[i].tenCanBo ?? '',
              ngayTao: listTraLoi[i].ngayTao ?? '',
              noiDung: listTraLoi[i].noiDung ?? '',
              fileDinhKem: listTraLoi[i].danhSachFiles ?? [],
              listTraLoi: [],
              canRelay: canRelay,
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _listFile(List<DanhSachFiles> data) {
    if (data.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data
            .map(
              (e) => GestureDetector(
                onTap: () {
                  saveFile(
                    downloadType: DomainDownloadType.QLNV,
                    url: ApiConstants.DOWNLOAD_FILE,
                    fileName: e.ten ?? '',
                    query: {
                      'token': PrefsService.getToken(),
                      'fileId': e.id,
                    },
                  );
                },
                child: SizedBox(
                  child: Text(
                    e.ten ?? '',
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
}
