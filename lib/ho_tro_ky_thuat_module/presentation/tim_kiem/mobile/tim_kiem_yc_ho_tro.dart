import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/tim_kiem/widget/date_input.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart'
    as p;
import 'package:ccvc_mobile/utils/constants/image_asset.dart' as image_utils;
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
  String? ngayYeuCau;
  String? ngayHoanThanh;

  final Debouncer _debounce = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Padding(
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
                  search(),
                  spaceH16,
                  //todo donvi dropDownField(title: S.current.don_vi),
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
                    leadingIcon:
                        SvgPicture.asset(image_utils.ImageAssets.icCalenders),
                    onSelectDate: (dateTime) {
                      ngayYeuCau = dateTime;
                    },
                    initDateTime: DateTime.tryParse(ngayYeuCau ?? ''),
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
                    leadingIcon:
                        SvgPicture.asset(image_utils.ImageAssets.icCalenders),
                    onSelectDate: (dateTime) {
                      ngayHoanThanh = dateTime;
                    },
                    initDateTime: DateTime.tryParse(ngayHoanThanh ?? ''),
                  ),
                  spaceH16,
                  //listNguoiTiepNhanYeuCau
                  //todo  dropDownField(title: S.current.nguoi_tiep_nhan_yeu_cau),
                  dropDownField(
                    title: S.current.nguoi_tiep_nhan_yeu_cau,
                    initData: widget.cubit.listNguoiTiepNhanYeuCau.value.first
                            .hoVaTen ??
                        '',
                    listData: widget.cubit.listNguoiTiepNhanYeuCau.value
                        .map((e) => e.hoVaTen ?? '')
                        .toList(),
                    function: (value) {
                      //todo
                    },
                  ),
                  spaceH16,
                  dropDownField(
                    title: S.current.nguoi_xu_ly,
                    initData:
                        widget.cubit.listCanCoHTKT.value.first.tenThanhVien ??
                            '',
                    listData: widget.cubit
                        .getListThanhVien(widget.cubit.listCanCoHTKT.value),
                    function: (value) {
                      //todo
                    },
                  ),
                  spaceH16,
                  dropDownField(
                    title: S.current.khu_vuc,
                    initData: widget.cubit.listKhuVuc.value.first.name ?? '',
                    listData: widget.cubit.listKhuVuc.value
                        .map((e) => e.name ?? '')
                        .toList(),
                    function: (value) {
                      widget.cubit.listToaNha.add(
                        widget.cubit.listKhuVuc.value[value].childCategories ??
                            [],
                      );
                    },
                  ),
                  spaceH16,
                  StreamBuilder<List<ChildCategories>>(
                    stream: widget.cubit.listToaNha,
                    builder: (context, snapshot) {
                      final List<String> listResult =
                          widget.cubit.getList(snapshot.data ?? []);
                      final String initData = listResult.first;
                      return dropDownField(
                        title: S.current.toa_nha,
                        initData: initData,
                        listData: listResult,
                        function: (value) {
                          //todo
                        },
                      );
                    },
                  ),
                  spaceH16,
                  //todo  dropDownField(title: S.current.so_phong),
                  spaceH16,
                  dropDownField(
                    title: S.current.trang_thai_xu_ly,
                    initData: widget.cubit.listTrangThai.value.first.name ?? '',
                    listData: widget.cubit.listTrangThai.value
                        .map((e) => e.name ?? '')
                        .toList(),
                    function: (value) {
                      //todo
                    },
                  ),
                  spaceH20,
                  doubleBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dropDownField({
    String? hintText,
    int maxLine = 1,
    required String initData,
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
          initData: initData,
          placeHoder: S.current.chon,
          onChange: (value) => function(value),
          listData: listData,
          key: UniqueKey(),
        )
      ],
    );
  }

  Widget search() => TextField(
        style: tokenDetailAmount(
          fontSize: 14.0,
          color: color3D5586,
        ),
        decoration: InputDecoration(
          hintText: S.current.tim_kiem,
          hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.getInstance().colorField(),
          ),
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
        onChanged: (keySearch) {
          _debounce.run(() {
            setState(() {});
          });
        },
      );

  Widget doubleBtn() => DoubleButtonBottom(
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
