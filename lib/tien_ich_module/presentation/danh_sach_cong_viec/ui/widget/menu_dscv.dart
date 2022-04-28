import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/widget/container_menu_bao_chi.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/menu_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/extension.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/cell_menu_custom.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/container_menu_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/ui/widget/theo_dang_lich_widget_dscv.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuDSCV extends StatefulWidget {
  final DanhSachCongViecTienIchCubit cubit;

  const MenuDSCV({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<MenuDSCV> createState() => _MenuDSCVState();
}

class _MenuDSCVState extends State<MenuDSCV> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 58,
            ),
            headerWidget(menu: S.current.danh_sach_cong_viec),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  StreamBuilder<int>(
                    initialData: 0,
                    stream: widget.cubit.statusDSCV.stream,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.cubit.vlMenuDf.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final vl = widget.cubit.vlMenuDf[index];
                          return TheoDangLichWidgetDSCV(
                            icon: vl.icon ?? '',
                            name: vl.title ?? '',
                            onTap: () {
                              widget.cubit.titleAppBar.add(vl.title ?? '');
                              widget.cubit.statusDSCV.sink.add(index);
                              widget.cubit.addValueToTypeDSCV(index);
                              Navigator.pop(context);
                            },
                            isSelect: index == snapshot.data,
                            number: vl.number ?? 0,
                          );
                        },
                      );
                    },
                  ),
                  SingleChildScrollView(
                    child: ContainerMenuDSCVWidget(
                      name: S.current.nhom_cong_viec_moi,
                      icon: ImageAssets.ic_nhomCVMoi,
                      type: TypeContainer.expand,
                      childExpand: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.cubit.listKey.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final vl =
                              widget.cubit.mapData[widget.cubit.listKey[index]];
                          return TheoDangLichWidgetDSCV(
                            icon: '',
                            name: vl?.label ?? '',
                            onTap: () {
                              widget.cubit.titleAppBar.add(vl?.label ?? '');
                              // NamLV
                              widget.cubit.createView(vl?.items ?? []);
                              // widget.cubit.getListNhomCVMoi(vl?.items.first.groupId ?? '',);

                              widget.cubit.statusDSCV.sink.add(5);
                              Navigator.pop(context);
                            },
                            isSelect: false,
                            number: vl?.items.length ?? 0,
                          );
                        },
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      tabletScreen: Scaffold(
        backgroundColor: bgTabletColor,
        appBar: BaseAppBar(
          backGroundColor: bgTabletColor,
          title: S.current.danh_sach_cong_viec,
          leadingIcon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              ImageAssets.icClose,
            ),
          ),
        ),
        body: StreamBuilder<List<bool>>(
          builder: (context, snapshot) {
            return Column(
              children: [
                CellMenuCustom(
                  icon: ImageAssets.ic01,
                  name: S.current.cong_viec_cua_ban,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[0] ?? true,
                  number: 0,
                ),
                CellMenuCustom(
                  icon: ImageAssets.ic02,
                  name: S.current.cong_viec_quan_trong,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[1] ?? true,
                  number: 0,
                ),
                CellMenuCustom(
                  icon: ImageAssets.ic03,
                  name: S.current.da_hoan_thanh,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[2] ?? true,
                  number: 0,
                ),
                CellMenuCustom(
                  icon: ImageAssets.ic04,
                  name: S.current.gan_cho_toi,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[3] ?? true,
                  number: 0,
                ),
                CellMenuCustom(
                  icon: ImageAssets.ic05,
                  name: S.current.da_bi_xoa,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[4] ?? true,
                  number: 0,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ContainerMenuDSCVWidget(
                      name: S.current.nhom_cong_viec_moi,
                      icon: ImageAssets.ic06,
                      type: TypeContainer.expand,
                      childExpand: StreamBuilder<List<NhomCVMoiModel>>(
                        stream: widget.cubit.nhomCVMoiSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          if (data.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final vl = data[index];
                                return ContainerMenuDSCVWidget(
                                  icon: '',
                                  name: vl.label,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(ImageAssets.icDocument),
        const SizedBox(
          width: 12,
        ),
        Text(
          menu,
          style: textNormalCustom(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
