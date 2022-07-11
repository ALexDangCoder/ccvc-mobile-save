import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/tree_widget.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/form_input_base.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimKiemYcHoTro extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const TimKiemYcHoTro({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TimKiemYcHoTro> createState() => _TimKiemYcHoTroState();
}

class _TimKiemYcHoTroState extends State<TimKiemYcHoTro> {
  late ScrollController _controller;
  late ThemDonViCubit _themDonViCubit;

  void closeKey() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    _themDonViCubit = ThemDonViCubit();
    widget.cubit.geiApiAddAndSearch();
    _controller = ScrollController();
    _controller.addListener(() {
      widget.cubit.isShowDonVi.add(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                widget.cubit.isShowDonVi.add(false);
                closeKey();
              },
              child: Container(
                height: 750,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH20,
                    Center(
                      child: Container(
                        height: 6,
                        width: 48,
                        decoration: const BoxDecoration(
                          color: colorECEEF7,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 22,
                      ),
                      child: _textTitle(
                        S.current.tim_kiem,
                        fontWeight: FontWeight.w500,
                        size: 18,
                      ),
                    ),
                    spaceH10,
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StreamBuilder<List<CategoryModel>>(
                              stream: widget.cubit.listTrangThai,
                              builder: (context, snapshot) {
                                return snapshot.data?.isNotEmpty ?? false
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            spaceH10,
                                            FormInputBase(
                                              icon: ImageAssets.icSearchColor,
                                              hintText: S.current
                                                  .nhap_tu_khoa_tim_kiem,
                                              initText:
                                                  widget.cubit.keyWord ?? '',
                                              isClose: true,
                                              onChange: (value) {
                                                widget.cubit.keyWord = value;
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.don_vi),
                                            spaceH8,
                                            GestureDetector(
                                              onTap: () => widget
                                                  .cubit.isShowDonVi
                                                  .add(true),
                                              child: StreamBuilder<String>(
                                                stream:
                                                    widget.cubit.donViSearch,
                                                builder: (context, snapshot) {
                                                  final textDonVi =
                                                      snapshot.data ?? '';
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          colorNumberCellQLVB,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        6,
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            borderItemCalender,
                                                      ),
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                      right: 4,
                                                    ),
                                                    height: 48,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          textDonVi,
                                                          style:
                                                              tokenDetailAmount(
                                                            fontSize: 14,
                                                            color: color3D5586,
                                                          ),
                                                        ),
                                                        SvgPicture.asset(
                                                          ImageAssets
                                                              .ic_drop_down,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.ngay_yeu_cau),
                                            spaceH8,
                                            CustomSelectDate(
                                              leadingIcon: SvgPicture.asset(
                                                ImageAssets.icCalenders,
                                              ),
                                              hintText: 'DD/MM/YYYY',
                                              value: DateTime.tryParse(
                                                widget.cubit.createOn ?? '',
                                              ),
                                              onSelectDate: (dateTime) {
                                                widget.cubit.createOn =
                                                    dateTime.toString();
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(
                                              S.current.ngay_hoan_thanh,
                                            ),
                                            spaceH8,
                                            CustomSelectDate(
                                              leadingIcon: SvgPicture.asset(
                                                ImageAssets.icCalenders,
                                              ),
                                              hintText: 'DD/MM/YYYY',
                                              value: DateTime.tryParse(
                                                widget.cubit.finishDay ?? '',
                                              ),
                                              onSelectDate: (dateTime) {
                                                widget.cubit.finishDay =
                                                    dateTime.toString();
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(
                                              S.current.nguoi_tiep_nhan_yeu_cau,
                                            ),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                widget.cubit.userRequestId =
                                                    widget
                                                        .cubit
                                                        .listNguoiTiepNhanYeuCau
                                                        .value[value]
                                                        .userId;
                                                widget.cubit.userRequestIdName =
                                                    widget
                                                        .cubit
                                                        .listNguoiTiepNhanYeuCau
                                                        .value[value]
                                                        .hoVaTen;
                                              },
                                              value: widget
                                                  .cubit.userRequestIdName,
                                              items: widget.cubit
                                                  .listNguoiTiepNhanYeuCau.value
                                                  .map((e) => e.hoVaTen ?? '')
                                                  .toList(),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.nguoi_xu_ly),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                widget.cubit.handlerId = widget
                                                    .cubit
                                                    .listCanCoHTKT
                                                    .value[value]
                                                    .userId;
                                                widget.cubit.handlerIdName =
                                                    widget.cubit
                                                        .getListThanhVien(
                                                  widget.cubit.listCanCoHTKT
                                                      .value,
                                                )[value];
                                              },
                                              value: widget.cubit.handlerIdName,
                                              items:
                                                  widget.cubit.getListThanhVien(
                                                widget
                                                    .cubit.listCanCoHTKT.value,
                                              ),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.khu_vuc),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                widget.cubit.listToaNha.add(
                                                  widget
                                                          .cubit
                                                          .listKhuVuc
                                                          .value[value]
                                                          .childCategories ??
                                                      [],
                                                );
                                                widget.cubit.districtId = widget
                                                    .cubit
                                                    .listKhuVuc
                                                    .value[value]
                                                    .id;
                                                widget.cubit.districtIdName =
                                                    widget.cubit.listKhuVuc
                                                        .value[value].name;
                                              },
                                              value:
                                                  widget.cubit.districtIdName,
                                              items: widget
                                                  .cubit.listKhuVuc.value
                                                  .map((e) => e.name ?? '')
                                                  .toList(),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.toa_nha),
                                            spaceH8,
                                            StreamBuilder<
                                                List<ChildCategories>>(
                                              stream: widget.cubit.listToaNha,
                                              builder: (context, snapshot) {
                                                final List<String> listResult =
                                                    widget.cubit.getList(
                                                  snapshot.data ?? [],
                                                );
                                                return CustomDropDown(
                                                  hint: _textTitle(
                                                    S.current.chon,
                                                  ),
                                                  onSelectItem: (value) {
                                                    widget.cubit.buildingId =
                                                        widget.cubit.listToaNha
                                                            .value[value].id;
                                                    widget.cubit
                                                            .buildingIdName =
                                                        widget.cubit.listToaNha
                                                            .value[value].name;
                                                  },
                                                  value: widget
                                                      .cubit.buildingIdName,
                                                  items: listResult,
                                                );
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.so_phong),
                                            spaceH8,
                                            FormInputBase(
                                              hintText: S.current.so_phong,
                                              initText: widget.cubit.room ?? '',
                                              textInputType:
                                                  TextInputType.number,
                                              isClose: true,
                                              onChange: (value) {
                                                widget.cubit.room = value;
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(
                                              S.current.trang_thai_xu_ly,
                                            ),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                widget.cubit.processingCode =
                                                    widget.cubit.listTrangThai
                                                        .value[value].code;
                                                widget.cubit
                                                        .processingCodeName =
                                                    widget.cubit.listTrangThai
                                                        .value[value].name;
                                              },
                                              value: widget
                                                  .cubit.processingCodeName,
                                              items: widget
                                                  .cubit.listTrangThai.value
                                                  .map((e) => e.name ?? '')
                                                  .toList(),
                                            ),
                                            spaceH4,
                                          ],
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(top: 180.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _doubleBtn(context),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 170,
              right: 16,
              left: 16,
              child: StreamBuilder<bool>(
                stream: widget.cubit.isShowDonVi,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? StreamBuilder<List<Node<DonViModel>>>(
                          stream: widget.cubit.getTreeDonVi,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? <Node<DonViModel>>[];
                            if (data.isNotEmpty) {
                              return Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  color: colorNumberCellQLVB,
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ),
                                  border: Border.all(
                                    color: borderItemCalender,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 6,
                                    bottom: 19,
                                    top: 16,
                                  ),
                                  keyboardDismissBehavior: isMobile()
                                      ? ScrollViewKeyboardDismissBehavior.onDrag
                                      : ScrollViewKeyboardDismissBehavior
                                          .manual,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return TreeViewWidget(
                                      selectOnly: true,
                                      themDonViCubit: _themDonViCubit,
                                      node: data[index],
                                      onSelect: (v) {
                                        widget.cubit.isShowDonVi.add(false);
                                        widget.cubit.codeUnit = v.id;
                                        widget.cubit.donViSearch.add(
                                          v.name,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doubleBtn(BuildContext context) => DoubleButtonBottom(
        onPressed1: () {
          Navigator.of(context).pop();
        },
        title1: S.current.dong,
        title2: S.current.tim_kiem,
        onPressed2: () {
          Navigator.of(context).pop();
          widget.cubit.getListDanhBaCaNhan(
            page: 1,
          );
        },
      );

  Widget _textTitle(
    String title, {
    FontWeight fontWeight = FontWeight.w400,
    double size = 14,
  }) =>
      Text(
        title,
        style: textNormalCustom(
          fontSize: size,
          color: AppTheme.getInstance().titleColor(),
          fontWeight: fontWeight,
        ),
      );
}
