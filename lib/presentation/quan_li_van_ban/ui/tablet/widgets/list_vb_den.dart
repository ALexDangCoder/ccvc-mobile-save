import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_dell_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListVBDen extends StatefulWidget {
  final String titleButton;
  final List<VanBanModel> list;
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
                itemCount: widget.list.length > 3 ? 3 : widget.list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: IncomingDocumentCellTablet(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contetx) => ChiTietVanBanDenTablet(
                              processId: widget.list[index].iD??'',
                              taskId: widget.list[index].taskId??'',
                            ),
                          ),
                        );
                      },
                      title: widget.list[index].loaiVanBan ?? '',
                      dateTime: widget.list[index].ngayDen ?? '',
                      userName: widget.list[index].nguoiSoanThao ?? '',
                      status: widget.list[index].doKhan ?? '',
                      index: index,
                    ),
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

