import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/custom_switch_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_dat_nuoc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lap_den_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap_tuy_chinh.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_quan_huyen_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_tinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_xa_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  bool timeValue = true;
  bool calValue = true;
  late DateTimeCupertinoCustomCubit calCubit;

  @override
  void initState() {
    super.initState();
    calCubit = DateTimeCupertinoCustomCubit();
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
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: APP_DEVICE == DeviceType.MOBILE
                ? backgroundColorApp
                : bgQLVBTablet,
            bottomOpacity: 0.0,
            elevation: APP_DEVICE == DeviceType.MOBILE ? 0 : 0.7,
            shadowColor: bgDropDown,
            automaticallyImplyLeading: false,
            title: Text(
              S.current.tao_lich_lam_viec,
              style: titleAppbar(fontSize: 24.0),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: colorA2AEBD,
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
                child: FormGroup(
                  key: _formKey,
                  child: ExpandGroup(
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
                              border: Border.all(
                                  color: borderColor.withOpacity(0.5)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.current.thong_tin_lich,
                                          style: textNormalCustom(
                                            color: textTitle,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextFormWidget(
                                          controller: tieuDeController,
                                          image: ImageAssets.icEdit,
                                          hint: S.current.tieu_de,
                                          validator: (value) {
                                            return (value ?? '')
                                                .validatorTitle();
                                          },
                                        ),
                                        LoaiLichWidget(
                                          taoLichLamViecCubit:
                                              taoLichLamViecCubit,
                                          callback: (bool value) {
                                            calValue = value;
                                          },
                                        ),
                                        CupertinoMaterialPicker(
                                          onSwitchPressed: (value) {
                                            taoLichLamViecCubit
                                                .isCheckAllDaySubject
                                                .add(value);
                                          },
                                          onDateTimeChanged: (
                                            String timeStart,
                                            String timeEnd,
                                            String dateStart,
                                            String dateEnd,
                                          ) {
                                            sendData(
                                              dateEnd,
                                              timeEnd,
                                              dateStart,
                                              timeEnd,
                                            );
                                          },
                                          validateTime: (String value) {
                                            timeValue = value.isNotEmpty;
                                          },
                                          cubit: calCubit,
                                        ),
                                        NhacLaiWidget(
                                          cubit:
                                              taoLichLamViecCubit,
                                        ),
                                        NguoiChuTriWidget(
                                          cubit:
                                              taoLichLamViecCubit,
                                        ),
                                        LinhVucWidget(
                                          cubit:
                                              taoLichLamViecCubit,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0, left: 30.0),
                                          child: CustomSwitchWidget(
                                            onToggle: (value) {
                                              taoLichLamViecCubit
                                                  .publishSchedule = value;
                                            },
                                            value: false,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 30.0),
                                          height: 16,
                                          child: const Divider(
                                            color: dividerColor,
                                            height: 1,
                                          ),
                                        ),
                                        //tinh
                                        StreamBuilder<bool>(
                                          stream: taoLichLamViecCubit
                                              .checkTrongNuoc,
                                          builder: (context, snapshot) {
                                            final data = snapshot.data ?? false;
                                            if (!data) {
                                              return Column(
                                                children: [
                                                  ItemTinhWidget(
                                                    taoLichLamViecCubit:
                                                        taoLichLamViecCubit,
                                                  ),
                                                  ItemHuyenWidget(
                                                    taoLichLamViecCubit:
                                                        taoLichLamViecCubit,
                                                  ),
                                                  ItemXaWidget(
                                                    taoLichLamViecCubit:
                                                        taoLichLamViecCubit,
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return ItemDatNuocWidget(
                                                cubit:
                                                    taoLichLamViecCubit,
                                              );
                                            }
                                          },
                                        ),
                                        TextFormWidget(
                                          controller: diaDiemController,
                                          image: ImageAssets.icViTri,
                                          hint: S.current.dia_diem,
                                          validator: (value) {
                                            return (value ?? '').checkNull();
                                          },
                                        ),
                                        LichLapWidget(
                                          cubit:
                                              taoLichLamViecCubit,
                                        ),
                                        StreamBuilder<bool>(
                                            stream: taoLichLamViecCubit
                                                .lichLapTuyChinhSubject.stream,
                                            builder: (context, snapshot) {
                                              final data =
                                                  snapshot.data ?? false;
                                              return data
                                                  ? LichLapTuyChinh(
                                                      taoLichLamViecCubit:
                                                          taoLichLamViecCubit,
                                                    )
                                                  : Container();
                                            }),
                                        StreamBuilder<bool>(
                                            stream: taoLichLamViecCubit
                                                .lichLapKhongLapLaiSubject
                                                .stream,
                                            builder: (context, snapshot) {
                                              final data =
                                                  snapshot.data ?? false;
                                              return data
                                                  ? ItemLapDenNgayWidget(
                                                      taoLichLamViecCubit:
                                                          taoLichLamViecCubit,
                                                      isThem: true,
                                                    )
                                                  : Container();
                                            }),
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
                                          taoLichLamViecCubit:
                                              taoLichLamViecCubit,
                                        ),
                                        TaiLieuWidget(),
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
                                  background: AppTheme.getInstance()
                                      .colorField()
                                      .withOpacity(0.1),
                                  textColor:
                                      AppTheme.getInstance().colorField(),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                buttomWidget(
                                  title: S.current.luu,
                                  background:
                                      AppTheme.getInstance().colorField(),
                                  textColor: Colors.white,
                                  onTap: () {
                                    validateField();
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
        ),
      ),
    );
  }

  Future<void> validateField() async {
    if (_formKey.currentState!.validate() && !timeValue && !calValue) {
      if (taoLichLamViecCubit.lichLapKhongLapLaiSubject.value) {
        await taoLichLamViecCubit.taoLichLamViec(
          title: tieuDeController.value.text.trim().replaceAll(' +', ' '),
          content: noiDungController.value.text.trim().replaceAll(' +', ' '),
          location: diaDiemController.value.text.trim().replaceAll(' +', ' '),
        );
      } else {
        await taoLichLamViecCubit.checkTrungLich(
          context: context,
          title: tieuDeController.value.text.trim().replaceAll(' +', ' '),
          content: noiDungController.value.text.trim().replaceAll(' +', ' '),
          location: diaDiemController.value.text.trim().replaceAll(' +', ' '),
        );
      }
    }
    if (timeValue) {
      calCubit.validateTime.sink.add(
        S.current.ban_phai_chon_thoi_gian,
      );
    }
    if (calValue) {
      taoLichLamViecCubit.checkCal.sink.add(true);
    }
  }

  void sendData(
    String dateEnd,
    String timeEnd,
    String dateStart,
    String timeStart,
  ) {
    taoLichLamViecCubit.checkValidateTime();
    taoLichLamViecCubit.listeningEndDataTime(
      DateTime.parse(
        timeFormat(
          '$dateEnd $timeEnd',
          DateTimeFormat.DATE_TIME_PICKER,
          DateTimeFormat.DATE_TIME_PUT,
        ),
      ),
    );
    taoLichLamViecCubit.listeningStartDataTime(
      DateTime.parse(
        timeFormat(
          '$dateStart $timeStart',
          DateTimeFormat.DATE_TIME_PICKER,
          DateTimeFormat.DATE_TIME_PUT,
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
