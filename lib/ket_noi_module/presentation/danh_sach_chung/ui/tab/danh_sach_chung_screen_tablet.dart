import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/bloc/ket_noi_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/widget/item_list_chung.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/danh_sach_chung/widget/item_list_trong_nuoc.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/menu/ui/tab/ket_noi_menu_tablet.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/bloc/tao_su_kien_cubit.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/tao_su_kien/ui/phone/tao_su_kien_screen.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachChungScreenTablet extends StatefulWidget {
  const DanhSachChungScreenTablet({Key? key}) : super(key: key);

  @override
  _DanhSachChungScreenTabletState createState() =>
      _DanhSachChungScreenTabletState();
}

class _DanhSachChungScreenTabletState extends State<DanhSachChungScreenTablet> {
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
      backgroundColor: bgWidgets,
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
            icon: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SvgPicture.asset(
                ImageAssets.ic_plus,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (taoSuKienCubit.listData.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KetNoiMenuTablet(
                      onChange: (value) {
                        cubit.dataCurrent = value;
                        setState(() {});
                      },
                      listData: taoSuKienCubit.listData,
                    ),
                  ),
                );
              }
            },
            icon: SvgPicture.asset(
              ImageAssets.ic_mennu_ykien,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: _content(),
            ),
          )
        ],
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: false,
      checkRatio: 1,
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
