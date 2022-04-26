import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lap_den_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap_tuy_chinh.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_quan_huyen_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_tinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_xa_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/mau_mac_dinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TaoLichLamViecChiTietTablet extends StatefulWidget {
  const TaoLichLamViecChiTietTablet({Key? key}) : super(key: key);

  @override
  _TaoLichLamViecChiTietTabletState createState() =>
      _TaoLichLamViecChiTietTabletState();
}

class _TaoLichLamViecChiTietTabletState
    extends State<TaoLichLamViecChiTietTablet> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  final _formKey = GlobalKey<FormState>();
  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController diaDiemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taoLichLamViecCubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaoLichLamViecCubit, TaoLichLamViecState>(
      bloc: taoLichLamViecCubit,
      listener: (context, state) {
        if (state is CreateSuccess) {
          showDiaLog(
            context,
            showTablet: true,
            isOneButton: false,
            textContent: S.current.ban_da_tao_lich_lam_viec_thanh_cong,
            btnLeftTxt: S.current.dong,
            funcBtnRight: () {},
            title: S.current.ban_da_tao_lich_lam_viec_thanh_cong,
            btnRightTxt: S.current.dong,
            icon: SvgPicture.asset(ImageAssets.icTaoLichLamViecThanhCong),
          ).then((value) {
            if (value == null) {
              Navigator.pop(context, true);
            }
            if (value) {
              Navigator.pop(context, true);
            } else {
              Navigator.pop(context, false);
            }
          });
        } else {}
      },
      child: WidgetTaoLichLVInherited(
        taoLichLamViecCubit: taoLichLamViecCubit,
        child: Scaffold(
          backgroundColor: bgWidgets,
          appBar: BaseAppBar(
            title: S.current.tao_lich_cong_tac,
            leadingIcon: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: unselectLabelColor,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await taoLichLamViecCubit.loadData();
            },
            child: ProviderWidget<TaoLichLamViecCubit>(
              cubit: taoLichLamViecCubit,
              child: StateStreamLayout(
                textEmpty: S.current.khong_co_du_lieu,
                retry: () {},
                error: AppException(
                  S.current.error,
                  S.current.error,
                ),
                stream: taoLichLamViecCubit.stateStream,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                          vertical: 28,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: borderColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.current.thong_tin_lich,
                                      style: textNormalCustom(
                                        color: textTitle,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: TextFormWidget(
                                        controller: tieuDeController,
                                        image: ImageAssets.icEdit,
                                        hint: S.current.tieu_de,
                                        validator: (value) {
                                          return (value ?? '').checkNull();
                                        },
                                      ),
                                    ),
                                    LoaiLichWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    StartEndDateWidget(
                                      onEndDateTimeChanged: (DateTime value) {
                                        taoLichLamViecCubit
                                            .listeningEndDataTime(value);
                                      },
                                      onStartDateTimeChanged: (DateTime value) {
                                        taoLichLamViecCubit
                                            .listeningStartDataTime(value);
                                      },
                                      isCheck: (bool value) {},
                                    ),
                                    NhacLaiWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MauMacDinhWidget(
                                        taoLichLamViecCubit:
                                            taoLichLamViecCubit),
                                    NguoiChuTriWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    LinhVucWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    //tinh
                                    ItemTinhWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    ItemHuyenWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    ItemXaWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    TextFormWidget(
                                      controller: diaDiemController,
                                      image: ImageAssets.icViTri,
                                      hint: S.current.dia_diem,
                                    ),
                                    LichLapWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    StreamBuilder<bool>(
                                        stream: taoLichLamViecCubit.lichLapTuyChinhSubject.stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? false;
                                          return data ?  LichLapTuyChinh(
                                            taoLichLamViecCubit:taoLichLamViecCubit,
                                          ) : Container();
                                        }
                                    ),
                                    StreamBuilder<bool>(
                                        stream: taoLichLamViecCubit.lichLapKhongLapLaiSubject.stream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? false;
                                          return data ?  ItemLapDenNgayWidget(taoLichLamViecCubit:taoLichLamViecCubit, isThem: true ,) : Container();
                                        }
                                    ),
                                    TextFormWidget(
                                      controller: noiDungController,
                                      image: ImageAssets.icDocument,
                                      hint: S.current.noi_dung,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 14),
                                child: Column(
                                  children: [
                                    ThanhPhanThamGiaTLWidget(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    ),
                                    const TaiLieuWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buttomWidget(
                              title: S.current.dong,
                              background: bgTag,
                              textColor: labelColor,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            buttomWidget(
                              title: S.current.luu,
                              background: textDefault,
                              textColor: Colors.white,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await taoLichLamViecCubit.taoLichLamViec(
                                    title: tieuDeController.value.text,
                                    content: noiDungController.value.text,
                                    location: diaDiemController.value.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buttomWidget({
  required String title,
  required Color background,
  required Color textColor,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: textNormalCustom(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  );
}
