import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

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
                    left: 42,
                    right: 42,
                    top: 30,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  '$DO_MAIN_DOWLOAD_FILE$avatar',
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
              spaceW13,
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
          GestureDetector(
            onTap: () {
              print ('click');
              setState(() {
                indexActiveRelay = index;
              });
            },
            child: Text(
              S.current.van_ban_dinh_kem,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppTheme.getInstance().titleColor(),
              ), //infoColor
            ),
          ),
          spaceH6,
          Wrap(
            children: fileDinhKem
                .map(
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
                .toList(),
          ),
          if (listTraLoi.isNotEmpty) ...[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listTraLoi.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 32, top: 24),
                  child: _itemCommend(
                    avatar: listTraLoi[i].avatar ,
                    tenNhanVien:  listTraLoi[i].hoTenNguoiTraLoi ,
                    ngayTao: listTraLoi[i].thoiGianTraLoi ,
                    noiDung:  listTraLoi[i].noiDungTraLoi ,
                    fileDinhKem:  listTraLoi[i].lstFileDinhKemTraLoi ?? [] ,
                    listTraLoi: [],
                  ),
                );
              },
            ),
            spaceH24
          ] else
            spaceH24,
          if (canRelay && indexActiveRelay == index)
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
