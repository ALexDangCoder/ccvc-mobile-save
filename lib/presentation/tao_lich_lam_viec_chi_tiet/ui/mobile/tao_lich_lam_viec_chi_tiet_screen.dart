import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
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
import 'package:ccvc_mobile/widgets/notify/notify_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return WidgetTaoLichLVInherited(
      taoLichLamViecCubit: taoLichLamViecCubit,
      child: Scaffold(
        appBar: BaseAppBar(
          title: S.current.tao_lich_cong_tac_trong_nuoc,
          leadingIcon: IconButton(
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
                  margin: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          icMargin: false,
                          onEndDateTimeChanged: (DateTime value) {
                            taoLichLamViecCubit.listeningEndDataTime(value);
                          },
                          onStartDateTimeChanged: (DateTime value) {
                            taoLichLamViecCubit.listeningStartDataTime(value);
                          },
                        ),
                        const NhacLaiWidget(),
                        NguoiChuTriWidget(
                          taoLichLamViecCubit: taoLichLamViecCubit,
                        ),
                        LinhVucWidget(
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
                        buttonTaoLich(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await taoLichLamViecCubit
                                  .taoLichLamViec(
                                title: tieuDeController.value.text,
                                content: noiDungController.value.text,
                                location: diaDiemController.value.text,
                              )
                                  .then((value) {
                                if (value.succeeded == true) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NotifyWidget(
                                        content: S.current
                                            .ban_da_tao_lich_lam_viec_thanh_cong,
                                        image: ImageAssets
                                            .icTaoLichLamViecThanhCong,
                                        textButtom: S.current.quay_lai,
                                      ),
                                    ),
                                    (Route<dynamic> route) => route.isFirst,
                                  ).then((value) {
                                    if (value) {
                                      Navigator.pop(context, true);
                                    } else {
                                      Navigator.pop(context, false);
                                    }
                                  });
                                } else {}
                              });
                            }
                          },
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
