import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/tree_danh_ba.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/cell/cell_list_danh_ba_to_chuc.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:flutter/material.dart';

class DanhBaToChuc extends StatefulWidget {
  const DanhBaToChuc({Key? key}) : super(key: key);

  @override
  _DanhBaToChucState createState() => _DanhBaToChucState();
}

class _DanhBaToChucState extends State<DanhBaToChuc> {
  DanhBaDienTuCubit cubit = DanhBaDienTuCubit();
  String keySearch = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: _content(),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgManagerColor,
        body: _content(),
      ),
    );
  }

  Widget _content() {
    return ComplexLoadMore(
      titleNoData: S.current.khong_co_du_lieu,
      isTitle: false,
      viewItem: (value, index) => CellListDanhBaToChuc(
        item: value as ItemsToChuc,
        index: index ?? 0,
        cubit: cubit,
      ),
      cubit: cubit,
      checkRatio: 1.5,
      isListView: isMobile() ? true : false,
      callApi: (page) => {
        cubit.pageIndex = page,
        if (cubit.listTreeDanhBa.isEmpty)
          cubit.getTree(soCap: 2).then(
                (value) => cubit.callApiDanhBaToChuc(id: ''),
              )
        else
          cubit.callApiDanhBaToChuc(
            keyWork: keySearch,
            id: cubit.id,
          )
      },
      childrenView: [
        Container(
          padding: isMobile()
              ? const EdgeInsets.only(top: 16, left: 16, right: 16)
              : const EdgeInsets.only(top: 28, left: 30, right: 30),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: searchBar(),
        ),
        Container(
          width: isMobile() ? MediaQuery.of(context).size.width : 343,
          padding: isMobile()
              ? null
              : const EdgeInsets.only(top: 10, left: 14, right: 14),
          child: danhBaWidget(),
        ),
      ],
    );
  }

  Widget searchBar() => BaseSearchBar(
        hintText: S.current.tim_kiem_danh_ba,
        onChange: (value) {
          keySearch = value;
          if (value.isNotEmpty) {
            cubit.waitToDelay(
              actionNeedDelay: () {
                cubit.callApiDanhBaToChuc(
                  keyWork: value,
                  pageIndexApi: 1,
                );
              },
              timeSecond: 1,
            );
          }
        },
      );

  Widget danhBaWidget() => DanhBaWidget(
        cubit: cubit,
        onChange: (value) {
          cubit.callApiDanhBaToChuc(
            pageIndexApi: 1,
            id: value.id,
          );
          cubit.id = value.id;
        },
      );
}
