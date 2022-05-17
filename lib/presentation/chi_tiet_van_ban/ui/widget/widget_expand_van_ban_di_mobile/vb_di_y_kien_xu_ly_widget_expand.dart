import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/y_kien_xu_ly_van_ban_di_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import '../comment_widget.dart';

class VBDiYKienXuLyExpandWidget extends StatefulWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String idDocument;

  const VBDiYKienXuLyExpandWidget({
    Key? key,
    required this.cubit,
    required this.idDocument,
  }) : super(key: key);

  @override
  State<VBDiYKienXuLyExpandWidget> createState() =>
      _VBDiYKienXuLyExpandWidgetState();
}

class _VBDiYKienXuLyExpandWidgetState extends State<VBDiYKienXuLyExpandWidget> {
  int? indexActiveRelay;

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getChiTietVanBanDi(widget.idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getChiTietVanBanDi(widget.idDocument);
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
              StreamBuilder<ChiTietVanBanDiModel>(
                stream: widget.cubit.chiTietVanBanDiSubject,
                builder: (context, snapshot) {
                  final dataDSCYK = snapshot.data?.danhSachChoYKien ?? [];
                  if (dataDSCYK.isNotEmpty) {
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
                          child: _itemViewDetail(
                            data: dataDSCYK[index],
                            index: index,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: NodataWidget(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemViewDetail({
    required int index,
    required DanhSachChoYKien data,
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
                  data.anhDaiDien ??
                      'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png',
                ),
              ),
              spaceW13,
              Expanded(
                child: Text(
                  data.tenCanBo ?? '',
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
          Row(
            children: [
              if (data.danhSachFiles?.isNotEmpty ?? false) ...[
                GestureDetector(
                  onTap: () {
                    //todo
                  },
                  child: Text(
                    data.danhSachFiles
                            ?.map((e) => e.ten ?? '')
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
                          (widget.cubit.chiTietVanBanDiSubject.valueOrNull
                                      ?.danhSachChoYKien ??
                                  [])[indexActiveRelay!]
                              .isInput = false;
                        }
                        (widget.cubit.chiTietVanBanDiSubject.valueOrNull
                                    ?.danhSachChoYKien ??
                                [])[index]
                            .isInput = true;
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
}
