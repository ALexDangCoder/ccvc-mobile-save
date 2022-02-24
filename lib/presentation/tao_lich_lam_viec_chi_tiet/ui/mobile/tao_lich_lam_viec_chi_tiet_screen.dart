import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/search_name_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tao_lich_lam_viec_provider.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/text_form_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        body: TaoLichLamViecProvider(
          taoLichLamViecCubit: taoLichLamViecCubit,
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException('1', ''),
            stream: taoLichLamViecCubit.stateStream,
            child: RefreshIndicator(
              onRefresh: () async {
                await taoLichLamViecCubit.loadData();
              },
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
                          ),
                        ),
                        LoaiLichWidget(
                          taoLichLamViecCubit: taoLichLamViecCubit,
                        ),
                        const SearchNameWidget(),
                        StartEndDateWidget(
                          onEndDateTimeChanged: (DateTime value) {
                            print('$value ==========');
                          },
                          onStartDateTimeChanged: (DateTime value) {
                            print('$value ????????????');
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        const NhacLaiWidget(),
                        NguoiChuTriWidget(
                          taoLichLamViecCubit: taoLichLamViecCubit,
                        ),
                        LinhVucWidget(
                          taoLichLamViecCubit: taoLichLamViecCubit,
                        ),
                        TextFormWidget(
                          image: ImageAssets.icViTri,
                          hint: S.current.dia_diem,
                        ),
                        TextFormWidget(
                          image: ImageAssets.icDocument,
                          hint: S.current.noi_dung,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const ThanhPhanThamGiaTLWidget(),
                        const TaiLieuWidget(),
                        buttonTaoLich(
                          onTap: () {
                            if (taoLichLamViecCubit.checkValidateTime()) {
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: backgroundDrawerMenu,
                                  content: Text(
                                    S.current.vui_long_kiem_tra_lai_time,
                                    style: textNormalCustom(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                            taoLichLamViecCubit.taoLichLamViec(
                              title: 'tao6ddd',
                              typeScheduleId:
                                  'bfa0c6db-01c5-4836-bc13-4e41fd32108b',
                              linhVucId: 'aed033ae-3eba-4d7b-a2d4-28defdc20d0a',
                              TenTinh: '',
                              TenHuyen: '',
                              TenXa: '',
                              dateFrom: '2022-02-24',
                              timeFrom: '13:45',
                              dateTo: '2022-02-24',
                              timeTo: '15:45',
                              content: '',
                              location: 'assd',
                              vehicle: '',
                              expectedResults: '',
                              results: '',
                              status: 2,
                              rejectReason: '',
                              publishSchedule: false,
                              tags: '',
                              isLichDonVi: false,
                              canBoChuTriId:
                                  '19266143-feee-44d0-828a-e29df215f481',
                              donViId: '0bf3b2c3-76d7-4e05-a587-9165c3624d76',
                              note: '',
                              isAllDay: false,
                              isSendMail: true,
                              typeRemider: 1,
                              typeRepeat: 1,
                              dateRepeat: '2022-02-24',
                              dateRepeat1: '2022-02-24',
                              only: true,
                            );
                            if (tieuDeController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: backgroundDrawerMenu,
                                  content: Text(
                                    S.current.khong_duoc_de_trong,
                                    style: textNormalCustom(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
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
