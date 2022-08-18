import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/phone/chi_tiet_van_ban_di_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/document_out.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/common_info.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/no_data.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class DocumentOutPage extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const DocumentOutPage({Key? key, required this.qlvbCubit}) : super(key: key);

  @override
  State<DocumentOutPage> createState() => _DocumentInPageState();
}

class _DocumentInPageState extends State<DocumentOutPage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    _handleEventBus();
    super.initState();
  }

  void _handleEventBus() {
    eventBus.on<RefreshList>().listen((event) {
      widget.qlvbCubit.fetchOutcomeDocumentCustom(initLoad: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          widget.qlvbCubit.fetchOutcomeDocumentCustom();
        }
        return true;
      },
      child: SingleChildScrollView(
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
                          widget.qlvbCubit
                              .fetchOutcomeDocumentCustom(initLoad: true);
                        },
                        onStatusTap: (key) {
                          widget.qlvbCubit.documentInStatusCode = '';
                          widget.qlvbCubit.documentInSubStatusCode = key;
                          widget.qlvbCubit
                              .fetchOutcomeDocumentCustom(initLoad: true);
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
                  StreamBuilder<List<VanBanModel>?>(
                    stream: widget.qlvbCubit.danhSachVBDi,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return snapshot.data != null
                          ? data.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.qlvbCubit.vbDiLoadMore
                                      ? data.length + 1
                                      : data.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data ?? [];
                                    return index >= data.length
                                        ? const SizedBox(
                                            height: 50,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                              top: 16,
                                            ),
                                            child: GestureDetector(
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChiTietVanBanDiMobile(
                                                      id: data[index].iD ?? '',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ContainerInfoWidget(
                                                title: data[index]
                                                        .trichYeu
                                                        ?.parseHtml() ??
                                                    '',
                                                listData: [
                                                  InfoData(
                                                    key: S.current.dv_soan_thao,
                                                    value: data[index]
                                                            .donViSoanThao ??
                                                        '',
                                                    urlIcon:
                                                        ImageAssets.icLocation,
                                                  ),
                                                  InfoData(
                                                    key: S.current
                                                        .nguoi_soan_thao,
                                                    value: (data[index]
                                                                    .chucVuNguoiSoanThao ??
                                                                '')
                                                            .isEmpty
                                                        ? data[index]
                                                                .nguoiSoanThao ??
                                                            ''
                                                        : '${data[index].nguoiSoanThao ?? ''} - ${data[index].chucVuNguoiSoanThao ?? ''}',
                                                    urlIcon:
                                                        ImageAssets.imgAcount,
                                                  ),
                                                ],
                                                status:
                                                    data[index].doKhan ?? '',
                                                colorStatus:
                                                    getColorFromPriorityCode(
                                                  data[index].priorityCode ??
                                                      '',
                                                ),
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
