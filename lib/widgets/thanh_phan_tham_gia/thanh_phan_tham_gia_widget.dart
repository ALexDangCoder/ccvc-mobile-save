import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/them_can_bo_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/them_don_vi_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/widgets/people_tham_gia_widget.dart';
import 'package:flutter/material.dart';

class ThanhPhanThamGiaWidget extends StatefulWidget {
  final Function(List<DonViModel>) onChange;
  final Function(bool) phuongThucNhan;

  final bool isPhuongThucNhan;

  const ThanhPhanThamGiaWidget({
    Key? key,
    required this.isPhuongThucNhan,
    required this.onChange,
    required this.phuongThucNhan,
  }) : super(key: key);

  @override
  _ThanhPhanThamGiaWidgetState createState() => _ThanhPhanThamGiaWidgetState();
}

class _ThanhPhanThamGiaWidgetState extends State<ThanhPhanThamGiaWidget> {
  final ThanhPhanThamGiaCubit _cubit = ThanhPhanThamGiaCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.listPeopleThamGia.listen((event) {
      widget.onChange(event);
    });
    _cubit.phuongThucNhanStream.listen((event) {
      widget.phuongThucNhan(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<DonViModel>>(
          stream: _cubit.listPeopleThamGia,
          builder: (context, snapshot) {
            return ThemDonViWidget(
              listSelectNode: snapshot.data ?? [],
              onChange: (value) {
                _cubit.addPeopleThamGia(
                  value.map((e) => e.value).toList(),
                );
              },
            );
          },
        ),
        SizedBox(
          height: 16.0.textScale(space: 8),
        ),
        ThemCanBoWidget(
          onChange: (value) {
            _cubit.addPeopleThamGia(value);
          },
        ),
        SizedBox(
          height: 20.0.textScale(space: -2),
        ),
        if (widget.isPhuongThucNhan)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    S.current.phuong_thuc_nhan_khac,
                    style: textNormal(textBodyTime, 14),
                  ),
                  spaceW25,
                  StreamBuilder<bool>(
                    stream: _cubit.phuongThucNhanStream,
                    builder: (context, snapshot) {
                      return CustomCheckBox(
                        title: S.current.gui_email,
                        onChange: (isCheck) {
                          _cubit.changePhuongThucNhan(value: isCheck);
                        },
                        isCheck: snapshot.data ?? false,
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.0.textScale(space: -2),
              ),
            ],
          )
        else
          Container(),
        StreamBuilder<List<DonViModel>>(
          stream: _cubit.listPeopleThamGia,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <DonViModel>[];
            return Column(
              children: List.generate(
                data.length,
                (index) => Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : 20),
                  child: PeopleThamGiaWidget(
                    donVi: data[index],
                    cubit: _cubit,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
