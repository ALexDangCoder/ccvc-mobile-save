import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyVBDi/xem_luong_xu_ly_vb_di_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class VBDiThongTinKyDuyetExpandWidgetMobile extends StatelessWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String idDocument;
  final bool isTablet;

  const VBDiThongTinKyDuyetExpandWidgetMobile({
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<List<NguoiKyDuyetModel>>(
            stream: cubit.nguoiKyDuyetVanBanDiSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: data.isNotEmpty
                      ? [
                          buttonStream(context),
                          spaceH8,
                          ...listDataWidget(data)
                        ]
                      : [
                          buttonStream(context),
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: NodataWidget(),
                          )
                        ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> listDataWidget(List<NguoiKyDuyetModel> data) {
    if (!isTablet) {
      return data
          .map(
            (e) => itemDetail(e),
          )
          .toList();
    } else {
      final columnLeft = <Widget>[];
      final columnRight = <Widget>[];
      for (int i = 0; i < data.length; i++) {
        if (i % 2 == 0) {
          columnLeft.add(itemDetail(data[i]));
        } else {
          columnRight.add(itemDetail(data[i]));
        }
      }
      return <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: columnLeft,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: columnRight,
              ),
            ),
          ],
        )
      ];
    }
  }

  Widget itemDetail(NguoiKyDuyetModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'http://ccvc.dongnai.edsolabs.vn/img/1.9cba4a79.png',
            ),
          ),
          spaceW13,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${item.tenNguoiKy ?? ''} - ',
                          style: textNormalCustom(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color3D5586,
                          ),
                        ),
                        TextSpan(
                          text: '${item.chucVu ?? ''} - ',
                          style: textNormalCustom(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: color3D5586,
                          ),
                        ),
                        TextSpan(
                          text: item.donViNguoiKy ?? '',
                          style: textNormalCustom(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: color3D5586,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH5,
                Text(
                  item.vaiTro ?? '',
                  style: textNormalCustom(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textColorMangXaHoi,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonStream(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => XemLuongXuLyVbDi(
                  id: idDocument,
                  isTablet: isTablet,
                ),
              ),
            );
          },
          child: Container(
            width: isTablet ? 250 : null,
            color: borderColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 12,
            ),
            child: Center(
              child: Text(
                S.current.xem_luong_xu_ly,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
}
