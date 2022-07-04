import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadMoreDSCV extends StatelessWidget {
  final BaseCubit<dynamic> cubit;
  final Function(int page) callApi;
  final Widget viewItem;
  final bool isLoadMoreBottom;

  const LoadMoreDSCV({
    Key? key,
    required this.cubit,
    required this.callApi,
    required this.viewItem,
    this.isLoadMoreBottom = true,
  }) : super(key: key);

  Future<void> loadMorePosts() async {
    if (isLoadMoreBottom) {
      if (!cubit.loadMoreLoading) {
        cubit.loadMorePage += ApiConstants.PAGE_BEGIN;
        cubit.loadMoreRefresh = false;
        cubit.loadMoreLoading = true;
        cubit.loadMoreSink.add(cubit.loadMoreLoading);
        await callApi(cubit.loadMorePage);
      }
    }
  }

  Future<void> initData() async {
    if (isLoadMoreBottom) {
      cubit.loadMorePage = ApiConstants.PAGE_BEGIN;
      cubit.loadMoreRefresh = true;
      cubit.loadMoreLoading = true;
      await callApi(cubit.loadMorePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return BlocConsumer(
      bloc: cubit,
      listener: (ctx, state) {
        if (state is CompletedLoadMore) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.loadMoreRefresh ||
                cubit.loadMorePage == ApiConstants.PAGE_BEGIN) {
              cubit.loadMoreList.clear();
              if ((state.posts ?? []).isEmpty) {
                cubit.showEmpty();
              } else {
                cubit.showContent();
              }
            }
          } else {
            cubit.loadMoreList.clear();
            cubit.showError();
          }
          cubit.loadMoreList.addAll(state.posts ?? []);
          cubit.canLoadMore =
              (state.posts?.length ?? 0) >= ApiConstants.DEFAULT_PAGE_SIZE;
          cubit.loadMoreLoading = false;
          cubit.loadMoreSink.add(cubit.loadMoreLoading);
          cubit.loadMoreListController.add(cubit.loadMoreList);
        }
      },
      builder: (BuildContext context, Object? state) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (cubit.canLoadMore &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              loadMorePosts();
            }
            return true;
          },
          child: Stack(
            children: [
              StreamBuilder(
                stream: cubit.loadMoreListStream,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot,
                ) {
                  return viewItem;
                },
              ),
              Positioned(
                bottom: 5,
                right: 16,
                left: 16,
                child: StreamBuilder<bool>(
                  stream: cubit.loadMoreStream,
                  builder: (context, snapshot) {
                    return snapshot.data ?? false
                        ? LoadingItem()
                        : const SizedBox();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}