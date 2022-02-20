import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/incoming_documment_provider.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreenTablet extends StatefulWidget {
  const IncomingDocumentScreenTablet({Key? key}) : super(key: key);

  @override
  _IncomingDocumentScreenTabletState createState() =>
      _IncomingDocumentScreenTabletState();
}

class _IncomingDocumentScreenTabletState
    extends State<IncomingDocumentScreenTablet> {
  IncomingDocumentCubit cubit = IncomingDocumentCubit();

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
                        child: StreamBuilder<List<VanBanModel>>(
                          stream: cubit.getListVbDen,
                          builder: (context, snapshot) {
                            final List<VanBanModel> listData =
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
                                        builder: (contetx) =>
                                            DetailDocumentTablet(),
                                      ),
                                    );
                                  },
                                  title: listData[index].loaiVanBan ?? '',
                                  dateTime: listData[index].ngayDen ?? '',
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
