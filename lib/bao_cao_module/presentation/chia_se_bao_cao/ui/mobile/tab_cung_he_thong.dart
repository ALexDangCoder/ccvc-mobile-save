import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_chon_nhom.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_nguoi_dung.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TabCungHeThongMobile extends StatefulWidget {
  const TabCungHeThongMobile({Key? key, required this.cubit}) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;

  @override
  _TabCungHeThongMobileState createState() => _TabCungHeThongMobileState();
}

class _TabCungHeThongMobileState extends State<TabCungHeThongMobile> {
  final ThemDonViCubit _themDonViCubit = ThemDonViCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getTreeDonVi.listen((event) {
      _themDonViCubit.getTreeDonVi(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH24,
              StreamBuilder<String>(
                stream: widget.cubit.callAPI,
                builder: (context, snapshot) {
                  return Container(
                    height: 40.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(right: 15.w, left: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      border: Border.all(color: containerColorTab),
                    ),
                    child: Theme(
                      data: ThemeData(
                        hintColor: Colors.white24,
                        selectedRowColor: Colors.white24,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          buttonDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                          ),
                          items: widget.cubit.listDropDown.map((String model) {
                            return DropdownMenuItem(
                              value: model,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 32.w,
                                    height: 32.h,
                                    decoration: BoxDecoration(
                                      color: color4C6FFF.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      ImageAssets.img_company,
                                      height: 5.h,
                                      width: 5.w,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  spaceW5,
                                  Text(
                                    model,
                                    style: textNormal(
                                      color3D5586,
                                      14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            widget.cubit.themNhom(newValue ?? '');
                          },
                          dropdownMaxHeight: 200,
                          dropdownWidth:
                              MediaQuery.of(context).size.width - 32.w,
                          dropdownDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          scrollbarThickness: 0,
                          scrollbarAlwaysShow: false,
                          offset: Offset(-16.w, 0),
                          hint: Text(
                            S.current.chon_nhom,
                            style: textNormalCustom(
                              color: color3D5586,
                              fontSize: 14,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: colorA2AEBD,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              spaceH20,
              StreamBuilder<List<NhomCungHeThong>>(
                stream: widget.cubit.themNhomStream,
                builder: (context, snapshot) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    return SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, int index) {
                          return Column(
                            children: [
                              ChonNhomWidget(
                                item: snapshot.data![index],
                                delete: () {
                                  widget.cubit.xoaNhom(
                                    snapshot.data![index].tenNhom ?? '',
                                  );
                                },
                              ),
                              spaceH12,
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              spaceH24,
              Container(
                width: 341.w,
                padding: EdgeInsets.only(
                  left: 12.w,
                  bottom: 12.h,
                  top: 12.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: containerColorTab),
                ),
                child: StreamBuilder<Object>(
                  stream: _themDonViCubit.selectDonVi,
                  builder: (context, snapshot) {
                    return Wrap(
                      spacing: 10.w, // gap between adjacent chips
                      runSpacing: 10.h, // gap between lines
                      children: _themDonViCubit.selectNode
                          .map(
                            (e) => ItemNguoiDung(
                              name: e.value.name,
                              hasFunction: true,
                              delete: () {
                                _themDonViCubit.addSelectNode(
                                  e,
                                  isCheck: false,
                                );
                                _themDonViCubit.removeTag(e);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ), // Stream list nhóm
              Container(
                height: 300.h,
                decoration: BoxDecoration(
                  border: Border.all(color: containerColorTab),
                ),
                child: StreamBuilder<List<Node<DonViModel>>>(
                  stream: _themDonViCubit.getTree,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? <Node<DonViModel>>[];
                    if (data.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 6.w,
                          bottom: 19.h,
                          top: 16.h,
                        ),
                        keyboardDismissBehavior: isMobile()
                            ? ScrollViewKeyboardDismissBehavior.onDrag
                            : ScrollViewKeyboardDismissBehavior.manual,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return TreeViewWidget(
                            themDonViCubit: _themDonViCubit,
                            node: data[index],
                          );
                        },
                      );
                    }
                    return Column(
                      children: const [
                        NodataWidget(),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            height: 63.h,
            color: Colors.white,
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.chia_se,
              onPressed1: () {
                showDiaLog(
                  context,
                  title: S.current.xac_nhan,
                  btnLeftTxt: S.current.huy,
                  btnRightTxt: S.current.dong_y,
                  funcBtnRight: () {
                    Navigator.pop(context);
                    Navigator.pop(this.context);
                  },
                  showTablet: true,
                  textContent: S.current.xac_nhan_dong_pop_up,
                  icon: const SizedBox(),
                ).then((value) {});
              },
              onPressed2: () {
                showDiaLog(
                  context,
                  title: S.current.chia_se_thu_muc,
                  icon: SvgPicture.asset(
                    ImageAssets.ic_chia_se,
                  ),
                  btnLeftTxt: S.current.huy,
                  btnRightTxt: S.current.dong_y,
                  funcBtnRight: () {
                    /// chia sẽ cho thầy đi
                  },
                  showTablet: true,
                  textContent: S.current.chia_se_thu_muc_chac_chua,
                ).then((value) {});
              },
              noPadding: true,
            ),
          ),
        ),
      ],
    );
  }
}
