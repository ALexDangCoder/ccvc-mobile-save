import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class OutgoingDocumentScreen extends StatefulWidget {
  const OutgoingDocumentScreen({Key? key}) : super(key: key);

  @override
  _OutgoingDocumentScreenState createState() => _OutgoingDocumentScreenState();
}

class _OutgoingDocumentScreenState extends State<OutgoingDocumentScreen> {
  OutgoingDocumentCubit cubit = OutgoingDocumentCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_van_ban_di),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.listIncomingDocument.length,
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
                    title: cubit.listIncomingDocument[index].loaiVanBan,
                    dateTime: cubit.listIncomingDocument[index].ngayBanHanh,
                    userName: cubit.listIncomingDocument[index].nguoiSoanThao,
                    status: cubit.listIncomingDocument[index].doKhan,
                    userImage: 'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
