import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/utils/dowload_file.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class TepDinhKemMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String idDocument;
  final bool isTablet;

  const TepDinhKemMobile({
    Key? key,
    required this.cubit,
    required this.idDocument,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        cubit.getChiTietVanBanDi(idDocument);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await cubit.getChiTietVanBanDi(idDocument);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                  stream: cubit.listPhieuTrinh.stream,
                  builder: (context, snapshot) {
                    final _list = snapshot.data ?? [];
                    return cellListFile(S.current.phieu_trinh, _list);
                  },
                ),
                StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                  stream: cubit.listDuThao.stream,
                  builder: (context, snapshot) {
                    final _list = snapshot.data ?? [];
                    return cellListFile(S.current.du_thao, _list);
                  },
                ),
                StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                  stream: cubit.listVBBHKemDuTHao.stream,
                  builder: (context, snapshot) {
                    final _list = snapshot.data ?? [];
                    return cellListFile(
                      S.current.van_ban_ban_hanh_kem_theo_du_an,
                      _list,
                    );
                  },
                ),
                StreamBuilder<List<FileDinhKemVanBanDiModel>>(
                  stream: cubit.listVBLienThong.stream,
                  builder: (context, snapshot) {
                    final _list = snapshot.data ?? [];
                    return cellListFile(S.current.van_ban_lien_quan_kbh, _list);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cellListFile(String title, List<FileDinhKemVanBanDiModel> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: AutoSizeText(
              title,
              style: textNormalCustom(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: titleColumn,
              ),
            ),
          ),
          spaceW6,
          Expanded(
            flex: isTablet ? 10 : 7,
            child: data.isNotEmpty
                ? Wrap(
                    children: data
                        .map(
                          (e) => GestureDetector(
                            onTap: () async {
                              await saveFile(
                                fileName: e.ten ?? '',
                                url: e.duongDan ?? '',
                                downloadType: DomainDownloadType.QLNV,
                              );
                            },
                            child: Text(
                              '${e.ten ?? ''}; ',
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: textColorMangXaHoi,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                  )
                : SizedBox(
                    child: Text(
                      S.current.khong_co_tep_nao,
                      style: textNormal(
                        textBodyTime,
                        14.0.textScale(),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
