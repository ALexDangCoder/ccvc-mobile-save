import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/config/resources/color.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/bloc/ket_noi_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/widget/item_list_chung.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/widget/item_list_trong_nuoc.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/phone/ket_noi_menu.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/bloc/tao_su_kien_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/ui/phone/tao_su_kien_screen.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/app_constants.dart';
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
  TaoSuKienCubit taoSuKienCubit = TaoSuKienCubit();

  @override
  void initState() {
    super.initState();
    cubit = KetNoiCubit();
    taoSuKienCubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: cubit.dataCurrent?.title ?? S.current.chung,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBacks,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (taoSuKienCubit.listData.isNotEmpty) {
                DrawerSlide.navigatorSlide(
                  context: context,
                  screen: KetNoiMenu(
                    onChange: (value) {
                      cubit.dataCurrent = value;
                      setState(() {});
                    },
                    listData: taoSuKienCubit.listData,
                  ),
                  thenValue: (value) {},
                );
              }
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaoSuKienKetNoi(
                cubit: taoSuKienCubit,
              ),
            ),
          ).then((value) {
            if (value == true) {
              callApi(1);
            }
            return;
          });
        },
        child: SvgPicture.asset(ImageAssets.ic_vector),
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {
        callApi(page),
      },
      viewItem: (value, index) {
        if (cubit.dataCurrent?.id == ID_KET_NOI ||
            cubit.dataCurrent?.parentId == ID_KET_NOI) {
          try {
            return ItemListTrongNuoc(
              model: value as ItemTrongNuocModel,
            );
          } catch (e) {
            return const SizedBox();
          }
        } else {
          try {
            return ItemListChung(
              danhSachChungModel: value as DanhSachChungModel,
              index: index ?? 0,
            );
          } catch (e) {
            return const SizedBox();
          }
        }
      },
    );
  }

  void callApi(int page) {
    if (cubit.dataCurrent?.id == ID_KET_NOI ||
        cubit.dataCurrent?.parentId == ID_KET_NOI) {
      cubit.getDataTrongNuoc(
        page,
        cubit.dataCurrent?.code ?? '',
      );
    } else {
      cubit.getListCategory(
        page: page,
        category: cubit.dataCurrent?.id ?? '',
      );
    }
  }
}
