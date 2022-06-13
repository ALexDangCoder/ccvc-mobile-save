import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/cell/cell_list_ca_nhan.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/ui/them_danh_ba_ca_nhan.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class DanhBaCaNhan extends StatefulWidget {
  const DanhBaCaNhan({Key? key}) : super(key: key);

  @override
  _DanhBaCaNhanState createState() => _DanhBaCaNhanState();
}

class _DanhBaCaNhanState extends State<DanhBaCaNhan> {
  late DanhBaDienTuCubit cubit;

  @override
  void initState() {
    cubit = DanhBaDienTuCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseSearchBar(
                hintText: S.current.tim_kiem_danh_ba,
                onChange: (value) {
                  cubit.debouncer.run(() {
                    cubit.searchValue = value.trim();
                    cubit.searchListDanhSach(cubit.searchValue);
                  });
                },
              ),
              spaceH20,
              SizedBox(
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    showBottomSheetCustom(
                      context,
                      title: S.current.them_danh_ba_ca_nhan,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ThemDanhBaCaNhan(
                          cubit: cubit,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(ImageAssets.icThemMoi),
                      spaceW16,
                      Text(
                        S.current.them_moi,
                        style:
                            tokenDetailAmount(fontSize: 16, color: color3D5586),
                      )
                    ],
                  ),
                ),
              ),
              spaceH30,
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _content(),
                ),
              )
            ],
          ),
        ),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgManagerColor,
        body: Container(
          padding: const EdgeInsets.only(top: 28, left: 30, right: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseSearchBar(
                hintText: S.current.tim_kiem_danh_ba,
                onChange: (value) {
                  cubit.debouncer.run(() {
                    cubit.searchValue = value.trim();
                    cubit.searchListDanhSach(cubit.searchValue);
                  });
                },
              ),
              spaceH20,
              GestureDetector(
                onTap: () {
                  showDiaLogTablet(
                    context,
                    optinalHeight: 844,
                    title: S.current.them_danh_ba_ca_nhan,
                    isBottomShow: false,
                    child: ThemDanhBaCaNhan(
                      cubit: cubit,
                    ),
                    funcBtnOk: () {},
                  );
                },
                child: Row(
                  children: [
                    Image.asset(ImageAssets.icThemMoi),
                    spaceW16,
                    Text(
                      S.current.them_moi,
                      style:
                          tokenDetailAmount(fontSize: 16, color: color3D5586),
                    )
                  ],
                ),
              ),
              spaceH20,
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _content(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      sinkWap: true,
      isListView: true,
      callApi: (page) =>
          {cubit.pageIndex = page, cubit.searchListDanhSach(cubit.searchValue)},
      viewItem: (value, index) => CellListCaNhan(
        item: value as Items,
        index: index ?? 0,
        cubit: cubit,
      ),
    );
  }
}
