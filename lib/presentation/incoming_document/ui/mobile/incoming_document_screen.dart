import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/incoming_documment_provider.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreen extends StatefulWidget {
  const IncomingDocumentScreen({Key? key}) : super(key: key);

  @override
  _IncomingDocumentScreenState createState() => _IncomingDocumentScreenState();
}

class _IncomingDocumentScreenState extends State<IncomingDocumentScreen> {
  IncomingDocumentCubit cubit = IncomingDocumentCubit();
  final ScrollController _listCollectionController = ScrollController();

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
      child: InComingDocumentProvider(
        outGoingCubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', ''),
          stream: cubit.stateStream,
          child: Scaffold(
            appBar: AppBarDefaultBack(S.current.danh_sach_van_ban_den),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    StreamBuilder<List<VanBanModel>>(
                        stream: cubit.getListVbDen,
                        builder: (context, snapshot) {
                          final List<VanBanModel> listData =
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
                                      builder: (contetx) => DetailDocument(),
                                    ),
                                  );
                                },
                                title: listData[index].loaiVanBan ?? '',
                                dateTime: DateTime.parse(
                                        listData[index].ngayDen ?? '')
                                    .toStringWithListFormat,
                                userName: listData[index].nguoiSoanThao ?? '',
                                status: listData[index].doKhan ?? '',
                                userImage:
                                    'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                              );
                            },
                          );
                        }),
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
