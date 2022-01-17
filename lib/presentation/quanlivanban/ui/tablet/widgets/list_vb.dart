import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/document/outgoing_document.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListVB extends StatefulWidget {
  final String titleButton;
  final List<OutgoingDocument> list;
  final Function() onTap;

  const ListVB({
    required this.titleButton,
    required this.list,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _ListVBState createState() => _ListVBState();
}

class _ListVBState extends State<ListVB> {
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
                    onTap: () {},
                    title: widget.list[index].loaiVanBan,
                    dateTime: widget.list[index].ngayBanHanh,
                    userName: widget.list[index].nguoiSoanThao,
                    status: widget.list[index].doKhan,
                    userImage: '',
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
