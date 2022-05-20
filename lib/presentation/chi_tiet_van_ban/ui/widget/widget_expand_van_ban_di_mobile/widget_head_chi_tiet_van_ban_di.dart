import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyVBDi/xem_luong_xu_ly_vb_di_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDi extends StatefulWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String id;

  const WidgetHeadChiTietVanBanDi({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDi> createState() =>
      _WidgetHeadChiTietVanBanDiState();
}

class _WidgetHeadChiTietVanBanDiState extends State<WidgetHeadChiTietVanBanDi>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getChiTietVanBanDi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getChiTietVanBanDi(widget.id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: ()async {
          await widget.cubit.getChiTietVanBanDi(widget.id);;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: StreamBuilder<ChiTietVanBanDiModel>(
            stream: widget.cubit.chiTietVanBanDiSubject,
            builder: (context, snapshot) {
              final dataDonViTrongHeThong =
                  snapshot.data?.donViTrongHeThongs ?? [];
              final dataDonViNgoaiHeThong =
                  snapshot.data?.donViNgoaiHeThongs ?? [];
              final dataNguoiTheoDoiVanBan =
                  snapshot.data?.nguoiTheoDoiResponses ?? [];
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 24.0, left: 16.0, right: 16.0),
                      child: ButtonCustomBottom(
                        isColorBlue: false,
                        title: S.current.xem_luong,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => XemLuongXuLyVbDi(
                                id: widget.id,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        children: snapshot.data!.toListRowHead().map(
                          (row) {
                            return DetailDocumentRow(
                              row: row,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 16.0, right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              S.current.nguoi_theo_doi_van_ban,
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color667793,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
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
                                      color: color3D5586,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: snapshot.data!.toListRowBottom().map(
                          (row) {
                            return DetailDocumentRow(
                              row: row,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Divider(
                        thickness: 4,
                        color: colorE2E8F0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 16.0, right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              S.current.dv_trong_he_thong,
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color667793,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dataDonViTrongHeThong.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${dataDonViTrongHeThong[index].ten}',
                                    style: textNormalCustom(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: color3D5586,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 16.0, right: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              S.current.dv_ngoai_he_thong,
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color667793,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dataDonViNgoaiHeThong.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${dataDonViNgoaiHeThong[index].ten}',
                                    style: textNormalCustom(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: color3D5586,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                        children: snapshot.data!
                            .toListCheckBox()
                            .map(
                              (row) => Row(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 41,
                                    child: CustomCheckBox(
                                      title: '',
                                      isCheck: row.value,
                                      onChange: (bool check) {},
                                    ),
                                  ),
                                  AutoSizeText(
                                    row.title,
                                    style: textNormalCustom(
                                      color: color586B8B,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                );
              } else {
                return const NodataWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
