import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/mobile/incoming_document_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/widget/incoming_document_cell.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/bloc/outgoing_document_cubit.dart';
import 'package:ccvc_mobile/presentation/outgoing_document/ui/mobile/outgoing_document_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/common_infor_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBScreenMobile extends StatefulWidget {
  const QLVBScreenMobile({Key? key}) : super(key: key);

  @override
  _QLVBScreenMobileState createState() => _QLVBScreenMobileState();
}

class _QLVBScreenMobileState extends State<QLVBScreenMobile> {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  OutgoingDocumentCubit cubitOutgoing = OutgoingDocumentCubit();
  IncomingDocumentCubit cubitIncoming = IncomingDocumentCubit();

  @override
  void initState() {
    super.initState();
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.thong_tin_chung,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 130,
                ),
                StreamBuilder<DocumentDashboardModel>(
                  stream: qlvbCubit.getVbDen,
                  builder: (context, snapshot) {
                    final dataVBDen = snapshot.data ?? DocumentDashboardModel();
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: CommonInformationMobile(
                        documentDashboardModel: dataVBDen,
                        isVbDen: true,
                        title: S.current.document_incoming,
                      ),
                    );
                  },
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                StreamBuilder<DocumentDashboardModel>(
                  stream: qlvbCubit.getVbDi,
                  builder: (context, snapshot) {
                    final dataVBDi = snapshot.data ?? DocumentDashboardModel();
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: CommonInformationMobile(
                        documentDashboardModel: dataVBDi,
                        isVbDen: false,
                        title: S.current.document_out_going,
                      ),
                    );
                  },
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.danh_sach_van_ban_den,
                            style: textNormalCustom(
                              fontSize: 16,
                              color: textDropDownColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const IncomingDocumentScreen(),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(ImageAssets.ic_next_color),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubitIncoming.listIncomingDocument.length,
                        itemBuilder: (context, index) {
                          return IncomingDocumentCell(
                            onTap: () {},
                            title: cubitIncoming
                                .listIncomingDocument[index].loaiVanBan,
                            dateTime: cubitIncoming
                                .listIncomingDocument[index].ngayTao,
                            userName: cubitIncoming
                                .listIncomingDocument[index].nguoiSoanThao,
                            status: cubitIncoming
                                .listIncomingDocument[index].doKhan,
                            userImage: 'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.danh_sach_van_ban_di,
                            style: textNormalCustom(
                              fontSize: 16,
                              color: textDropDownColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OutgoingDocumentScreen(),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(ImageAssets.ic_next_color),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubitOutgoing.listIncomingDocument.length,
                        itemBuilder: (context, index) {
                          return IncomingDocumentCell(
                            onTap: () {},
                            title: cubitOutgoing
                                .listIncomingDocument[index].loaiVanBan,
                            dateTime: cubitOutgoing
                                .listIncomingDocument[index].ngayBanHanh,
                            userName: cubitOutgoing
                                .listIncomingDocument[index].nguoiSoanThao,
                            status: cubitOutgoing
                                .listIncomingDocument[index].doKhan,
                            userImage: 'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // const OutgoingDocumentScreen(),
              ],
            ),
          ),
          const TableCalendarWidget(),
        ],
      ),
    );
  }
}
