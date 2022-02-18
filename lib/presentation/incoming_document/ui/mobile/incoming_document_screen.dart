import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingDocumentScreen extends StatefulWidget {
  const IncomingDocumentScreen({Key? key}) : super(key: key);

  @override
  _IncomingDocumentScreenState createState() => _IncomingDocumentScreenState();
}

class _IncomingDocumentScreenState extends State<IncomingDocumentScreen> {
  IncomingDocumentCubit cubit = IncomingDocumentCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_van_ban_den),
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
                    dateTime: cubit.listIncomingDocument[index].ngayTao,
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
