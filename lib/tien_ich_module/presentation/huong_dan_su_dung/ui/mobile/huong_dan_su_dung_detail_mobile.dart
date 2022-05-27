import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/huong_dan_su_dung/bloc/huong_dan_su_dung_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/provider_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class HuongDanSuDungDetailMobile extends StatefulWidget {
  final String title;
  final String id;

  const HuongDanSuDungDetailMobile({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<HuongDanSuDungDetailMobile> createState() =>
      _HuongDanSuDungDetailMobileState();
}

class _HuongDanSuDungDetailMobileState
    extends State<HuongDanSuDungDetailMobile> {
  late final HuongDanSuDungCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = HuongDanSuDungCubit();
    cubit.getDanhSachHDSDDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefaultBack(
        '${S.current.huong_dan_su_dung} ${widget.title}',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ExpandGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: BaseSearchBar(
                      hintText: S.current.tim_kiem_cau_hoi,
                      onChange: (value) async {
                        cubit.searchDanhSachDetail(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<List<DanhSachTitleHDSD>>(
                        stream: cubit.getDanhSachTitleDetailHDSDStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return data.isEmpty
                              ? const Center(
                                  child: NodataWidget(),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return ExpandOnlyWidget(
                                      onTap: () async {
                                        cubit.detailHuongDanSuDungSubject.sink
                                            .add(DetailHuongDanSuDung());
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
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              child: Text(
                                                data[index].title ?? '',
                                                style: textNormalCustom(
                                                  color: titleColumn,
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
                                          builder: (context, snapshot) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Html(
                                                  style: {
                                                    'body': Style(
                                                      color: titleColumn,
                                                      fontSize:
                                                          const FontSize(14.0),
                                                    ),
                                                  },
                                                  data: addDomainImage(
                                                    snapshot.data?.content ??
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
                                                        builder: (context) =>
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          S.current.ban_van_con_cau_hoi,
                          style: textNormalCustom(
                            fontSize: 16.0,
                            color: titleColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          S.current.neu_khong_the_tim_thay_cau_hoi,
                          style: textNormalCustom(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: dateColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemPhoneMail(
                              ImageAssets.icCallHDSD,
                              '(0251).3847292',
                              S.current.chung_toi_luon_san_sang_giup_do,
                              () {},
                            ),
                            itemPhoneMail(
                              ImageAssets.icMailHDSD,
                              'www.thanhhoa.gov.vn',
                              S.current.cach_tot_nhat_de_nhan_cau_tra_loi_nhanh,
                              () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemPhoneMail(
  final String url,
  final String title,
  final String content,
  final Function onTap,
) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 152,
      width: 162,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: backgroundColorApp,
        border: Border.all(color: borderColor.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: shadowContainerColor.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            url,
            width: 43,
            height: 43,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              title,
              style: textNormalCustom(
                fontSize: 12.0,
                color: titleColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              content,
              style: textNormalCustom(
                fontSize: 12.0,
                color: dateColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(url),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
