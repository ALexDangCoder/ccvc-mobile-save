import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/list/widget/item_list.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/widget/item_chi_tiet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachBaoCaoDangGirdviewMobile extends StatefulWidget {
  const DanhSachBaoCaoDangGirdviewMobile({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangGirdviewMobileState createState() =>
      _DanhSachBaoCaoDangGirdviewMobileState();
}

class _DanhSachBaoCaoDangGirdviewMobileState
    extends State<DanhSachBaoCaoDangGirdviewMobile> {
  DanhSachBaoCaoCubit cubit = DanhSachBaoCaoCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarMobile(
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
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: SvgPicture.asset(ImageAssets.icGridView),
                  )
                : Container(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                    child: SvgPicture.asset(ImageAssets.icListHopMobile),
                  ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: cubit.isCheckList
              ? GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 17,
                    crossAxisSpacing: 17,
                    childAspectRatio: 1.5,
                    mainAxisExtent: 130,
                  ),
                  itemCount: 16,
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: backgroundColorApp,
                          border:
                              Border.all(color: borderColor.withOpacity(0.5)),
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
                                  const EdgeInsets.only(top: 24, bottom: 16),
                              child: Image.asset(ImageAssets.icGroundMobile),
                            ),
                            Text(
                              S.current.bac_cao,
                              style: textNormal(textTitle, 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
    );
  }
}
