import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/topic_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/bloc/huong_dan_su_dung_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/ui/mobile/huong_dan_su_dung_detail_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/ui/widget/item_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HuongDanSuDungMobile extends StatefulWidget {
  const HuongDanSuDungMobile({Key? key}) : super(key: key);

  @override
  _HuongDanSuDungMobileState createState() => _HuongDanSuDungMobileState();
}

class _HuongDanSuDungMobileState extends State<HuongDanSuDungMobile> {
  late HuongDanSuDungCubit cubit;

  @override
  void initState() {
    cubit = HuongDanSuDungCubit();
    cubit.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.huong_dan_su_dung,
      ),
      body: ProviderWidget<HuongDanSuDungCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          child: StreamBuilder<bool>(
              stream: cubit.selectSearchStream,
              builder: (context, snapshot) {
                final selectData = snapshot.data ?? false;
                return ExpandGroup(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BaseSearchBar(
                          hintText: S.current.tim_kiem_cau_hoi,
                          onChange: (value) {
                            cubit.searchAllDanhSach(value);
                            if (value.isNotEmpty || value == null) {
                              cubit.setSelectSearch(true);
                            } else {
                              cubit.setSelectSearch(false);
                            }
                          },
                        ),
                      ),
                      if (!selectData)
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await cubit.loadData();
                            },
                            child: Center(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: StreamBuilder<List<TopicHDSD>>(
                                  stream: cubit.getTopicHDSDStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    if (data.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          childAspectRatio: 1.25,
                                          children: List.generate(data.length,
                                              (index) {
                                            return ItemHuongDanSuDung(
                                              url: data[index].toIcon(),
                                              title: '${data[index].title}',
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HuongDanSuDungDetailMobile(
                                                      title:
                                                          data[index].title ??
                                                              '',
                                                      id: data[index].id ?? '',
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: NodataWidget(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await cubit.loadData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              child: SingleChildScrollView(
                                child: StreamBuilder<List<DanhSachTitleHDSD>>(
                                  stream: cubit.getDanhSachTitleHDSDStream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? [];
                                    return data.isEmpty
                                        ? const Center(
                                            child: NodataWidget(),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return ExpandOnlyWidget(
                                                onTap: () async {
                                                  cubit
                                                      .detailHuongDanSuDungSubject
                                                      .sink
                                                      .add(
                                                          DetailHuongDanSuDung());
                                                  await cubit
                                                      .getDetailDanhSachHuongDanSuDung(
                                                    data[index].id ?? '',
                                                  );
                                                },
                                                header: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 10,
                                                        ),
                                                        child: Text(
                                                          data[index].title ??
                                                              '',
                                                          style:
                                                              textNormalCustom(
                                                            color: color667793,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: StreamBuilder<
                                                        DetailHuongDanSuDung>(
                                                    stream: cubit
                                                        .getDetailHuongDanSuDungStream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Html(
                                                            style: {
                                                              'body': Style(
                                                                color:
                                                                    color667793,
                                                                fontSize:
                                                                    const FontSize(
                                                                  14.0,
                                                                ),
                                                              ),
                                                            },
                                                            data:
                                                                addDomainImage(
                                                              snapshot.data
                                                                      ?.content ??
                                                                  '',
                                                            ),
                                                            onImageTap: (
                                                              url,
                                                              contexts,
                                                              attributes,
                                                              element,
                                                            ) =>
                                                                {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          FullScreenImageViewer(
                                                                    url ?? '',
                                                                  ),
                                                                ),
                                                              ),
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              );
                                            },
                                          );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },),
        ),
      ),
    );
  }
}
