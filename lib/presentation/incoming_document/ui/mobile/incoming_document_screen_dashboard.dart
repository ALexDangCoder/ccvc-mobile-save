import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreenDashBoard extends StatefulWidget {
  final String title;
  final String startDate;
  final String endDate;
  final bool? isDanhSachChoTrinhKy;
  final bool? isDanhSachDaXuLy;
  final bool? isDanhSachChoXuLy;
  final List<int> trangThaiFilter;

  const IncomingDocumentScreenDashBoard({
    Key? key,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.isDanhSachChoTrinhKy = false,
    this.isDanhSachDaXuLy = false,
    this.isDanhSachChoXuLy = false,
    required this.trangThaiFilter,
  }) : super(key: key);

  @override
  _IncomingDocumentScreenDashBoardState createState() =>
      _IncomingDocumentScreenDashBoardState();
}

class _IncomingDocumentScreenDashBoardState
    extends State<IncomingDocumentScreenDashBoard> {
  late IncomingDocumentCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = IncomingDocumentCubit();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorApp,
      appBar: AppBarDefaultBack(widget.title),
      body: SafeArea(
        child: _content(),
      ),
    );
  }

  void callApi(
      int page,
      String startDate,
      String endDate,
      bool isDanhSachChoTrinhKy,
      bool isDanhSachDaXuLy,
      bool isDanhSachChoXuLy,
      List<int> trangThaiFilter) {
    cubit.listDataDanhSachVBDiDashBoard(
      startDate: startDate,
      endDate: endDate,
      index: page,
      size: ApiConstants.DEFAULT_PAGE_SIZE,
      isDanhSachChoXuLy: isDanhSachChoXuLy,
      isDanhSachDaXuLy: isDanhSachDaXuLy,
      isDanhSachChoTrinhKy: isDanhSachChoTrinhKy,
      trangThaiFilter: trangThaiFilter,
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {
        callApi(
          page,
          widget.startDate,
          widget.endDate,
          widget.isDanhSachChoTrinhKy ?? false,
          widget.isDanhSachDaXuLy ?? false,
          widget.isDanhSachChoXuLy ?? false,
          widget.trangThaiFilter,
        )
      },
      viewItem: (value, index) => itemVanBan(value as VanBanModel, index ?? 0),
    );
  }

  Widget itemVanBan(VanBanModel data, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: IncomingDocumentCell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChiTietVanBanDiMobile(
                  id: data.iD ?? '',
                );
              },
            ),
          );
        },
        title: data.loaiVanBan ?? '',
        dateTime: DateTime.parse(data.ngayDen ?? '').toStringWithListFormat,
        userName: data.nguoiSoanThao ?? '',
        status: data.doKhan ?? '',
      ),
    );
  }
}
