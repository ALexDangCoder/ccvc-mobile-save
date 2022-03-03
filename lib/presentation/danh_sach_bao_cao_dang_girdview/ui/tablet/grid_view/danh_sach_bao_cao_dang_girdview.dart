import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/widget/item_chi_tiet_tablet.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/tablet/list/widget/item_list_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachBaoCaoDangGirdviewTablet extends StatefulWidget {
  const DanhSachBaoCaoDangGirdviewTablet({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangGirdviewTabletState createState() =>
      _DanhSachBaoCaoDangGirdviewTabletState();
}

class _DanhSachBaoCaoDangGirdviewTabletState
    extends State<DanhSachBaoCaoDangGirdviewTablet> {
  DanhSachBaoCaoCubit cubit = DanhSachBaoCaoCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWidgets,
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgWidgets,
        title: S.current.bac_cao,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                cubit.isCheckList = !cubit.isCheckList;
              });
            },
            child: cubit.isCheckList
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 30, bottom: 16),
                    child: SvgPicture.asset(ImageAssets.icGridTablet),
                  )
                : Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 30, bottom: 16),
                    child: SvgPicture.asset(ImageAssets.icListHopTablet),
                  ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: cubit.isCheckList
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 28,
                    bottom: 28,
                  ),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    mainAxisExtent: 138,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ItemChiTietTablet(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: backgroundColorApp,
                          border: Border.all(
                            color: borderItemCalender.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 14),
                              child: Image.asset(ImageAssets.icMenuGridTablet),
                            ),
                            Text(
                              S.current.bac_cao,
                              style: textNormalCustom(
                                color: textTitle,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 28),
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
                              builder: (_) => const ItemChiTietTablet(),
                            ),
                          );
                        },
                        child: const ItemListTablet(),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
