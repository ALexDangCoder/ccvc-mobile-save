import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/app_bar_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/list_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecTienIchMobile extends StatefulWidget {
  const DanhSachCongViecTienIchMobile({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTienIchMobileState createState() =>
      _DanhSachCongViecTienIchMobileState();
}

class _DanhSachCongViecTienIchMobileState
    extends State<DanhSachCongViecTienIchMobile> {
  DanhSachCongViecTienIchCubit cubit = DanhSachCongViecTienIchCubit();

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                child: StreamBuilder<String>(
                  stream: cubit.statusDSCV.stream,
                  builder: (context, snapshotType) {
                    final dataType = snapshotType.data ?? '';
                    return Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            searchWidgetDscv(
                              cubit: cubit,
                            ),
                            spaceH12,

                            /// list up
                            if (dataType == DSCVScreen.CVCB ||
                                dataType == DSCVScreen.CVQT ||
                                dataType == DSCVScreen.DG ||
                                dataType == DSCVScreen.GCT ||
                                dataType == DSCVScreen.NCVM ||
                                dataType == DSCVScreen.DBX)
                              StreamBuilder<List<TodoDSCVModel>>(
                                stream: cubit.listDSCVStream.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data
                                          ?.where(
                                            (element) =>
                                                element.isTicked == false,
                                          )
                                          .toList() ??
                                      [];
                                  final currentUserCreate =
                                      cubit.currentCreate(data);
                                  final ganChoToi = cubit.listCVGanChoToi(data);
                                  if (data.isNotEmpty) {
                                    if (dataType == DSCVScreen.CVCB) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListUpDSCV(
                                            data: currentUserCreate,
                                            cubit: cubit,
                                            dataType: dataType,
                                          ),
                                          if (currentUserCreate.isNotEmpty)
                                            spaceH12,
                                          expandMobile(
                                            child: ListUpDSCV(
                                              data: ganChoToi,
                                              cubit: cubit,
                                              dataType: dataType,
                                            ),
                                            header: textTitle(
                                              S.current.gan_cho_toi,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return ListUpDSCV(
                                      data: data,
                                      cubit: cubit,
                                      dataType: dataType,
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Column(
                                      children: [
                                        if (dataType == DSCVScreen.DBX)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: textTitle(
                                              S.current.gan_cho_toi,
                                            ),
                                          ),
                                        const NodataWidget(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            if (dataType == DSCVScreen.DBX) spaceH18,

                            /// list down
                            if (dataType == DSCVScreen.DBX ||
                                dataType == DSCVScreen.DHT)
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
                                  if (data.isNotEmpty) {
                                    if (dataType == DSCVScreen.DBX) {
                                      return expandMobile(
                                        child: ListDownDSCV(
                                          data: data,
                                          dataType: dataType,
                                          cubit: cubit,
                                        ),
                                        header: textTitle(
                                          S.current.da_hoan_thanh,
                                        ),
                                      );
                                    }
                                    return ListDownDSCV(
                                      data: data,
                                      dataType: dataType,
                                      cubit: cubit,
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 30,
                                    ),
                                    child: Column(
                                      children: [
                                        if (dataType == DSCVScreen.DBX)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: textTitle(
                                              S.current.da_hoan_thanh,
                                            ),
                                          ),
                                        const NodataWidget(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                        spaceH12,
                        StreamBuilder<bool>(
                          stream: cubit.inLoadmore,
                          builder: (context, snapshot) {
                            if (snapshot.data ?? false) {
                              return const LoadingItem();
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textTitle(String text) => Row(
        children: [
          Text(
            text,
            style: textNormalCustom(
              fontSize: 14,
              color: infoColor,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      );

  Widget expandMobile({
    required Widget child,
    required Widget header,
  }) {
    return ExpandOnlyWidget(
      header: header,
      paddingHeader: EdgeInsets.zero,
      onTap: () {},
      showDecoration: false,
      initExpand: true,
      child: child,
    );
  }
}
