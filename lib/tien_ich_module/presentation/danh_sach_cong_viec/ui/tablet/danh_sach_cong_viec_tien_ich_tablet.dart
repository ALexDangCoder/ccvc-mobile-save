import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/text/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/tien_ich_module//utils/constants/api_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/app_bar_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/list_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecTienIchTablet extends StatefulWidget {
  const DanhSachCongViecTienIchTablet({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchTabletState createState() =>
      _DanhSachCongViecTienIchTabletState();
}

class _DanhSachCongViecTienIchTabletState
    extends State<DanhSachCongViecTienIchTablet> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();
  bool isOpenWhenInitListUp = true;
  bool isOpenWhenInitListDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.initialData();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      appBar: appBarDSCV(cubit: cubit, context: context),
      floatingActionButton: buttonThemCongViec(cubit: cubit, context: context),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: cubit.stateStream,
        child: ProviderWidget<DanhSachCongViecTienIchCubit>(
          cubit: cubit,

          /// to load more
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              final loadingMore = cubit.inLoadmore.valueOrNull ?? false;
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200 &&
                  cubit.canLoadMore &&
                  !loadingMore) {
                ++cubit.countLoadMore;
                cubit.callAPITheoFilter(
                  isLoadmore: true,
                  textSearch: cubit.searchControler.text,
                );
              }
              return true;
            },

            /// to refersh
            child: RefreshIndicator(
              onRefresh: () async {
                cubit.countLoadMore = ApiConstants.PAGE_BEGIN;
                await cubit.callAPITheoFilter(
                  textSearch: cubit.searchControler.text,
                );
              },
              child: StreamBuilder<String>(
                stream: cubit.statusDSCV.stream,
                builder: (context, snapshotbool) {
                  final dataType = snapshotbool.data ?? '';
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 28,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 26),
                              child: searchWidgetDscv(
                                cubit: cubit,
                              ),
                            ),
                            if (dataType == DSCVScreen.CVCB ||
                                dataType == DSCVScreen.CVQT ||
                                dataType == DSCVScreen.DG ||
                                dataType == DSCVScreen.NCVM ||
                                dataType == DSCVScreen.DBX)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 28),
                                child: StreamBuilder<List<TodoDSCVModel>>(
                                  stream: cubit.listDSCVStream.stream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data
                                            ?.where(
                                              (element) => dataType !=
                                                      DSCVScreen.DBX
                                                  ? element.isTicked == false
                                                  : element.inUsed == false,
                                            )
                                            .toList() ??
                                        [];
                                    return expanTablet(
                                      isOtherType:
                                          dataType == DSCVScreen.CVCB ||
                                              dataType == DSCVScreen.NCVM,
                                      isCheck: isOpenWhenInitListUp,
                                      title: S.current.gan_cho_toi,
                                      count: data.length,
                                      child: data.isNotEmpty
                                          ? ListUpDSCV(
                                              data: data,
                                              dataType: dataType,
                                              cubit: cubit,
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 20,
                                              ),
                                              child: NodataWidget(),
                                            ),
                                    );
                                  },
                                ),
                              ),
                            if (dataType == DSCVScreen.CVCB ||
                                dataType == DSCVScreen.DHT ||
                                dataType == DSCVScreen.NCVM)
                              StreamBuilder<List<TodoDSCVModel>>(
                                stream: cubit.listDSCVStream.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data
                                          ?.where(
                                            (element) =>
                                                element.isTicked == true,
                                          )
                                          .toList() ??
                                      [];
                                  return expanTablet(
                                    isOtherType: dataType == DSCVScreen.CVCB ||
                                        dataType == DSCVScreen.NCVM,
                                    isCheck: isOpenWhenInitListDown,
                                    title: S.current.da_hoan_thanh,
                                    count: data.length,
                                    child: data.isNotEmpty
                                        ? ListDownDSCV(
                                            data: data,
                                            dataType: dataType,
                                            cubit: cubit,
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: NodataWidget(),
                                          ),
                                  );
                                },
                              ),
                          ],
                        ),
                        spaceH16,
                        StreamBuilder<bool>(
                          stream: cubit.inLoadmore,
                          builder: (context, snapshot) {
                            if (snapshot.data ?? false) {
                              return LoadingItem();
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget expanTablet({
    required String title,
    required int count,
    required Widget child,
    required bool isCheck,
    bool isOtherType = false,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: toDayColor.withOpacity(0.5)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: isOtherType
              ? ExpansionTile(
                  initiallyExpanded: isCheck,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(
                        title,
                        style: textNormalCustom(
                          color: textTitle,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$count ${S.current.cong_viec}',
                        style: tokenDetailAmount(
                          color: infoColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22,
                        right: 26,
                        bottom: 28,
                      ),
                      child: child,
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: child,
                ),
        ),
      );
}
