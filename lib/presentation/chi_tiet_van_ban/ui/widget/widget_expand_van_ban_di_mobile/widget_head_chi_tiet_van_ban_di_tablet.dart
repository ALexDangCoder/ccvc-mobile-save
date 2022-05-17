import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/widget/detail_document_row_tablet.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDiTablet extends StatefulWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String id;

  const WidgetHeadChiTietVanBanDiTablet(
      {Key? key, required this.cubit, required this.id,})
      : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDiTablet> createState() =>
      _WidgetHeadChiTietVanBanDiTabletState();
}

class _WidgetHeadChiTietVanBanDiTabletState
    extends State<WidgetHeadChiTietVanBanDiTablet>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getChiTietVanBanDi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<ChiTietVanBanDiModel>(
      stream: widget.cubit.chiTietVanBanDiSubject,
      builder: (context, snapshot) {
        final dataDonViTrongHeThong = snapshot.data?.donViTrongHeThongs ?? [];
        final dataDonViNgoaiHeThong = snapshot.data?.donViNgoaiHeThongs ?? [];
        final dataNguoiTheoDoiVanBan =
            snapshot.data?.nguoiTheoDoiResponses ?? [];
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: snapshot.data!.toListRowHead().map(
                        (row) {
                      return DetailDocumentRowTablet(
                        row: row,
                      );
                    },
                  ).toList(),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        S.current.nguoi_theo_doi_van_ban,
                        style: textNormalCustom(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: titleColor,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: snapshot.data!.toListRowBottom().map(
                        (row) {
                      return DetailDocumentRowTablet(
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
                  color: bgDropDown,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        S.current.dv_trong_he_thong,
                        style: textNormalCustom(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
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
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w400,
                                color: titleColor,
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
                padding:
                const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: AutoSizeText(
                        S.current.dv_ngoai_he_thong,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w400,
                          color: titleColumn,
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
                                fontSize: 14.0.textScale(),
                                fontWeight: FontWeight.w400,
                                color: titleColor,
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
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  children: snapshot.data!
                      .toListCheckBox()
                      .map(
                        (row) =>
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: AutoSizeText(
                                  row.title,
                                  style: textNormalCustom(
                                    color: titleItemEdit,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  height: 20,
                                  width: 41,
                                  child: CustomCheckBox(
                                    title: '',
                                    isCheck: row.value,
                                    onChange: (bool check) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  )
                      .toList(),
                ),
              ),
            ],
          );
        } else {
          return const NodataWidget();
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
