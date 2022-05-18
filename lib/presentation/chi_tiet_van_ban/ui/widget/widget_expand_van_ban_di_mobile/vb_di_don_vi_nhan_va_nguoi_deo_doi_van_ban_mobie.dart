import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:flutter/material.dart';

class TheoDoiVanBanMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;

  const TheoDoiVanBanMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietVanBanDiModel>(
        stream: cubit.chiTietVanBanDiSubject,
        builder: (context, snapshot) {
          final dataNguoiTheoDoiVanBan =
              snapshot.data?.nguoiTheoDoiResponses ?? [];
          final dataDonViTrongHeThong = snapshot.data?.donViTrongHeThongs ?? [];
          final dataDonViNgoaiHeThong = snapshot.data?.donViNgoaiHeThongs ?? [];
          return Column(
            children: [
              Padding(
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
                        S.current.dv_trong_he_thong,
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataDonViTrongHeThong.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '${dataDonViTrongHeThong[index].ten}',
                            style: textNormalCustom(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: titleColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: AutoSizeText(
                        S.current.dv_ngoai_he_thong,
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataDonViNgoaiHeThong.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '${dataDonViNgoaiHeThong[index].ten}',
                            style: textNormalCustom(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: titleColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
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
                        S.current.nguoi_theo_doi_van_ban,
                        style: textNormalCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataNguoiTheoDoiVanBan.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              '${dataNguoiTheoDoiVanBan[index].hoTen}',
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: titleColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
