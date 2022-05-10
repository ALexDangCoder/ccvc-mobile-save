import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
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
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/mau_mac_dinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/notify/notify_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaoLichLamViecChiTietScreen extends StatefulWidget {
  const TaoLichLamViecChiTietScreen({Key? key}) : super(key: key);

  @override
  _TaoLichLamViecChiTietScreenState createState() =>
      _TaoLichLamViecChiTietScreenState();
}

class _TaoLichLamViecChiTietScreenState
    extends State<TaoLichLamViecChiTietScreen> {
  final TaoLichLamViecCubit taoLichLamViecCubit = TaoLichLamViecCubit();
  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController diaDiemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    taoLichLamViecCubit.loadData();
    taoLichLamViecCubit.toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaoLichLamViecCubit, TaoLichLamViecState>(
      bloc: taoLichLamViecCubit,
      listener: (context, state) {
        if (state is CreateSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NotifyWidget(
                content: S.current.ban_da_tao_lich_lam_viec_thanh_cong,
                image: ImageAssets.icTaoLichLamViecThanhCong,
                textButtom: S.current.quay_lai,
              ),
            ),
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
            title: StreamBuilder<String>(
                initialData: S.current.lich_cong_tac_trong_nuoc,
                stream: taoLichLamViecCubit.changeOption,
                builder: (context, snapshot) {
                  return Text(
                    '${S.current.tao} ${snapshot.data}',
                    style: titleAppbar(fontSize: 18.0),
                  );
                }),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: unselectLabelColor,
                size: 18,
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
                child: ExpandGroup(
                  child: Container(
                    margin: const EdgeInsets.only(
                        bottom: 16.0, left: 16.0, right: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: StreamBuilder<String>(
                                initialData: S.current.lich_cong_tac_trong_nuoc,
                                stream: taoLichLamViecCubit.changeOption,
                                builder: (context, snapshot) {
                                  return TextFormWidget(
                                    controller: tieuDeController,
                                    image: ImageAssets.icEdit,
                                    hint:
                                        '${S.current.tieu_de} ${snapshot.data}',
                                    validator: (value) {
                                      return (value ?? '').checkNull();
                                    },
                                  );
                                }),
                          ),
                          LoaiLichWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          StartEndDateWidget(
                            icMargin: false,
                            onEndDateTimeChanged: (DateTime value) {
                              taoLichLamViecCubit.listeningEndDataTime(value);
                            },
                            onStartDateTimeChanged: (DateTime value) {
                              taoLichLamViecCubit.listeningStartDataTime(value);
                            },
                            isCheck: (bool value) {
                              taoLichLamViecCubit.isCheckAllDaySubject
                                  .add(value);
                            },
                          ),
                          NhacLaiWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MauMacDinhWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NguoiChuTriWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          LinhVucWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          //cong khai lich
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, left: 30.0),
                            child: CustomSwitchWidget(
                              onToggle: (value) {
                                taoLichLamViecCubit.publishSchedule = value;
                              },
                              value: false,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30.0),
                            height: 16,
                            child: const Divider(
                              color: dividerColor,
                              height: 1,
                            ),
                          ),
                          StreamBuilder<bool>(
                              stream: taoLichLamViecCubit.checkTrongNuoc,
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
                                    taoLichLamViecCubit: taoLichLamViecCubit,
                                  );
                                }
                              }),
                          TextFormWidget(
                            controller: diaDiemController,
                            image: ImageAssets.icViTri,
                            hint: S.current.dia_diem,
                          ),
                          LichLapWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          StreamBuilder<bool>(
                            stream: taoLichLamViecCubit
                                .lichLapTuyChinhSubject.stream,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? false;
                              return data
                                  ? LichLapTuyChinh(
                                      taoLichLamViecCubit: taoLichLamViecCubit,
                                    )
                                  : Container();
                            },
                          ),
                          StreamBuilder<bool>(
                              stream: taoLichLamViecCubit
                                  .lichLapKhongLapLaiSubject.stream,
                              builder: (context, snapshot) {
                                final data = snapshot.data ?? false;
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
                          const SizedBox(
                            height: 20,
                          ),
                          ThanhPhanThamGiaTLWidget(
                            taoLichLamViecCubit: taoLichLamViecCubit,
                          ),
                          const TaiLieuWidget(),
                          Row(
                            children: [
                              Expanded(
                                child: buttomWidget(
                                  background: buttonColor.withOpacity(0.1),
                                  title: S.current.dong,
                                  onTap: () {},
                                  textColor: buttonColor,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: buttomWidget(
                                  background: buttonColor,
                                  title: S.current.luu,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // await taoLichLamViecCubit.taoLichLamViec(
                                      //   title: tieuDeController.value.text,
                                      //   content: noiDungController.value.text,
                                      //   location: diaDiemController.value.text,
                                      // );
                                      await taoLichLamViecCubit.checkTrungLich(
                                        context: context,
                                        title: tieuDeController.value.text,
                                        content: noiDungController.value.text,
                                        location: diaDiemController.value.text,
                                      );
                                    }
                                  },
                                  textColor: Colors.white,
                                ),
                              ),
                            ],
                          )
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
}

class WidgetTaoLichLVInherited extends InheritedWidget {
  final TaoLichLamViecCubit taoLichLamViecCubit;

  const WidgetTaoLichLVInherited({
    Key? key,
    required this.taoLichLamViecCubit,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static WidgetTaoLichLVInherited of(BuildContext context) {
    final WidgetTaoLichLVInherited? result =
        context.dependOnInheritedWidgetOfExactType<WidgetTaoLichLVInherited>();
    assert(result != null, 'No elenment');
    return result!;
  }
}

Widget buttonTaoLich({required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(top: 33, bottom: 10),
      color: textDefault,
      alignment: Alignment.center,
      width: double.maxFinite,
      child: Text(
        S.current.tao_lich_lam_viec,
        style: textNormalCustom(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  );
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
