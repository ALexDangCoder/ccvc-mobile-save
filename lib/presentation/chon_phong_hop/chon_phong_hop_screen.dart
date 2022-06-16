import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/don_vi_con_phong_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/radio/radio_button.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/bloc/chon_phong_hoc_cubit.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/widgets/loai_phong_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chon_phong_hop/widgets/yeu_cau_them_thiet_bi_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ChonPhongHopScreen extends StatefulWidget {
  final Function(ChonPhongHopModel) onChange;
  final String? id;
  final String? dateFrom;
  final String? dateTo;

  const ChonPhongHopScreen({
    Key? key,
    required this.onChange,
    this.id,
    this.dateFrom,
    this.dateTo,
  }) : super(key: key);

  @override
  _ChonPhongHopWidgetState createState() => _ChonPhongHopWidgetState();
}

class _ChonPhongHopWidgetState extends State<ChonPhongHopScreen> {
  final ChonPhongHopCubit _cubit = ChonPhongHopCubit();

  @override
  void initState() {
    super.initState();
    // _cubit.getDonViConPhong(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      onTap: () {
        showBottomSheet();
      },
      text: S.current.chon_phong_hop,
      urlIcon: ImageAssets.icChonPhongHop,
    );
  }

  void showBottomSheet() {
    if (isMobile()) {
      showBottomSheetCustom<ChonPhongHopModel>(
        context,
        child: _ChonPhongHopScreen(
          chonPhongHopCubit: _cubit,
          from: widget.dateFrom ?? '',
          to: widget.dateTo ?? '',
        ),
        title: S.current.chon_phong_hop,
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
        }
      });
    } else {
      showDiaLogTablet<ChonPhongHopModel>(
        context,
        title: S.current.chon_phong_hop,
        child: _ChonPhongHopScreen(
          chonPhongHopCubit: _cubit,
          from: widget.dateFrom ?? '',
          to: widget.dateTo ?? '',
        ),
        isBottomShow: false,
        funcBtnOk: () {},
      ).then((value) {
        if (value != null) {
          widget.onChange(value);
        }
      });
    }
  }
}

class _ChonPhongHopScreen extends StatefulWidget {
  final ChonPhongHopCubit chonPhongHopCubit;
  final String from;
  final String to;

  const _ChonPhongHopScreen({
    Key? key,
    required this.chonPhongHopCubit,
    required this.from,
    required this.to,
  }) : super(key: key);

  @override
  __ChonPhongHopScreenState createState() => __ChonPhongHopScreenState();
}

class __ChonPhongHopScreenState extends State<_ChonPhongHopScreen> {
  final TextEditingController controller = TextEditingController();
  ThanhPhanThamGiaCubit cubit = ThanhPhanThamGiaCubit();
  final _key = GlobalKey<FormState>();
  int groupValue = -1;

  @override
  void initState() {
    super.initState();
    controller.text = widget.chonPhongHopCubit.phongHop.noiDungYeuCau ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      width: double.infinity,
      child: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        stream: widget.chonPhongHopCubit.stateStream,
        child: FollowKeyBoardWidget(
          bottomWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
            child: DoubleButtonBottom(
              isTablet: isMobile() == false,
              title1: S.current.dong,
              title2: S.current.xac_nhan,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                Navigator.pop(
                  context,
                  ChonPhongHopModel(
                    loaiPhongHopEnum: widget.chonPhongHopCubit.loaiPhongHopEnum,
                    listThietBi: widget.chonPhongHopCubit.listThietBi,
                    yeuCauKhac: controller.text,
                    phongHop: widget.chonPhongHopCubit.phongHop,
                  ),
                );
              },
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoaiPhongHopWidget(
                  initLoaiPhong: widget.chonPhongHopCubit.loaiPhongHopEnum,
                  onChange: (value) {
                    widget.chonPhongHopCubit.setLoaiPhongHop(value);
                    if (widget.chonPhongHopCubit.donViSelectedId.isNotEmpty) {
                      widget.chonPhongHopCubit.getPhongHop(
                        id: widget.chonPhongHopCubit.donViSelectedId,
                        from: widget.from,
                        to: widget.to,
                        isTTDH: widget.chonPhongHopCubit.loaiPhongHopEnum ==
                            LoaiPhongHopEnum.PHONG_TRUNG_TAM_DIEU_HANH,
                      );
                    }
                  },
                ),
                spaceH25,
                Text(
                  S.current.don_vi,
                  style: textNormal(titleItemEdit, 14),
                ),
                spaceH8,
                StreamBuilder<List<DonViConPhong>>(
                  stream: widget.chonPhongHopCubit.donViSubject,
                  builder: (context, snapshot) {
                    final listData = snapshot.data ?? [];
                    return CoolDropDown(
                      key: UniqueKey(),
                      onChange: (index) {
                        widget.chonPhongHopCubit.donViSelected =
                            listData[index].tenDonVi;
                        widget.chonPhongHopCubit.donViSelectedId =
                            listData[index].id;
                        widget.chonPhongHopCubit.getPhongHop(
                          id: listData[index].id,
                          from: widget.from,
                          to: widget.to,
                          isTTDH: widget.chonPhongHopCubit.loaiPhongHopEnum ==
                              LoaiPhongHopEnum.PHONG_TRUNG_TAM_DIEU_HANH,
                        );
                      },
                      useCustomHintColors: true,
                      listData: listData.map((e) => e.tenDonVi).toList(),
                      initData: widget.chonPhongHopCubit.donViSelected,
                      placeHoder: S.current.chon_don_vi,
                    );
                  },
                ),
                spaceH20,
                GestureDetector(
                  onTap: () {
                    widget.chonPhongHopCubit.isShowPhongHopSubject.add(
                      !widget.chonPhongHopCubit.isShowPhongHopSubject.value,
                    );
                  },
                  child: Text(
                    S.current.xem_truoc_phong_hop,
                    style: textNormal(bgButtonDropDown, 14).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                spaceH20,
                StreamBuilder<bool>(
                  stream: widget.chonPhongHopCubit.isShowPhongHopSubject,
                  builder: (context, snapshot) {
                    final bool isShow = snapshot.data ?? false;
                    return Visibility(
                      visible: isShow,
                      child: StreamBuilder<List<PhongHopModel>>(
                        stream: widget.chonPhongHopCubit.phongHopSubject,
                        builder: (context, snapshot) {
                          final listData = snapshot.data ?? [];
                          return listData.isNotEmpty ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listData.length,
                            itemBuilder: (_, index) => itemPhongHop(
                                phongHop: listData[index],
                                index: index,
                                groupValue: groupValue,
                                onChange: (index) {
                                  widget.chonPhongHopCubit.phongHop
                                    ..donViId = listData[index].donViDuyetId
                                    ..ten = listData[index].ten
                                    ..bitTTDH = listData[index].bit_TTDH
                                    ..phongHopId = listData[index].id;
                                  groupValue = index;
                                  setState(() {});
                                },),
                          ) : const NodataWidget();
                        },
                      ),
                    );
                  },
                ),
                spaceH20,
                YeuCauThemThietBiWidget(
                  chonPhongHopCubit: widget.chonPhongHopCubit,
                  onClose: () {},
                ),
                spaceH20,
                BlockTextView(
                  formKey: _key,
                  isRequired: false,
                  title: S.current.yeu_cau_de_chuan_bi_phong,
                  contentController: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemPhongHop({
  required PhongHopModel phongHop,
  required int index,
  required int groupValue,
  required Function(int) onChange,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: borderButtomColor.withOpacity(0.1),
      border: Border.all(color: borderButtomColor),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Column(
            children: [
              rowInfo(
                value: phongHop.ten,
                key: S.current.ten_phong,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: phongHop.sucChua.toString(),
                key: S.current.suc_chua,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: phongHop.diaChi,
                key: S.current.dia_diem,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      S.current.thiet_bi,
                      style: textNormal(infoColor, 14.0.textScale()),
                    ),
                  ),
                  spaceW8,
                  Expanded(
                    flex: 7,
                    child: phongHop.listThietBi.isEmpty
                        ? Text(
                            S.current.khong,
                            style: textNormal(
                              color3D5586,
                              14.0.textScale(),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              phongHop.listThietBi.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  '${phongHop.listThietBi[index].tenThietBi} '
                                  '(${phongHop.listThietBi[index].soLuong})',
                                  style: textNormal(
                                    titleItemEdit,
                                    14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: phongHop.trangThai == 0
                    ? S.current.phong_trong
                    : S.current.phong_ban,
                key: S.current.trang_thai,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: RadioButton<int>(
              onChange: (value) {
                onChange(value ?? -1);
              },
              value: index,
              groupValue: groupValue,
              useBlueColor: true,
            ),
          ),
        )
      ],
    ),
  );
}
