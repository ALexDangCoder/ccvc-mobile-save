import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_den_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/mobile/widgets/common_infor_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class DocumentInPage extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const DocumentInPage({Key? key, required this.qlvbCubit}) : super(key: key);

  @override
  State<DocumentInPage> createState() => _DocumentInPageState();
}

class _DocumentInPageState extends State<DocumentInPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpandOnlyWidget(
              initExpand: true,
              header: Container(
                alignment: Alignment.centerLeft,
                color: Colors.transparent,
                child: Text(
                  S.current.word_processing_state,
                  style: textNormalCustom(
                    color: textTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: StreamBuilder<DocumentDashboardModel>(
                stream: widget.qlvbCubit.getVbDen,
                builder: (context, snapshot) {
                  final dataVBDen = snapshot.data ?? DocumentDashboardModel();
                  return CommonInformationMobile(
                    chartData: widget.qlvbCubit.chartDataVbDen,
                    documentDashboardModel: dataVBDen,
                    onPieTap: (value) {
                      widget.qlvbCubit.documentInSubStatusCode = '';
                      widget.qlvbCubit.documentInStatusCode =
                          widget.qlvbCubit.documentInStatusCode == value
                              ? ''
                              : value;
                      widget.qlvbCubit.listDataDanhSachVBDen();
                    },
                    onStatusTap: (key) {
                      widget.qlvbCubit.documentInStatusCode = '';
                      widget.qlvbCubit.documentInSubStatusCode = key;
                      widget.qlvbCubit.listDataDanhSachVBDen();
                    },
                  );
                },
              ),
            ),
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
                  ],
                ),
                StreamBuilder<List<VanBanModel>>(
                  stream: widget.qlvbCubit.getDanhSachVbDen,
                  builder: (context, snapshot) {
                    final List<VanBanModel> listData = snapshot.data ?? [];
                    return listData.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 16,
                                  top: (index == 0) ? 16 : 0,
                                ),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChiTietVanBanDenMobile(
                                          processId: listData[index].iD ?? '',
                                          taskId: listData[index].taskId ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: ContainerInfoWidget(
                                    title:
                                        listData[index].trichYeu?.parseHtml() ??
                                            '',
                                    listData: [
                                      InfoData(
                                        key: S.current.so_ky_hieu,
                                        value: listData[index].number ?? '',
                                        urlIcon: ImageAssets.icInfo,
                                      ),
                                      InfoData(
                                        key: S.current.noi_gui,
                                        value: listData[index].sender ?? '',
                                        urlIcon: ImageAssets.icLocation,
                                      ),
                                    ],
                                    status: getNameFromStatus(
                                        listData[index].statusCode ?? -1),
                                    colorStatus: getColorFromStatus(
                                        listData[index].statusCode ?? -1),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.all(16),
                            child: NodataWidget(),
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
