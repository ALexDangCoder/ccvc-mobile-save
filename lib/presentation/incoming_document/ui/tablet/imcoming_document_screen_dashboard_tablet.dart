import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_di_tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreenDashBoardTablet extends StatefulWidget {
  final String title;
  final TypeScreen type;
  final String startDate;
  final String endDate;
  final bool? isDanhSachChoTrinhKy;
  final bool? isDanhSachChoXuLy;
  final bool? isDanhSachDaXuLy;
  final List<int> trangThaiFilter;

  const IncomingDocumentScreenDashBoardTablet({
    Key? key,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.isDanhSachChoTrinhKy,
    required this.isDanhSachChoXuLy,
    required this.isDanhSachDaXuLy,
    required this.trangThaiFilter,
  }) : super(key: key);

  @override
  _IncomingDocumentScreenDashBoardTabletState createState() =>
      _IncomingDocumentScreenDashBoardTabletState();
}

class _IncomingDocumentScreenDashBoardTabletState
    extends State<IncomingDocumentScreenDashBoardTablet> {
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
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(widget.title),
      body: _content(),
    );
  }

  void callApi(
    int page,
    String startDate,
    String endDate,
      bool isDanhSachChoTrinhKy,
      bool isDanhSachDaXuLy,
      bool isDanhSachChoXuLy,
      List<int> trangThaiFilter
  ) {
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
        top: 24.0,
        right: 30.0,
        left: 30.0,
      ),
      child: IncomingDocumentCellTablet(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (widget.type == TypeScreen.VAN_BAN_DEN) {
                  return ChiTietVanBanDenTablet(
                    processId: data.iD ?? '',
                    taskId: data.taskId ?? '',
                  );
                } else {
                  return ChiTietVanBanDiTablet(
                    id: data.iD ?? '',
                  );
                }
              },
            ),
          );
        },
        title: data.loaiVanBan ?? '',
        dateTime: data.ngayDen ?? '',
        userName: data.nguoiSoanThao ?? '',
        status: data.doKhan ?? '',
        userImage:
            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
        index: index + 1,
      ),
    );
  }
}
