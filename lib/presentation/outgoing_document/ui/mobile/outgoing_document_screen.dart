import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/ui/outgoing_document_provider.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class OutgoingDocumentScreen extends StatefulWidget {
  const OutgoingDocumentScreen({Key? key}) : super(key: key);

  @override
  _OutgoingDocumentScreenState createState() => _OutgoingDocumentScreenState();
}

class _OutgoingDocumentScreenState extends State<OutgoingDocumentScreen> {
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
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    StreamBuilder<List<VanBanDiModel>>(
                      stream: cubit.getDanhSachVbDi,
                      builder: (context, snapshot) {
                        final List<VanBanDiModel> listData =
                            snapshot.data ?? [];
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            return IncomingDocumentCell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailDocument(),
                                  ),
                                );
                              },
                              title: listData[index].loaiVanBan ?? '',
                              dateTime:
                                  DateTime.parse(listData[index].ngayTao ?? '')
                                      .toStringWithListFormat,
                              userName: listData[index].nguoiSoanThao ?? '',
                              status: listData[index].doKhan ?? '',
                              userImage:
                                  'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
