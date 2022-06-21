import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/ui/mobile/widget/date_input.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/radio/group_radio_button.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNgoaiHeThongMobile extends StatefulWidget {
  const TabNgoaiHeThongMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ChiaSeBaoCaoCubit cubit;

  @override
  State<TabNgoaiHeThongMobile> createState() => _TabNgoaiHeThongMobileState();
}

class _TabNgoaiHeThongMobileState extends State<TabNgoaiHeThongMobile> {
  final _groupKey = GlobalKey<FormGroupState>();

  final Debouncer _debounce = Debouncer();


  String? name;
  String? birthday;
  String? email;
  String? phoneNumber;
  String? position;
  String? unit;
  String? note;


  @override
  void initState() {
    super.initState();
    widget.cubit.getUsersNgoaiHeThongDuocTruyCap(appId: widget.cubit.appId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateStreamLayout(
        stream: widget.cubit.stateStream,
        error: AppException(
          '',
          S.current.something_went_wrong,
        ),
        retry: () {},
        textEmpty: S.current.khong_co_du_lieu,
        child: SingleChildScrollView(
          child: Column(
            children: [
              spaceH20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: StreamBuilder<bool>(
                  stream: widget.cubit.isDuocTruyCapStream,
                  builder: (context, snapshot) {
                    final isDuocTruyCap = snapshot.data ?? false;
                    return CustomGroupRadio<bool>(
                      listData: [
                        ItemCustomGroupRadio(
                          title: S.current.doi_tuong_da_duoc_truy_cap,
                          value: true,
                        ),
                        ItemCustomGroupRadio(
                          title: S.current.them_moi_doi_tuong,
                          value: false,
                        ),
                      ],
                      groupValue: isDuocTruyCap,
                      onchange: (value) {
                        widget.cubit.isDuocTruyCapSink.add(value ?? false);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: StreamBuilder<bool>(
                  stream: widget.cubit.isDuocTruyCapStream,
                  builder: (context, snapshot) {
                    final isDuocTruyCap = snapshot.data ?? false;
                    if (isDuocTruyCap) {
                      return objectAccessed;
                    } else {
                      return newObject;
                    }
                  },
                ),
              ),
              buttonBottom,
              spaceH28,
            ],
          ),
        ),
      ),
    );
  }

  Widget get newObject => FormGroup(
        key: _groupKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textField(
              title: '${S.current.ho_ten}(*)',
              hintText: S.current.ho_ten,
              onChange: (value) {
                name = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return S.current.khong_duoc_de_trong;
                }
              },
            ),
            spaceH16,
            DateInput(
              paddings: 10,
              leadingIcon: SvgPicture.asset(ImageAssets.icCalenders),
              onSelectDate: (dateTime) {
                birthday = dateTime;
              },
              initDateTime: DateTime.tryParse(birthday ?? ''),
            ),
            spaceH16,
            textField(
              title: '${S.current.email}(*)',
              hintText: S.current.email,
              onChange: (value) {
                email = value;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return S.current.khong_duoc_de_trong;
                }
              },
            ),
            spaceH16,
            textField(
              hintText: S.current.so_dien_thoai,
              title: S.current.so_dien_thoai,
              onChange: (value) {
                phoneNumber = value;
              },
            ),
            spaceH16,
            textField(
              hintText: S.current.chuc_vu,
              title: S.current.chuc_vu,
              onChange: (value) {
                position = value;
              },
            ),
            spaceH16,
            textField(
              title: '${S.current.don_vi}(*)',
              hintText: S.current.don_vi,
              onChange: (value) {
                unit = unit;
              },
              validate: (value) {
                if ((value ?? '').isEmpty) {
                  return S.current.khong_duoc_de_trong;
                }
              },
            ),
            spaceH16,
            textField(
              title: S.current.ghi_chu,
              onChange: (value) {
                note = value;
              },
              maxLine: 6,
            ),
          ],
        ),
      );

  Widget get objectAccessed => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          search,
          listDoiTuongDaTruyCap,
        ],
      );

  InputBorder get borderSearch => const OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      );

  Widget get buttonBottom => Padding(
        padding: const EdgeInsets.only(
          left: 21,
          right: 21,
          top: 24,
        ),
        child: DoubleButtonBottom(
          onPressed1: () {
            Navigator.pop(context);
          },
          title1: S.current.dong,
          title2: S.current.chia_se,
          onPressed2: () {
            if (_groupKey.currentState?.validator() ?? true) {
              //share here
              Navigator.pop(context);
            } else {
              final toast = FToast();
              toast.init(context);
              toast.showToast(
                child: ShowToast(
                  text: S.current.sai_dinh_dang_truong,
                ),
                gravity: ToastGravity.BOTTOM,
              );
            }
          },
        ),
      );

  Widget get listDoiTuongDaTruyCap => Container(
        constraints: BoxConstraints(
          minHeight: 330.h,
        ),
        child: const NodataWidget(),
      );

  Widget get search => TextField(
        style: tokenDetailAmount(
          fontSize: 14.0.textScale(),
          color: color3D5586,
        ),
        decoration: InputDecoration(
          hintText: S.current.tim_kiem_nhanh,
          hintStyle: textNormal(titleItemEdit.withOpacity(0.5), 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.getInstance().colorField(),
          ),
          border: borderSearch,
          enabledBorder: borderSearch,
          focusedBorder: borderSearch,
        ),
        onChanged: (keySearch) {
          _debounce.run(() {
            //search here
          });
        },
      );

  Widget textField({
    String? hintText,
    int maxLine = 1,
    required String title,
    required Function(String) onChange,
    String? Function(String?)? validate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: tokenDetailAmount(
              fontSize: 14,
              color: color3D5586,
            ),
          ),
        ),
        spaceH8,
        TextFieldValidator(
          hintText: hintText,
          onChange: onChange,
          maxLine: maxLine,
          validator: validate,
        )
      ],
    );
  }
}
