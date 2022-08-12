import 'package:ccvc_mobile/bao_cao_module/widget/dialog/show_dialog_date_picker.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/home_module/widgets/text_filed/follow_keyboard.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/row_info.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/them_can_bo_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CuCanBoWidget extends StatefulWidget {
  final ThanhPhanThamGiaCubit cubitThanhPhanTG;
  final ThemCanBoCubit themCanBoCubit;
  final DetailMeetCalenderCubit cubit;
  final ThemDonViCubit themDonViCubit;
  final bool isMobile;

  const CuCanBoWidget({
    Key? key,
    required this.themCanBoCubit,
    required this.cubitThanhPhanTG,
    required this.cubit,
    required this.themDonViCubit,
    this.isMobile = true,
  }) : super(key: key);

  @override
  _CuCanBoWidgetState createState() => _CuCanBoWidgetState();
}

class _CuCanBoWidgetState extends State<CuCanBoWidget> {
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();
  final List<DonViModel> dataInit = [];

  @override
  void initState() {
    super.initState();
    widget.cubitThanhPhanTG.isDuplicateCanBo.add(false);
    widget.cubitThanhPhanTG.listCanBoThamGia.add([]);
    widget.cubit.initDanhSachCuCanBo(widget.cubitThanhPhanTG);
    widget.themCanBoCubit.titleCanBo.sink.add('');
    widget.themDonViCubit.validateDonVi.sink.add(false);
    widget.themDonViCubit.themDonViSubject.sink.add(true);
    widget.cubitThanhPhanTG.nodeDonViThemCanBo = null;
    widget.themDonViCubit.sinkSelectOnlyDonVi.add(null);
    widget.cubitThanhPhanTG.listCanBo.clear();
    widget.themDonViCubit.listDonVi.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      stream: widget.cubit.stateStream,
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.luu,
              onClickLeft: () {
                Navigator.pop(context);
              },
              onClickRight: () async {
                widget.themDonViCubit.validateDonVi.sink.add(false);

                await widget.cubit
                    .luuCanBoDiThay(
                  cubitThanhPhanTG: widget.cubitThanhPhanTG,
                )
                    .then((value) {
                  if (value) {
                    widget.cubit.initDataChiTiet(needCheckPermission: true);
                    widget.themCanBoCubit.getCanbo.add([]);
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isMobile) ...[
                const SizedBox(
                  height: 20,
                ),
                lineContainer(),
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    S.current.cu_can_bo,
                    style: textNormalCustom(fontSize: 18, color: textTitle),
                  ),
                ),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ThemCanBoScreen(
                        cubit: widget.cubitThanhPhanTG,
                        needCheckTrung: false,
                        removeButton: true,
                        themCanBoCubit: widget.themCanBoCubit,
                        titleCanBo: S.current.can_bo,
                        hindSearch: S.current.tim_kiem_can_bo,
                        checkStyle: false,
                        checkUiCuCanBo: true,
                        themDonViCubit: widget.themDonViCubit,
                        hindText: S.current.chon_don_vi,
                      ),
                      spaceH20,
                      BlockTextViewLich(
                        isRequired: false,
                        hintText: S.current.chi_tiet_cong_viec_can_phoi_hop,
                        formKey: formKeyNoiDung,
                        contentController: noiDungController,
                        title: S.current.noi_dung,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 14),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.themDonViCubit.listDonVi.isEmpty) {
                              widget.themDonViCubit.validateDonVi.sink
                                  .add(true);
                            } else {
                              widget.themDonViCubit.validateDonVi.sink
                                  .add(false);

                              if ((widget.themCanBoCubit.titleCanBo
                                          .valueOrNull ??
                                      '')
                                  .isEmpty) {
                                widget.themDonViCubit.listDonVi.last.noidung =
                                    noiDungController.text;
                              } else {
                                widget.cubitThanhPhanTG.newCanBo.noidung =
                                    noiDungController.text;
                              }

                              widget.cubitThanhPhanTG.addCuCanBo(
                                widget.themCanBoCubit,
                                widget.themDonViCubit,
                              );
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(ImageAssets.ic_plus),
                                spaceW10,
                                Text(
                                  S.current.them,
                                  style: textNormalCustom(
                                    fontSize: 12.0,
                                    color: titleCalenderWork,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<bool>(
                        stream: widget.cubitThanhPhanTG.isDuplicateCanBo.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? false;

                          return data
                              ? Text(
                                  S.current.can_bo_nay_da_ton_tai,
                                  style: textNormalCustom(
                                    color: Colors.red,
                                    fontSize: 12.0.textScale(),
                                  ),
                                )
                              : Container();
                        },
                      ),
                      StreamBuilder<List<DonViModel>>(
                        stream: widget.cubitThanhPhanTG.listCanBoThamGia.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? <DonViModel>[];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              data.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0.textScale(space: -2),
                                ),
                                child: itemListCanBo(
                                  isVisible: index != 0,
                                  noiDungCV: data[index].noidung,
                                  cubit: widget.cubitThanhPhanTG,
                                  donVi: data[index],
                                  onDelete: () {
                                    widget.cubitThanhPhanTG
                                        .xoaCanBoThamGiaCuCanBo(
                                      data[index],
                                      widget.cubitThanhPhanTG.listCanBoDuocChon,
                                    );
                                    widget.themCanBoCubit.titleCanBo.sink
                                        .add('');
                                    widget.themDonViCubit.selectNodeOnlyValue =
                                        null;
                                    widget.themDonViCubit.themDonViSubject.sink
                                        .add(true);
                                    noiDungController.text = '';
                                    widget.themDonViCubit.sinkSelectOnlyDonVi
                                        .add(null);
                                    widget.themDonViCubit.listDonVi.clear();
                                  },
                                ),
                              ),
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
    );
  }

  Widget itemListCanBo({
    required DonViModel donVi,
    required ThanhPhanThamGiaCubit cubit,
    required String noiDungCV,
    required Function() onDelete,
    bool isVisible = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: borderButtomColor.withOpacity(0.1),
        border: Border.all(color: borderButtomColor),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              rowInfo(
                value: donVi.tenCoQuan,
                key: S.current.ten_don_vi,
                needShowPadding: true,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(value: donVi.tenCanBo, key: S.current.ten_can_bo),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: donVi.noidung,
                key: S.current.nd_cong_viec,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
            ],
          ),
          if (isVisible)
            Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onDelete();
                      },
                      child: SvgPicture.asset(ImageAssets.icDeleteRed),
                    ),
                  ],
                ))
          else
            Container(),
        ],
      ),
    );
  }
}
