import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_van_ban_di),
      body: Container(
        color: bgTabletColor,
        child: Column(
          children: [
            Container(
              color: backgroundColorApp,
              child: ChooseTimeScreen(
                today: DateTime.now(),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 28.0, right: 30.0, left: 30.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.listIncomingDocument.length,
                    itemBuilder: (context, index) {
                      return IncomingDocumentCellTablet(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailDocumentTablet(),
                            ),
                          );
                        },
                        title: cubit.listIncomingDocument[index].loaiVanBan,
                        dateTime: cubit.listIncomingDocument[index].ngayBanHanh,
                        userName:
                            cubit.listIncomingDocument[index].nguoiSoanThao,
                        status: cubit.listIncomingDocument[index].doKhan,
                        userImage:
                            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
