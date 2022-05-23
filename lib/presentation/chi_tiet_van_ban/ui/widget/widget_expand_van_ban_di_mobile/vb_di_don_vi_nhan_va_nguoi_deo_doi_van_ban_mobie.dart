import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TheoDoiVanBanMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String id;

  const TheoDoiVanBanMobile({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        cubit.getChiTietVanBanDi(id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await cubit.getChiTietVanBanDi(id);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: StreamBuilder<ChiTietVanBanDiModel>(
            stream: cubit.chiTietVanBanDiSubject,
            builder: (context, snapshot) {
              final dataNguoiTheoDoiVanBan =
                  snapshot.data?.nguoiTheoDoiResponses ?? [];
              final dataDonViTrongHeThong =
                  snapshot.data?.donViTrongHeThongs ?? [];
              final dataDonViNgoaiHeThong =
                  snapshot.data?.donViNgoaiHeThongs ?? [];
              return Column(
                children: [
                  cellData(
                    S.current.dv_trong_he_thong,
                    dataDonViTrongHeThong.map((e) => e.ten ?? '').toList(),
                    isPersonal: false,
                  ),
                  cellData(
                    S.current.dv_ngoai_he_thong,
                    dataDonViNgoaiHeThong.map((e) => e.ten ?? '').toList(),
                    isPersonal: false,
                  ),
                  cellData(
                    S.current.nguoi_theo_doi_van_ban,
                    dataNguoiTheoDoiVanBan
                        .map((e) => '${e.hoTen ?? ''} - ${e.chucVu ?? ''}; ')
                        .toList(),
                    isPersonal: true,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget cellData(String name, List<String> data, {required bool isPersonal}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: AutoSizeText(
              name,
              style: textNormalCustom(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: titleColumn,
              ),
            ),
          ),
          spaceW12,
          Expanded(
            flex: 7,
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: data
                  .map(
                    (e) => isPersonal ? itemPersonal(e) : itemOrganization(e),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget itemOrganization(String name) => Container(
        decoration: BoxDecoration(
          color: borderColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 3,
        ),
        child: Text(
          name,
          style: textNormalCustom(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: titleColor,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget itemPersonal(String name) => Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: titleColor,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
}
