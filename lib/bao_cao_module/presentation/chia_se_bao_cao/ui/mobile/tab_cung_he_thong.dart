import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/danh_sach_nhom_cung_he_thong.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_chon_nhom.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/item_nguoi_dung.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/widgets/tree_bao_cao_chia_se.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog.dart';
import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
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
                      height: 45.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        border: Border.all(color: containerColorTab),
                      ),
                      child: Stack(
                        children: [
                          DropdownSearch<String>(
                            maxHeight: 250.h,
                            showSearchBox: true,
                            mode: Mode.MENU,
                            items: widget.cubit.listDropDown,
                            dropdownSearchDecoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: containerColorTab,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            dropdownBuilder: (context, value) {
                              return const SizedBox();
                            },
                            onChanged: (value) {
                              widget.cubit.themNhom(value ?? '');
                            },
                            emptyBuilder: (context, value) {
                              return Center(
                                child: Text(S.current.no_data),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text(
                                S.current.chon_nhom,
                                style: textNormalCustom(
                                  color: color3D5586,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                      return const SizedBox.shrink();
                    }
                  },
                ),
                spaceH24, // Stream list nhóm
                StreamBuilder<bool>(
                  stream: widget.cubit.showTree,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Column(
                        children: [
                          StreamBuilder<Object>(
                            stream: widget.cubit.selectDonVi,
                            builder: (context, snapshot) {
                              return Container(
                                width: 341.w,
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  bottom: 12.h,
                                  top: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: containerColorTab),
                                ),
                                child: Wrap(
                                  spacing: 10.w, // gap between adjacent chips
                                  runSpacing: 10.h, // gap between lines
                                  children: List.generate(
                                      widget.cubit.selectNode.length + 1,
                                      (index) {
                                    if (index ==
                                        widget.cubit.selectNode.length) {
                                      return Container(
                                        width: 200,
                                        color: Colors.transparent,
                                        child: TextField(
                                          onChanged: (value) {
                                            widget.cubit.onSearch(value);
                                          },
                                          controller: controller,
                                          style: textNormal(
                                            textTitle,
                                            14.0.textScale(),
                                          ),
                                          decoration: InputDecoration(
                                            hintText: S.current.tim_kiem,
                                            hintStyle: textNormal(
                                              textTitle,
                                              14.0.textScale(),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            isCollapsed: true,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      );
                                    }
                                    final data = widget.cubit.selectNode[index];
                                    return ItemNguoiDung(
                                      name: data.value.name != ''
                                          ? data.value.name
                                          : data.value.tenCanBo,
                                      hasFunction: true,
                                      delete: () {
                                        widget.cubit.addSelectNode(
                                          data,
                                          isCheck: false,
                                        );

                                        widget.cubit.removeTag(data);
                                      },
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: containerColorTab),
                            ),
                            child: StreamBuilder<List<Node<DonViModel>>>(
                              stream: widget.cubit.getTree,
                              builder: (context, snapshot) {
                                final data =
                                    snapshot.data ?? <Node<DonViModel>>[];
                                if (data.isNotEmpty) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 6.w,
                                      bottom: 19.h,
                                      top: 16.h,
                                    ),
                                    keyboardDismissBehavior: isMobile()
                                        ? ScrollViewKeyboardDismissBehavior
                                            .onDrag
                                        : ScrollViewKeyboardDismissBehavior
                                            .manual,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return TreeViewChiaSeBaoCaoWidget(
                                        themDonViCubit: widget.cubit,
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
                        ],
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          widget.cubit.showTree.add(true);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                          ),
                          height: 45.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.r),
                            ),
                            border: Border.all(color: containerColorTab),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.chon_nguoi,
                                style: textNormalCustom(
                                  color: color3D5586,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                size: 24,
                                color: color3D5586,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
        Container(
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
                  widget.cubit.chiaSeBaoCao(Share.COMMON).then((value) {
                    if (value == ChiaSeBaoCaoCubit.success) {
                      MessageConfig.show(title: value);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      MessageConfig.show(
                        title: value,
                        messState: MessState.error,
                      );
                    }
                  });
                },
                showTablet: true,
                textContent: S.current.chia_se_thu_muc_chac_chua,
              ).then((value) {});
            },
            noPadding: true,
          ),
        ),
      ],
    );
  }
}
