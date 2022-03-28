import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/bloc/theo_doi_bai_viet_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/tablet/widgets/bai_viet_item_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';

class TheoDoiBaiVietTablet extends StatefulWidget {
  final int topic;

  const TheoDoiBaiVietTablet({Key? key, required this.topic}) : super(key: key);

  @override
  _TheoDoiBaiVietTabletState createState() => _TheoDoiBaiVietTabletState();
}

class _TheoDoiBaiVietTabletState extends State<TheoDoiBaiVietTablet> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController nhapLaiMatKhauController = TextEditingController();
  TheoDoiBaiVietCubit theoDoiBaiVietCubit = TheoDoiBaiVietCubit();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:bgManagerColor ,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0,left: 30.0,right: 30.0),
            child: Text(
              S.current.nhap_linK_bao_cao,
              style: textNormalCustom(
                fontSize: 14,
                color: titleColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: shadowContainerColor.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BaseSearchBar(
              hintText: S.current.nhap_link_,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListViewLoadMore(
              cubit: theoDoiBaiVietCubit,
              isListView: false,
              checkRatio: 0.9,
               crossAxisSpacing: 0.0,
              sinkWap: true,
              callApi: (page) => {
                callApi(
                  page,
                )
              },
              viewItem: (value, index) =>
                  itemBaiViet(value as BaiVietModel),
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
        ApiConstants.DEFAULT_PAGE_SIZE
    );
  }
  Widget itemBaiViet(BaiVietModel data){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: BaiVietItemTablet(
        baiVietModel: data,
      ),
    );
  }
}
