import 'dart:developer';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ComplexLoadMore extends StatelessWidget {
  final BaseCubit<dynamic> cubit;
  final Function(int page) callApi;
  final List<Widget> childrenView;
  final Widget Function(dynamic, int?) viewItem;
  final bool isListView;
  final double? checkRatio;
  final double? crossAxisSpacing;
  final bool? shrinkWap;

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
  }) : super(key: key);

  Future<void> refreshPosts() async {
    if (!cubit.loadMoreLoading) {
      cubit.loadMorePage = ApiConstants.PAGE_BEGIN;
      cubit.loadMoreRefresh = true;
      cubit.loadMoreLoading = true;
      await callApi(cubit.loadMorePage);
    }
  }

  Future<void> loadMorePosts() async {
    if (!cubit.loadMoreLoading) {
      cubit.loadMorePage += ApiConstants.PAGE_BEGIN;
      cubit.loadMoreRefresh = false;
      cubit.loadMoreLoading = true;
      cubit.loadMoreSink.add(cubit.loadMoreLoading);
      await callApi(cubit.loadMorePage);
    }
  }

  Future<void> initData() async {
    cubit.loadMorePage = ApiConstants.PAGE_BEGIN;
    cubit.loadMoreRefresh = true;
    cubit.loadMoreLoading = true;
    await callApi(cubit.loadMorePage);
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
        return StateStreamLayout(
          retry: () {
            refreshPosts();
          },
          error: AppException(
            S.current.error,
            S.current.something_went_wrong,
          ),
          textEmpty: S.current.list_empty,
          stream: cubit.stateStream,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (cubit.canLoadMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                loadMorePosts();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: refreshPosts,
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: cubit.loadMoreListStream,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot,
                    ) {
                      if (isListView == true) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ...childrenView,
                              Row(
                                mainAxisAlignment:
                                (snapshot.data?.length ?? 0) > 0
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 16.0),
                                    child: Text(
                                      S.current.danh_sach_nhiem_vu,
                                      style: textNormalCustom(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: textDropDownColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if ((snapshot.data?.length ?? 0) > 0)
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder: (ctx, index) {
                                    return viewItem(
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
                                        S.current.khong_co_thong_tin_nhiem_vu,
                                        style: textNormalCustom(
                                            fontSize: 16.0, color: grayChart),
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
                        return GridView.builder(
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
                            crossAxisSpacing: crossAxisSpacing ?? 28,
                            childAspectRatio: checkRatio ?? 2 / 3,
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return viewItem(snapshot.data![index], index);
                          },
                        );
                      }
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
            ),
          ),
        );
      },
    );
  }
}
