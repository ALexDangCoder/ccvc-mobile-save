import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/document/incoming_document.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListVBDen extends StatefulWidget {
  final String titleButton;
  final List<IncomingDocument> list;
  final Function() onTap;


  const ListVBDen({
    required this.titleButton,
    required this.list,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _ListVBDenState createState() => _ListVBDenState();
}

class _ListVBDenState extends State<ListVBDen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: bgQLVBTablet,
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buttonChitiet(widget.titleButton, widget.onTap),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  return IncomingDocumentCellTablet(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contetx) => DetailDocumentTablet(),
                        ),
                      );
                    },
                    title: widget.list[index].loaiVanBan,
                    dateTime: widget.list[index].ngayTao,
                    userName: widget.list[index].nguoiSoanThao,
                    status: widget.list[index].doKhan,
                    userImage: 'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                    index: index,
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

Widget buttonChitiet(String text, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 205,
      height: 40,
      padding: const EdgeInsets.only(left: 20),
      color: textDefault.withOpacity(0.1),
      child: Row(
        children: [
          Text(
            text,
            style: textNormalCustom(color: textDefault),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(ImageAssets.ic_chitet),
        ],
      ),
    ),
  );
}
