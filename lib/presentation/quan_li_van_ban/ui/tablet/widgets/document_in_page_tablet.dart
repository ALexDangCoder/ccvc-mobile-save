import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/document_in.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/common_info.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/no_data.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class DocumentInPageTablet extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const DocumentInPageTablet({Key? key, required this.qlvbCubit})
      : super(key: key);

  @override
  State<DocumentInPageTablet> createState() => _DocumentInPageTabletState();
}

class _DocumentInPageTabletState extends State<DocumentInPageTablet>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    _handleEventBus();

    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<RefreshList>().listen((event) {
      widget.qlvbCubit.fetchIncomeDocumentCustom(initLoad: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          widget.qlvbCubit.fetchIncomeDocumentCustom();
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorFFFFFF,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: borderColor.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10
                  )
                ]
              ),
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(vertical: 28,horizontal: 30),
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
                    return CommonInformationDocumentManagement(
                      isTablet: true,
                      chartData: widget.qlvbCubit.chartDataVbDen,
                      documentDashboardModel: dataVBDen,
                      onPieTap: (value) {
                        widget.qlvbCubit.documentInSubStatusCode = '';
                        widget.qlvbCubit.documentInStatusCode =
                            widget.qlvbCubit.documentInStatusCode == value
                                ? ''
                                : value;
                        widget.qlvbCubit
                            .fetchIncomeDocumentCustom(initLoad: true);
                      },
                      onStatusTap: (key) {
                        widget.qlvbCubit.documentInStatusCode = '';
                        widget.qlvbCubit.documentInSubStatusCode = key;
                        widget.qlvbCubit
                            .fetchIncomeDocumentCustom(initLoad: true);
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  StreamBuilder<List<VanBanModel>?>(
                    stream: widget.qlvbCubit.danhSachVBDen,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return snapshot.data != null
                          ? data.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.qlvbCubit.vbDenLoadMore
                                      ? data.length + 1
                                      : data.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data ?? [];
                                    return index >= data.length
                                        ? const SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 24,
                                              top: (index == 0) ? 16 : 0,
                                            ),
                                            child: GestureDetector(
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChiTietVanBanDenTablet(
                                                      processId: data[index].iD ?? '',
                                                      taskId: data[index].taskId ?? '',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerInfoWidget(
                                                title:
                                                data[index].trichYeu?.parseHtml() ??
                                                        '',
                                                listData: [
                                                  InfoData(
                                                    key: S.current.so_ky_hieu,
                                                    value: data[index].number ?? '',
                                                    urlIcon: ImageAssets.icInfo,
                                                  ),
                                                  InfoData(
                                                    key: S.current.noi_gui,
                                                    value: data[index].sender ?? '',
                                                    urlIcon:
                                                        ImageAssets.icLocation,
                                                  ),
                                                ],
                                                status: getNameFromStatus(
                                                    data[index].statusCode ?? -1),
                                                colorStatus: getColorFromStatus(
                                                    data[index].statusCode ?? -1),
                                              ),
                                            ),
                                          );
                                  },
                                )
                              : const Center(
                                  child: NoData(),
                                )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
