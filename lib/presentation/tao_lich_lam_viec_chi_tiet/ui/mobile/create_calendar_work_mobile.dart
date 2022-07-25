import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_state.dart';
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
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/notify/notify_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCalendarWorkMobile extends StatefulWidget {
  const CreateCalendarWorkMobile({Key? key}) : super(key: key);

  @override
  _CreateCalendarWorkMobileState createState() =>
      _CreateCalendarWorkMobileState();
}

class _CreateCalendarWorkMobileState extends State<CreateCalendarWorkMobile> {
  final CreateWorkCalCubit createCubit = CreateWorkCalCubit();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final _formKey = GlobalKey<FormGroupState>();
  bool pickTimeValidatorValue = true;
  bool chooseTypeCalendarValidatorValue = true;
  bool chooseFileValidatorValue = true;
  late DateTimeCupertinoCustomCubit cupertinoCubit;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cupertinoCubit = DateTimeCupertinoCustomCubit();
    createCubit.loadData();
    createCubit.toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateWorkCalCubit, CreateWorkCalState>(
      bloc: createCubit,
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
        }
      },
      child: CreateWorkCalendarProvide(
        taoLichLamViecCubit: createCubit,
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
            title: Text(
              S.current.tao_lich_cong_tac,
              style: titleAppbar(),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: colorA2AEBD,
                size: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: createCubit.stateStream,
            child: FormGroup(
              scrollController: scrollController,
              key: _formKey,
              child: ExpandGroup(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormWidget(
                          controller: titleController,
                          image: ImageAssets.icEdit,
                          hint: S.current.nhap_tieu_de,
                          validator: (value) {
                            return (value ?? '').pleaseEnter(S.current.tieu_de);
                          },
                        ),
                        LoaiLichWidget(
                          taoLichLamViecCubit: createCubit,
                          callback: (bool value) {
                            chooseTypeCalendarValidatorValue = value;
                          },
                        ),
                        CupertinoMaterialPicker(
                          cubit: cupertinoCubit,
                          onSwitchPressed: (value) {
                            createCubit.isCheckAllDaySubject.add(value);
                          },
                          onDateTimeChanged: (
                            String timeStart,
                            String timeEnd,
                            String dateStart,
                            String dateEnd,
                          ) {
                            createCubit.checkValidateTime();
                            if (timeEnd != INIT_TIME_PICK &&
                                dateEnd != INIT_DATE_PICK) {
                              createCubit.listeningEndDataTime(
                                DateTime.parse(
                                  timeFormat(
                                    '$dateEnd $timeEnd',
                                    DateTimeFormat.DATE_TIME_PICKER,
                                    DateTimeFormat.DATE_TIME_PUT,
                                  ),
                                ),
                              );
                            }

                            if (timeStart != INIT_TIME_PICK &&
                                dateStart != INIT_DATE_PICK) {
                              createCubit.listeningStartDataTime(
                                DateTime.parse(
                                  timeFormat(
                                    '$dateStart $timeStart',
                                    DateTimeFormat.DATE_TIME_PICKER,
                                    DateTimeFormat.DATE_TIME_PUT,
                                  ),
                                ),
                              );
                            }
                          },
                          validateTime: (String value) {
                            pickTimeValidatorValue = value.isNotEmpty;
                          },
                        ),
                        NhacLaiWidget(
                          cubit: createCubit,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        NguoiChuTriWidget(
                          cubit: createCubit,
                        ),
                        LinhVucWidget(
                          cubit: createCubit,
                        ),
                        //cong khai lich
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 30.0),
                          child: CustomSwitchWidget(
                            onToggle: (value) {
                              createCubit.publishSchedule = value;
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
                          stream: createCubit.checkTrongNuoc,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? false;
                            if (!data) {
                              return Column(
                                children: [
                                  ItemTinhWidget(
                                    taoLichLamViecCubit: createCubit,
                                  ),
                                  ItemHuyenWidget(
                                    taoLichLamViecCubit: createCubit,
                                  ),
                                  ItemXaWidget(
                                    taoLichLamViecCubit: createCubit,
                                  ),
                                ],
                              );
                            } else {
                              return ItemDatNuocWidget(
                                cubit: createCubit,
                              );
                            }
                          },
                        ),
                        TextFormWidget(
                          controller: locationController,
                          image: ImageAssets.icViTri,
                          hint: S.current.nhap_dia_diem,
                          validator: (value) {
                            return (value ?? '')
                                .pleaseEnter(S.current.dia_diem);
                          },
                        ),
                        LichLapWidget(
                          cubit: createCubit,
                        ),
                        StreamBuilder<bool>(
                          stream: createCubit.lichLapTuyChinhSubject.stream,
                          builder: (context, snapshot) {
                            final _now = DateTime.now().weekday == 7
                                ? 0
                                : DateTime.now().weekday;
                            createCubit.days = _now.toString();
                            final data = snapshot.data ?? false;
                            return data
                                ? LichLapTuyChinh(
                                    taoLichLamViecCubit: createCubit,
                                  )
                                : Container();
                          },
                        ),
                        StreamBuilder<bool>(
                          stream: createCubit.lichLapKhongLapLaiSubject.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? false;
                            return data
                                ? StreamBuilder<DateTime>(
                                    stream: createCubit.endDateSubject.stream,
                                    builder: (context, snapshot) {
                                      final initDate =
                                          snapshot.data ?? DateTime.now();
                                      return ItemLapDenNgayWidget(
                                        createCubit: createCubit,
                                        createWorkCalendar: true,
                                        initDate: initDate,
                                        key: UniqueKey(),
                                      );
                                    },
                                  )
                                : Container();
                          },
                        ),
                        TextFormWidget(
                          controller: contentController,
                          image: ImageAssets.icDocument,
                          hint: S.current.noi_dung,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ThanhPhanThamGiaTLWidget(
                          taoLichLamViecCubit: createCubit,
                        ),
                        TaiLieuWidget(
                          onChange: (files, value) {
                            if (!value) {
                              createCubit.filesTaoLich = files;
                              chooseFileValidatorValue = !value;
                            } else {
                              chooseFileValidatorValue = !value;
                            }
                          },
                          idRemove: (String id) {},
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: bottomButtonWidget(
                                background: AppTheme.getInstance()
                                    .colorField()
                                    .withOpacity(0.1),
                                title: S.current.dong,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                textColor: AppTheme.getInstance().colorField(),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: bottomButtonWidget(
                                background: AppTheme.getInstance().colorField(),
                                title: S.current.luu,
                                onTap: () {
                                  validateField();
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
    );
  }

  Future<void> validateField() async {
    _formKey.currentState!.validator();
    if (_formKey.currentState!.validator() &&
        !pickTimeValidatorValue &&
        !chooseTypeCalendarValidatorValue &&
        chooseFileValidatorValue) {
      await createCubit.checkDuplicate(
        context: context,
        title: titleController.value.text.removeSpace,
        content: contentController.value.text.removeSpace,
        location: locationController.value.text.removeSpace,
      );
    }
    if (pickTimeValidatorValue) {
      cupertinoCubit.validateTime.sink.add(
        S.current.ban_phai_chon_thoi_gian,
      );
    }
    if (chooseTypeCalendarValidatorValue) {
      createCubit.checkChooseTypeCal.sink.add(true);
    }
  }
}

class CreateWorkCalendarProvide extends InheritedWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;

  const CreateWorkCalendarProvide({
    Key? key,
    required this.taoLichLamViecCubit,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CreateWorkCalendarProvide of(BuildContext context) {
    final CreateWorkCalendarProvide? result =
        context.dependOnInheritedWidgetOfExactType<CreateWorkCalendarProvide>();
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

Widget bottomButtonWidget({
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
      margin: const EdgeInsets.only(top: 16),
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
