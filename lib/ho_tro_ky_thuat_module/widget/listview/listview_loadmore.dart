import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewLoadMore extends StatefulWidget {
  final BaseCubit<dynamic> cubit;
  final Function(int page) callApi;
  final Widget Function(dynamic, int?) viewItem;
  final bool isListView;
  final double? checkRatio;
  final double? crossAxisSpacing;
  final bool? sinkWap;
  final ScrollPhysics? physics;

  const ListViewLoadMore({
    Key? key,
    required this.cubit,
    required this.isListView,
    required this.callApi,
    required this.viewItem,
    this.checkRatio,
    this.crossAxisSpacing,
    this.sinkWap,
    this.physics,
  }) : super(key: key);

  @override
  State<ListViewLoadMore> createState() => _ListViewLoadMoreState();
}

class _ListViewLoadMoreState extends State<ListViewLoadMore> {
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
    initData();
    super.initState();
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
              widget.cubit.showContent();
            }
          } else {
            widget.cubit.loadMoreList.clear();
            widget.cubit.showError();
          }
          widget.cubit.loadMoreList.addAll(state.posts ?? []);
          widget.cubit.canLoadMore =
              (state.posts?.length ?? 0) >= ApiConstants.DEFAULT_PAGE_SIZE;
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
              if (widget.cubit.canLoadMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                loadMorePosts();
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
                  return widget.isListView == true
                      ? ListView.builder(
                          physics: widget.physics,
                          shrinkWrap: widget.sinkWap ?? false,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (ctx, index) {
                            return widget.viewItem(
                                snapshot.data![index], index);
                          },
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 32,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: widget.crossAxisSpacing ?? 28,
                            childAspectRatio: widget.checkRatio ?? 2 / 3,
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return widget.viewItem(
                                snapshot.data![index], index);
                          },
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
