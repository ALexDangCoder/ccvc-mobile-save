import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ComplexLoadMore extends StatefulWidget {
  final BaseCubit<dynamic> cubit;
  final Function(int page) callApi;
  final List<Widget> childrenView;
  final Widget Function(dynamic, int?) viewItem;
  final bool isListView;
  final double? checkRatio;
  final double? crossAxisSpacing;
  final double? mainAxisExtent;
  final bool? shrinkWap;
  final bool isTitle;
  final String? titleNoData;
  final bool isLoadmore;

  const ComplexLoadMore({
    Key? key,
    required this.cubit,
    required this.isListView,
    required this.callApi,
    required this.childrenView,
    this.checkRatio,
    required this.viewItem,
    this.crossAxisSpacing,
    this.shrinkWap,
    this.isTitle = true,
    this.titleNoData,
    this.mainAxisExtent,
    this.isLoadmore = true,
  }) : super(key: key);

  @override
  State<ComplexLoadMore> createState() => _ComplexLoadMoreState();
}

class _ComplexLoadMoreState extends State<ComplexLoadMore> {
  Future<void> refreshPosts() async {
    if (!widget.cubit.loadMoreLoading) {
      widget.cubit.loadMorePage = ApiConstants.PAGE_BEGIN;
      widget.cubit.loadMoreRefresh = true;
      widget.cubit.loadMoreLoading = true;
      await widget.callApi(widget.cubit.loadMorePage);
    }
  }

  Future<void> loadMorePosts() async {
    if (!widget.cubit.loadMoreLoading) {
      widget.cubit.loadMorePage += ApiConstants.PAGE_BEGIN;
      widget.cubit.loadMoreRefresh = false;
      widget.cubit.loadMoreLoading = true;
      widget.cubit.loadMoreSink.add(widget.cubit.loadMoreLoading);
      await widget.callApi(widget.cubit.loadMorePage);
    }
  }

  Future<void> initData() async {
    widget.cubit.loadMorePage = ApiConstants.PAGE_BEGIN;
    widget.cubit.loadMoreRefresh = true;
    widget.cubit.loadMoreLoading = true;
    await widget.callApi(widget.cubit.loadMorePage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isLoadmore) {
      initData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.cubit,
      listener: (ctx, state) {
        if (state is CompletedLoadMore) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (widget.cubit.loadMoreRefresh ||
                widget.cubit.loadMorePage == ApiConstants.PAGE_BEGIN) {
              widget.cubit.loadMoreList.clear();
              if ((state.posts ?? []).isEmpty) {
              } else {
                widget.cubit.showContent();
              }
            }
          } else {
            widget.cubit.loadMoreList.clear();
            widget.cubit.showError();
          }
          widget.cubit.loadMoreList.addAll(state.posts ?? []);
          widget.cubit.canLoadMore =
              (state.posts?.length ?? 0) >= ApiConstants.DEFAULT_PAGE_SIZE_QLNV;
          widget.cubit.loadMoreLoading = false;
          widget.cubit.loadMoreSink.add(widget.cubit.loadMoreLoading);
          widget.cubit.loadMoreListController.add(widget.cubit.loadMoreList);
        }
      },
      builder: (BuildContext context, Object? state) {
        return StateStreamLayout(
          retry: () {
            refreshPosts();
          },
          error: AppException(
            S.current.error,
            S.current.something_went_wrong,
          ),
          textEmpty: S.current.list_empty,
          stream: widget.cubit.stateStream,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (widget.isLoadmore) {
                if (widget.cubit.canLoadMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  loadMorePosts();
                }
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: refreshPosts,
              child: StreamBuilder(
                stream: widget.cubit.loadMoreListStream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot,
                ) {
                  if (widget.isListView == true) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...widget.childrenView,
                          if (widget.isTitle)
                            Row(
                              mainAxisAlignment:
                                  (snapshot.data?.length ?? 0) > 0
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 16.0.textScale(space: 14.0)),
                                  child: Text(
                                    S.current.danh_sach_nhiem_vu,
                                    style: textNormalCustom(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0.textScale(space: 4.0),
                                      color: textDropDownColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if ((snapshot.data?.length ?? 0) > 0)
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: widget.shrinkWap ?? true,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (ctx, index) {
                                return widget.viewItem(
                                    snapshot.data![index], index);
                              },
                            )
                          else
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  SvgPicture.asset(
                                    ImageAssets.icNoDataNhiemVu,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    widget.titleNoData ??
                                        S.current.khong_co_thong_tin_nhiem_vu,
                                    style: textNormalCustom(
                                        fontSize: 16.0.textScale(space: 4.0),
                                        color: grayChart),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...widget.childrenView,
                          if (widget.isTitle)
                            Row(
                              mainAxisAlignment:
                                  (snapshot.data?.length ?? 0) > 0
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 16.0.textScale(space: 14.0),
                                  ),
                                  child: Text(
                                    S.current.danh_sach_nhiem_vu,
                                    style: textNormalCustom(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0.textScale(space: 4.0),
                                      color: textDropDownColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if ((snapshot.data?.length ?? 0) > 0)
                            GridView.builder(
                              shrinkWrap: widget.shrinkWap ?? true,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: 32,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                mainAxisExtent: widget.mainAxisExtent ?? 0,
                                crossAxisSpacing: widget.crossAxisSpacing ?? 28,
                                childAspectRatio: widget.checkRatio ?? 2 / 3,
                              ),
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (_, index) {
                                return widget.viewItem(
                                    snapshot.data![index], index);
                              },
                            )
                          else
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  SvgPicture.asset(
                                    ImageAssets.icNoDataNhiemVu,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    widget.titleNoData ??
                                        S.current.khong_co_thong_tin_nhiem_vu,
                                    style: textNormalCustom(
                                        fontSize: 16.0.textScale(space: 4.0),
                                        color: grayChart),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
