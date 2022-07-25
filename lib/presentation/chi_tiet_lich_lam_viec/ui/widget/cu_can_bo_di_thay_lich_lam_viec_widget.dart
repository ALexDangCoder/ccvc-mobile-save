import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_di_thay_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text_filed/follow_keyboard.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/block_text_view_lich.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
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

class CuCanBoDiThayLichLamViecWidget extends StatefulWidget {
  final ThanhPhanThamGiaCubit cubitThanhPhanTG;
  final ThemCanBoCubit themCanBoCubit;
  final ChiTietLichLamViecCubit cubit;
  final ThemDonViCubit themDonViCubit;

  const CuCanBoDiThayLichLamViecWidget({
    Key? key,
    required this.themCanBoCubit,
    required this.cubitThanhPhanTG,
    required this.cubit,
    required this.themDonViCubit,
  }) : super(key: key);

  @override
  _CuCanBoDiThayLichLamViecWidgetState createState() =>
      _CuCanBoDiThayLichLamViecWidgetState();
}

class _CuCanBoDiThayLichLamViecWidgetState
    extends State<CuCanBoDiThayLichLamViecWidget> {
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cubitThanhPhanTG.isDuplicateCanBo.add(false);
    widget.themCanBoCubit.titleCanBo.sink.add('');
    widget.themDonViCubit.validateDonVi.sink.add(false);
    widget.cubit.getDanhSachCuCanBoDiThay();
    widget.themDonViCubit.themDonViSubject.sink.add(true);
    widget.cubitThanhPhanTG.nodeDonViThemCanBo = null;
    widget.themDonViCubit.sinkSelectOnlyDonVi.add(null);
    widget.themDonViCubit.listDonVi.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.luu,
          onClickLeft: () {
            Navigator.pop(context);
          },
          onClickRight: ()  {
            if (widget.themDonViCubit.listDonVi.isEmpty) {
              widget.themDonViCubit.validateDonVi.sink.add(true);
            } else {
              widget.themDonViCubit.validateDonVi.sink.add(false);
               widget.cubit
                  .luuCanBoDiThay(
                cubitThanhPhanTG: widget.cubitThanhPhanTG,
              )
                  .then((value) {
                if (value) {
                  widget.cubit.loadApi( widget.cubit.idLichLamViec);
                  Navigator.pop(context);
                }
              });
            }
          },
        ),
      ),
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

                    widget.cubitThanhPhanTG.addCanBoThamGiaCuCanBo(
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
                  children: [
                    StreamBuilder<List<DonViModel>>(
                      stream: widget.cubit.listDonViModel,
                      builder: (context, snap) {
                        final datas = snap.data ?? <DonViModel>[];
                        return Column(
                          children: [
                            itemListCanBoFirst(
                              noiDungCV: widget.cubit.donViModel.noidung,
                              onDelete: () {},
                              tenCanBo: widget.cubit.donViModel.name,
                              tenDonvi: widget.cubit.donViModel.tenDonVi,
                            ),
                            ...List.generate(
                              datas.length,
                                  (index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0.textScale(space: -2),
                                ),
                                child: itemListCanBoFirst(
                                  noiDungCV: datas[index].noidung,
                                  onDelete: () {
                                    widget.cubit.xoaKhachMoiThamGia(
                                      datas[index],
                                    );
                                  },
                                  tenCanBo: datas[index].name,
                                  tenDonvi: datas[index].tenCoQuan,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    ...List.generate(
                      data.length,
                      (index) => Padding(
                        padding:
                            EdgeInsets.only(top: 20.0.textScale(space: -2)),
                        child: itemListCanBo(
                          noiDungCV: data[index].noidung,
                          cubit: widget.cubitThanhPhanTG,
                          donVi: data[index],
                          onDelete: () {
                            widget.cubitThanhPhanTG
                                .xoaCanBoThamGia(data[index]);
                            widget.themCanBoCubit.titleCanBo.sink.add('');
                            widget.cubitThanhPhanTG.nodeDonViThemCanBo = null;
                            widget.themDonViCubit.themDonViSubject.sink
                                .add(true);
                            noiDungController.text = '';
                            widget.themDonViCubit.sinkSelectOnlyDonVi.add(null);
                            widget.themDonViCubit.listDonVi.clear();
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemListCanBo({
    required DonViModel donVi,
    required ThanhPhanThamGiaCubit cubit,
    required String noiDungCV,
    required Function() onDelete,
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
                value: donVi.name,
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
            ),
          )
        ],
      ),
    );
  }

  Widget itemListCanBoFirst({
    required String tenCanBo,
    required String tenDonvi,
    required String noiDungCV,
    required Function() onDelete,
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
                value: tenDonvi,
                key: S.current.ten_don_vi,
                needShowPadding: true,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(value: tenCanBo, key: S.current.ten_can_bo),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
              rowInfo(
                value: noiDungCV,
                key: S.current.nd_cong_viec,
              ),
              SizedBox(
                height: 10.0.textScale(space: 10),
              ),
            ],
          ),
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
            ),
          )
        ],
      ),
    );
  }
}
