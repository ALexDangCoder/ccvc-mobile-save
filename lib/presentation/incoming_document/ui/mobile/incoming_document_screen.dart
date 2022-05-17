import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreen extends StatefulWidget {
  final String title;
  final TypeScreen type;
  final String startDate;
  final String endDate;
  final List<String> maTrangThai;
  final bool? isDanhSachDaXuLy;

  const IncomingDocumentScreen({
    Key? key,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.maTrangThai,
    this.isDanhSachDaXuLy,
  }) : super(key: key);

  @override
  _IncomingDocumentScreenState createState() => _IncomingDocumentScreenState();
}

class _IncomingDocumentScreenState extends State<IncomingDocumentScreen> {
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

  void callApi(int page, String startDate, String endDate,
      List<String> maTrangThai, bool isDanhSachDaXuLy) {
    if (widget.type == TypeScreen.VAN_BAN_DEN) {
      cubit.listDataDanhSachVBDen(
        isDanhSachDaXuLy: isDanhSachDaXuLy,
        startDate: startDate,
        endDate: endDate,
        page: page,
        size: ApiConstants.DEFAULT_PAGE_SIZE,
        maTrangThai: maTrangThai,
      );
    } else {
      cubit.listDataDanhSachVBDi(
        startDate: startDate,
        endDate: endDate,
        index: page,
        size: ApiConstants.DEFAULT_PAGE_SIZE,
      );
    }
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
          widget.maTrangThai,
          widget.isDanhSachDaXuLy ?? false,
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
                if (widget.type == TypeScreen.VAN_BAN_DEN) {
                  return ChiTietVanBanDenMobile(
                    processId: data.iD ?? '',
                    taskId: data.taskId ?? '',
                  );
                } else {
                  return ChiTietVanBanDiMobile(
                    id: data.iD ?? '',
                  );
                }
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
