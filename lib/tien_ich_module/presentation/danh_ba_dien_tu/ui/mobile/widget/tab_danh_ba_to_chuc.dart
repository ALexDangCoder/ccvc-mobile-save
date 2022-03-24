import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/config/resources/color.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/bloc/danh_ba_cubit_tree.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/tree_danh_ba.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/cell/cell_list_danh_ba_ca_nhan_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/cell/cell_list_danh_ba_to_chuc.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class DanhBaToChuc extends StatefulWidget {
  const DanhBaToChuc({Key? key}) : super(key: key);

  @override
  _DanhBaToChucState createState() => _DanhBaToChucState();
}

class _DanhBaToChucState extends State<DanhBaToChuc> {
  DanhBaDienTuCubit cubit = DanhBaDienTuCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final DanhBaCubitTree _cubit = DanhBaCubitTree();

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: BaseSearchBar(
                  hintText: S.current.tim_kiem_danh_ba,
                  onChange: (value) {
                    setState(() {});
                    cubit.search = value;
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    children: [
                      DanhBaWidget(
                        cubit: _cubit,
                        onChange: (value) {
                          setState(() {});
                          cubit.id = value.id;
                        },
                      ),
                      Expanded(child: _content()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgManagerColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 28, left: 30, right: 30),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: BaseSearchBar(
                hintText: S.current.tim_kiem_danh_ba,
                onChange: (value) {
                  setState(() {});
                  cubit.search = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
              width: 343,
              child: DanhBaWidget(
                cubit: _cubit,
                onChange: (value) {
                  setState(() {});
                  cubit.id = value.id;
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
                child: _contentTabLet(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      sinkWap: true,
      isListView: true,
      callApi: (page) => {cubit.pageIndex = page, cubit.callApiDanhBaToChuc()},
      viewItem: (value, index) => CellListDanhBaToChuc(
        item: value as ItemsToChuc,
        index: index ?? 0,
        cubit: cubit,
      ),
    );
  }

  Widget _contentTabLet() {
    return ListViewLoadMore(
      checkRatio: 1.5,
      cubit: cubit,
      isListView: false,
      callApi: (page) => {cubit.pageIndex = page, cubit.callApiDanhBaToChuc()},
      viewItem: (value, index) => CellListDanhBaToChucTablet(
        item: value as ItemsToChuc,
        index: index ?? 0,
        cubit: cubit,
      ),
    );
  }
}
