import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/common_info.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DocumentInPageTablet extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const DocumentInPageTablet({Key? key, required this.qlvbCubit})
      : super(key: key);

  @override
  State<DocumentInPageTablet> createState() => _DocumentInPageTabletState();
}

class _DocumentInPageTabletState extends State<DocumentInPageTablet>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, VanBanModel> _documentPagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _documentPagingController.addPageRequestListener((pageKey) {
      widget.qlvbCubit.fetchIncomeDocument(
        pageKey: pageKey,
        documentPagingController: _documentPagingController,
      );
    });
    _handleEventBus();

    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<RefreshList>().listen((event) {
      _documentPagingController.nextPageKey = 1;
      _documentPagingController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: backgroundColorApp,
                border: Border.all(color: cellColorborder)
              ),
              child: ExpandOnlyWidget(
                initExpand: true,
                header: Container(
                  alignment: Alignment.centerLeft,
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
                        _documentPagingController.refresh();
                      },
                      onStatusTap: (key) {
                        widget.qlvbCubit.documentInStatusCode = '';
                        widget.qlvbCubit.documentInSubStatusCode = key;
                        _documentPagingController.refresh();
                      },
                    );
                  },
                ),
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
                PagedListView<int, VanBanModel>(
                  pagingController: _documentPagingController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<VanBanModel>(
                    noItemsFoundIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: NodataWidget(),
                    ),
                    firstPageErrorIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: NodataWidget(),
                    ),
                    itemBuilder: (context, item, index) => Padding(
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
                              builder: (context) => ChiTietVanBanDenTablet(
                                processId: item.iD ?? '',
                                taskId: item.taskId ?? '',
                              ),
                            ),
                          );
                        },
                        child: ContainerInfoWidget(
                          title: item.trichYeu?.parseHtml() ?? '',
                          listData: [
                            InfoData(
                              key: S.current.so_ky_hieu,
                              value: item.number ?? '',
                              urlIcon: ImageAssets.icInfo,
                            ),
                            InfoData(
                              key: S.current.noi_gui,
                              value: item.sender ?? '',
                              urlIcon: ImageAssets.icLocation,
                            ),
                          ],
                          status: getNameFromStatus(item.statusCode ?? -1),
                          colorStatus:
                              getColorFromStatus(item.statusCode ?? -1),
                        ),
                      ),
                    ),
                  ),
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
