import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/tim_kiem/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
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
  @override
  void initState() {
    widget.cubit.geiApiAddAndSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 750,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: SingleChildScrollView(
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
                StreamBuilder<List<CategoryModel>>(
                  stream: widget.cubit.listTrangThai,
                  builder: (context, snapshot) {
                    return snapshot.data?.isNotEmpty ?? false
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 22.5,
                              bottom: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.current.tim_kiem,
                                  style: p.textNormalCustom(
                                    color: textTitle,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                spaceH20,
                                _textFiled(
                                  isIcon: true,
                                  title: S.current.tim_kiem,
                                  funOnChange: (String value) {
                                    widget.cubit.keyWord = value;
                                  },
                                ),
                                spaceH16,
                                //todo   S.current.don_vi
                                spaceH16,
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: S.current.ngay_yeu_cau,
                                        style: tokenDetailAmount(
                                          fontSize: 14,
                                          color: color3D5586,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH8,
                                DateInput(
                                  paddings: 10,
                                  leadingIcon: SvgPicture.asset(
                                    image_utils.ImageAssets.icCalenders,
                                  ),
                                  onSelectDate: (dateTime) {
                                    widget.cubit.createOn = dateTime;
                                  },
                                  initDateTime: DateTime.tryParse(
                                      widget.cubit.createOn ?? ''),
                                ),
                                spaceH16,
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: S.current.ngay_hoan_thanh,
                                        style: tokenDetailAmount(
                                          fontSize: 14,
                                          color: color3D5586,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH8,
                                DateInput(
                                  paddings: 10,
                                  leadingIcon: SvgPicture.asset(
                                    image_utils.ImageAssets.icCalenders,
                                  ),
                                  onSelectDate: (dateTime) {
                                    widget.cubit.finishDay = dateTime;
                                  },
                                  initDateTime: DateTime.tryParse(
                                      widget.cubit.finishDay ?? ''),
                                ),
                                spaceH16,
                                _dropDownField(
                               //   checkLoad: true,
                                  title: S.current.nguoi_tiep_nhan_yeu_cau,
                                  listData: widget
                                      .cubit.listNguoiTiepNhanYeuCau.value
                                      .map((e) => e.hoVaTen ?? '')
                                      .toList(),
                                  function: (value) {
                                    widget.cubit.userRequestId = widget
                                        .cubit
                                        .listNguoiTiepNhanYeuCau
                                        .value[value]
                                        .userId;
                                  },
                                  initData: widget.cubit.userRequestId ?? '',
                                ),
                                spaceH16,
                                _dropDownField(
                                  title: S.current.nguoi_xu_ly,
                                  listData: widget.cubit.getListThanhVien(
                                    widget.cubit.listCanCoHTKT.value,
                                  ),
                                  function: (value) {
                                    widget.cubit.handlerId = widget.cubit
                                        .listCanCoHTKT.value[value].userId;
                                  },
                                  initData: widget.cubit.handlerId ?? '',
                                ),
                                spaceH16,
                                _dropDownField(
                                  title: S.current.khu_vuc,
                                  listData: widget.cubit.listKhuVuc.value
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  function: (value) {
                                    widget.cubit.listToaNha.add(
                                      widget.cubit.listKhuVuc.value[value]
                                              .childCategories ??
                                          [],
                                    );
                                    widget.cubit.districtId =
                                        widget.cubit.listKhuVuc.value[value].id;
                                  },
                                  initData: widget.cubit.districtId ?? '',
                                ),
                                spaceH16,
                                StreamBuilder<List<ChildCategories>>(
                                  stream: widget.cubit.listToaNha,
                                  builder: (context, snapshot) {
                                    final List<String> listResult = widget.cubit
                                        .getList(snapshot.data ?? []);
                                    return _dropDownField(
                                      checkLoad: true,
                                      title: S.current.toa_nha,
                                      listData: listResult,
                                      function: (value) {
                                        widget.cubit.buildingId = widget
                                            .cubit.listToaNha.value[value].id;
                                      },
                                      initData: widget.cubit.buildingId ?? '',
                                    );
                                  },
                                ),
                                spaceH16,
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: S.current.so_phong,
                                        style: tokenDetailAmount(
                                          fontSize: 14,
                                          color: color3D5586,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH16,
                                _textFiled(
                                  title: S.current.so_phong,
                                  funOnChange: (String value) {
                                    widget.cubit.room = value;
                                  },
                                ),
                                spaceH16,
                                _dropDownField(
                                  title: S.current.trang_thai_xu_ly,
                                  listData: widget.cubit.listTrangThai.value
                                      .map((e) => e.name ?? '')
                                      .toList(),
                                  function: (value) {
                                    widget.cubit.processingCode = widget
                                        .cubit.listTrangThai.value[value].code;
                                  },
                                  initData: widget.cubit.processingCode ?? '',
                                ),
                                spaceH20,
                                doubleBtn(context),
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
      ),
    );
  }

  Widget _dropDownField({
    // String? hintText,
    // int maxLine = 1,
    required String initData,
    bool checkLoad = false,
    required List<String> listData,
    required String title,
    required Function(int) function,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: color3D5586,
                ),
              ),
            ],
          ),
        ),
        spaceH8,
        CoolDropDown(
          placeHoder: S.current.chon,
          onChange: (value) => function(value),
          listData: listData,
          key: checkLoad ? UniqueKey() : null,
          initData: initData,
        )
      ],
    );
  }

  Widget _textFiled({
    required String title,
    bool isIcon = false,
    required Function(String value) funOnChange,
  }) =>
      TextField(
        style: tokenDetailAmount(
          fontSize: 14.0,
          color: color3D5586,
        ),
        decoration: InputDecoration(
          hintText: title,
          hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: isIcon
              ? Icon(
                  Icons.search,
                  color: AppTheme.getInstance().colorField(),
                )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        onChanged: (value) => funOnChange(value),
      );

  Widget doubleBtn(BuildContext context) => DoubleButtonBottom(
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
}
