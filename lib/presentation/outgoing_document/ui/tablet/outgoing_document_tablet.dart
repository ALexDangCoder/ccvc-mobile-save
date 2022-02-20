import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/ui/outgoing_document_provider.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class OutgoingDocumentScreenTablet extends StatefulWidget {
  const OutgoingDocumentScreenTablet({Key? key}) : super(key: key);

  @override
  _OutgoingDocumentScreenTabletState createState() =>
      _OutgoingDocumentScreenTabletState();
}

class _OutgoingDocumentScreenTabletState
    extends State<OutgoingDocumentScreenTablet> {
  OutgoingDocumentCubit cubit = OutgoingDocumentCubit();

  @override
  void initState() {
    super.initState();
    cubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        cubit.callAPi();
      },
      child: OutgoingDocumentProvider(
        outGoingCubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', ''),
          stream: cubit.stateStream,
          child: Scaffold(
            appBar: AppBarDefaultBack(S.current.danh_sach_van_ban_di),
            body: Container(
              color: bgTabletColor,
              child: Column(
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 28.0,
                          right: 30.0,
                          left: 30.0,
                        ),
                        child: StreamBuilder<List<VanBanDiModel>>(
                          stream: cubit.getDanhSachVbDi,
                          builder: (context, snapshot) {
                            final List<VanBanDiModel> listData =
                                snapshot.data ?? [];
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listData.length,
                              itemBuilder: (context, index) {
                                return IncomingDocumentCellTablet(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailDocumentTablet(),
                                      ),
                                    );
                                  },
                                  title: listData[index].loaiVanBan ?? '',
                                  dateTime: listData[index].ngayTao ?? '',
                                  userName: listData[index].nguoiSoanThao ?? '',
                                  status: listData[index].doKhan ?? '',
                                  userImage:
                                      'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                                  index: index + 1,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
