import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_hdsd/ui/mobile/edit_hdsd_mobile.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/bloc/hoi_dap_cubit.dart';
import 'package:ccvc_mobile/presentation/hoi_dap/widget/custom_hoi_dap_widget.dart';
import 'package:ccvc_mobile/presentation/them_hdsd/ui/mobile/them_hdsd.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/dialog/dialog_utils.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoiDapScreen extends StatefulWidget {
  const HoiDapScreen({Key? key}) : super(key: key);

  @override
  _HoiDapScreenState createState() => _HoiDapScreenState();
}

class _HoiDapScreenState extends State<HoiDapScreen> {
  HoiDapCubit cubit = HoiDapCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.hoi_dap,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ImageAssets.icBack),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemHDSDScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.ic_Group.svgToTheme()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            const BaseSearchBar(),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.listHoiDap.length,
                itemBuilder: (context, index) {
                  return CustomHoiDapWidget(
                    tieuDe: cubit.listHoiDap[index].tieuDe ?? '',
                    chuDe: cubit.listHoiDap[index].chuDe ?? '',
                    loaiHDSD: cubit.listHoiDap[index].loaiHDSD ?? '',
                    onTapXoa: () {
                      DialogUtils.showDialogDelete(
                        context,
                        title: S.current.xoa_hdsd,
                        icon: SvgPicture.asset(ImageAssets.icXoaHDSD),
                        okBtnFunction: () {},
                      );
                    },
                    onTapEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHDSDScreen(
                            hoiDap: cubit.listHoiDap[index],
                            index: index,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            //  CustomHoiDapWidget(),
          ],
        ),
      ),
    );
  }
}
