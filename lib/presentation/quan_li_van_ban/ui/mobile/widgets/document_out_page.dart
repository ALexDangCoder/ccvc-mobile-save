import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
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

class DocumentOutPage extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const DocumentOutPage({Key? key, required this.qlvbCubit}) : super(key: key);

  @override
  State<DocumentOutPage> createState() => _DocumentInPageState();
}

class _DocumentInPageState extends State<DocumentOutPage>
    with AutomaticKeepAliveClientMixin {
  final PagingController<int, VanBanModel> _documentPagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _documentPagingController.addPageRequestListener((pageKey) {
      widget.qlvbCubit.fetchOutcomeDocument(
        pageKey: pageKey,
        documentPagingController: _documentPagingController,
      );
    });
    _handleEventBus();

    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<RefreshList>().listen((event) {
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
                stream: widget.qlvbCubit.getVbDi,
                builder: (context, snapshot) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonInformationDocumentManagement(
                      chartData: widget.qlvbCubit.chartDataVbDi,
                      onPieTap: (value) {
                        widget.qlvbCubit.documentInSubStatusCode = '';
                        widget.qlvbCubit.documentOutStatusCode =
                            widget.qlvbCubit.documentOutStatusCode == value
                                ? ''
                                : value;
                        _documentPagingController.refresh();
                      },
                      onStatusTap: (key) {
                        widget.qlvbCubit.documentInStatusCode = '';
                        widget.qlvbCubit.documentInSubStatusCode = key;
                        _documentPagingController.refresh();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          appDivider,
          spaceH20,
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
                              builder: (context) => ChiTietVanBanDiMobile(
                                id: item.iD ?? '',
                              ),
                            ),
                          );
                        },
                        child: ContainerInfoWidget(
                          title: item.trichYeu?.parseHtml() ?? '',
                          listData: [
                            InfoData(
                              key: S.current.dv_soan_thao,
                              value: item.donViSoanThao ?? '',
                              urlIcon: ImageAssets.icLocation,
                            ),
                            InfoData(
                              key: S.current.nguoi_soan_thao,
                              value: item.nguoiSoanThao ?? '',
                              urlIcon: ImageAssets.imgAcount,
                            ),
                          ],
                          status: item.doKhan ?? '',
                          colorStatus: getColorFromPriorityCode(
                            item.priorityCode ?? '',
                          ),
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
