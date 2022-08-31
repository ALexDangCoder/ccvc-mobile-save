import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/search_extention.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/tree_widget.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/textformfield/form_input_base.dart';
import 'package:ccvc_mobile/widgets/dialog/cupertino_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimKiemYcHoTroTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const TimKiemYcHoTroTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TimKiemYcHoTroTablet> createState() => _TimKiemYcHoTroTabletState();
}

class _TimKiemYcHoTroTabletState extends State<TimKiemYcHoTroTablet> {
  late ScrollController _controller;

  void closeKey() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void init() {
    _controller = ScrollController();
    _controller.addListener(() {
      widget.cubit.isShowDonVi.add(false);
    });
    widget.cubit.initSearch();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                cubit.isShowDonVi.add(false);
                closeKey();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowContainerColor.withOpacity(0.05),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 22,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textTitle(
                            S.current.tim_kiem,
                            fontWeight: FontWeight.w500,
                            size: 18,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              ImageAssets.icClose,
                              color:
                                  AppTheme.getInstance().unselectedLabelColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH10,
                    Flexible(
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StreamBuilder<List<CategoryModel>>(
                              stream: cubit.listTrangThai,
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
                                              initText: cubit.keyWord ?? '',
                                              isClose: true,
                                              onChange: (value) {
                                                cubit.onChangeTimKiem(value);
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.don_vi),
                                            spaceH8,
                                            GestureDetector(
                                              onTap: () =>
                                                  cubit.isShowDonVi.add(true),
                                              child: StreamBuilder<String>(
                                                stream: cubit.donViSearch,
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
                                              hintText: dtFormatUpperCase,
                                              value: DateTime.tryParse(
                                                cubit.createOn ?? '',
                                              ),
                                              onSelectDate: (dateTime) {
                                                cubit.onChangeNgayYeuCau(
                                                  dateTime,
                                                );
                                                setState(() {});
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
                                              hintText: dtFormatUpperCase,
                                              value: DateTime.tryParse(
                                                cubit.finishDay ?? '',
                                              ),
                                              onSelectDate: (dateTime) {
                                                cubit.onChangeNgayHoanThanh(
                                                  dateTime,
                                                );
                                                setState(() {});
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
                                                cubit.onChangeNguoiTiepNhan(
                                                  value,
                                                );
                                              },
                                              value: cubit.userRequestIdName,
                                              items: cubit
                                                  .getItemsNguoiTiepNhanYeuCau(),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.nguoi_xu_ly),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                cubit.onChangeNguoiXuLy(value);
                                              },
                                              value: cubit.handlerIdName,
                                              items: cubit.getItemsThanhVien(),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.khu_vuc),
                                            spaceH8,
                                            CustomDropDown(
                                              hint: _textTitle(
                                                S.current.chon,
                                              ),
                                              onSelectItem: (value) {
                                                cubit.onChangeKhuVuc(value);
                                              },
                                              value: cubit.districtIdName,
                                              items: cubit.getItemsKhuVuc(),
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.toa_nha),
                                            spaceH8,
                                            StreamBuilder<
                                                List<ChildCategories>>(
                                              stream: cubit.listToaNha,
                                              builder: (context, snapshot) {
                                                final List<String> listResult =
                                                    cubit.getItemsToaNha(
                                                  snapshot.data ?? [],
                                                );
                                                return CustomDropDown(
                                                  hint: _textTitle(
                                                    S.current.chon,
                                                  ),
                                                  onSelectItem: (value) {
                                                    cubit.onChangeToaNha(value);
                                                  },
                                                  value: cubit.buildingIdName,
                                                  items: listResult,
                                                );
                                              },
                                            ),
                                            spaceH16,
                                            _textTitle(S.current.so_phong),
                                            spaceH8,
                                            FormInputBase(
                                              hintText: S.current.so_phong,
                                              initText: cubit.room ?? '',
                                              isClose: true,
                                              onChange: (value) {
                                                cubit.onChangeRoom(value);
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
                                                cubit.onChangeTrangThaiXuLy(
                                                  value,
                                                );
                                              },
                                              value: cubit.processingCodeName,
                                              items: cubit.getItemsTrangThai(),
                                            ),
                                            spaceH4,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: _doubleBtn(context),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 50.0),
                                        child: Center(
                                          child: CupertinoLoading(),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
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
                stream: cubit.isShowDonVi,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? StreamBuilder<List<Node<DonViModel>>>(
                          stream: cubit.getTreeDonVi,
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
                                      themDonViCubit:
                                          widget.cubit.themDonViCubit,
                                      node: data[index],
                                      onSelect: (value) {
                                        cubit.onChangeDonVi(value);
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
        isTablet: true,
        onPressed1: () {
          Navigator.of(context).pop();
          widget.cubit.onCancelSearch();
        },
        title1: S.current.dong,
        title2: S.current.tim_kiem,
        onPressed2: () {
          Navigator.of(context).pop();
          widget.cubit.onSaveSearch();
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
