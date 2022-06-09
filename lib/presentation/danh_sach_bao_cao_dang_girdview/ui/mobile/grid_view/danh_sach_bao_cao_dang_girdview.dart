import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/widget/item_gridview.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/list/widget/item_list.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/filter_bao_cao.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/item_chi_tiet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TypeLoai {
  THU_MUC,
  BAO_CAO,
}

class DanhSachBaoCaoDangGirdviewMobile extends StatefulWidget {
  const DanhSachBaoCaoDangGirdviewMobile({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangGirdviewMobileState createState() =>
      _DanhSachBaoCaoDangGirdviewMobileState();
}

class _DanhSachBaoCaoDangGirdviewMobileState
    extends State<DanhSachBaoCaoDangGirdviewMobile> {
  late DanhSachBaoCaoCubit cubit;

  @override
  void initState() {
    cubit = DanhSachBaoCaoCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarMobile(
        title: S.current.bac_cao,
        actions: [
          GestureDetector(
            onTap: () {
              //todo search anh hải
            },
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16),
              child: SvgPicture.asset(
                ImageAssets.icSearchPAKN,
                color: AppTheme.getInstance().unselectedLabelColor(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          //TODO
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => FilterBaoCao(
                          cubit: cubit,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        StreamBuilder<String>(
                          stream: cubit.textFilter,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data ?? '',
                              style: textNormalCustom(
                                fontSize: 14.0,
                                color: infoColor,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: SvgPicture.asset(
                            ImageAssets.icDropDown,
                            color:
                                AppTheme.getInstance().unselectedLabelColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cubit.isCheckList = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                          ),
                          child: SvgPicture.asset(
                            ImageAssets.icGridView,
                            color: cubit.isCheckList
                                ? AppTheme.getInstance().colorField()
                                : AppTheme.getInstance().unselectedLabelColor(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cubit.isCheckList = false;
                          });
                        },
                        child: SvgPicture.asset(
                          ImageAssets.icListHopMobile,
                          color: !cubit.isCheckList
                              ? AppTheme.getInstance().colorField()
                              : AppTheme.getInstance().unselectedLabelColor(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  top: 2,
                  bottom: 12,
                ),
                child: Text(
                  S.current.all,
                  style: textNormalCustom(
                    fontSize: 14.0,
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: cubit.isCheckList
                    ? GridView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 17,
                          childAspectRatio: 1.5,
                          mainAxisExtent: 130,
                        ),
                        itemCount: 16,
                        itemBuilder: (context, index) {
                          return ItemGridView();
                        },
                      )
                    : Container(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: ListView.builder(
                          itemCount: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ItemChiTiet(),
                                  ),
                                );
                              },
                              child: const ItemList(),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
