import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/ket_noi_item_model.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/bloc/ket_noi_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/widget/item_list_chung.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/phone/ket_noi_menu.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/drawer_slide/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachChungScreen extends StatefulWidget {
  const DanhSachChungScreen({Key? key}) : super(key: key);

  @override
  _DanhSachChungScreenState createState() => _DanhSachChungScreenState();
}

class _DanhSachChungScreenState extends State<DanhSachChungScreen> {
  late final KetNoiCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = KetNoiCubit();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TypeKetNoiMenu>(
      stream: cubit.streamTypeKetNoiMenu,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: BaseAppBar(
            title:
                snapshot.data?.getTitle() ?? TypeKetNoiMenu.SuKien.getTitle(),
            leadingIcon: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: SvgPicture.asset(
                ImageAssets.icBacks,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  DrawerSlide.navigatorSlide(
                    context: context,
                    screen: KetNoiMenu(
                      cubit: cubit,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  ImageAssets.ic_mennu_ykien,
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: _content(),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: labelColor,
            onPressed: () {},
            child: SvgPicture.asset(ImageAssets.ic_vector),
          ),
        );
      },
    );
  }

  void callApi(int page) {
    cubit.getListChungKetNoi(
      pageSize: cubit.pageSize,
      pageIndex: page,
      type: cubit.type,
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {callApi(page)},
      viewItem: (value, index) => ItemListChung(
        danhSachChungModel: value as DanhSachChungModel,
      ),
    );
  }
}
