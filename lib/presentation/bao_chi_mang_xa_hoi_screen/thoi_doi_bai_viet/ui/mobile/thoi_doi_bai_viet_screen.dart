import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/mobile/widgets/bai_viet_item.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class TheoDoiBaiVietScreen extends StatefulWidget {
  final int topic;

  const TheoDoiBaiVietScreen({Key? key, required this.topic}) : super(key: key);

  @override
  _TheoDoiBaiVietScreenState createState() => _TheoDoiBaiVietScreenState();
}

class _TheoDoiBaiVietScreenState extends State<TheoDoiBaiVietScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController nhapLaiMatKhauController = TextEditingController();
  TheoDoiBaiVietCubit theoDoiBaiVietCubit = TheoDoiBaiVietCubit();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
            child: Text(
              S.current.nhap_linK_bao_cao,
              style: textNormalCustom(
                fontSize: 14,
                color: color667793,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BaseSearchBar(
              hintText: S.current.nhap_link,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.current.bai_theo_doi,
              style: textNormalCustom(
                color: color3D5586,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListViewLoadMore(
              cubit: theoDoiBaiVietCubit,
              isListView: true,
              callApi: (page) => {
                callApi(
                  page,
                )
              },
              viewItem: (value, index) => itemBaiViet(value as BaiVietModel),
            ),
          ),
        ],
      ),
    );
  }

  void callApi(int page) {
    theoDoiBaiVietCubit.getListBaiVietTheoDoi(
        theoDoiBaiVietCubit.endDate,
        theoDoiBaiVietCubit.startDate,
        widget.topic,
        page,
        ApiConstants.DEFAULT_PAGE_SIZE);
  }

  Widget itemBaiViet(BaiVietModel data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BaiVietItem(
        baiVietModel: data,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
