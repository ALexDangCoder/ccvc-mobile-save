import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/create_tech_suport.dart';

import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';

import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:flutter/material.dart';

enum StatusHTKT {
  CREATE,
  EDIT,
}

class AreaDropDown extends StatelessWidget {
  final HoTroKyThuatCubit cubit;
  final StatusHTKT statusHTKT;

  const AreaDropDown({
    Key? key,
    required this.cubit,
    required this.statusHTKT,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: S.current.khu_vuc,
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: color3D5586,
                ),
              ),
              TextSpan(
                text: ' *',
                style: tokenDetailAmount(
                  fontSize: 14,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
        spaceH8,
        StreamBuilder<List<CategoryModel>>(
          stream: cubit.listKhuVuc,
          builder: (context, snapshot) {
            final _areaList =
                (snapshot.data ?? []).map((area) => area.name ?? '').toList();
            return CustomDropDown(
              hint: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: S.current.chon,
                      style: tokenDetailAmount(
                        fontSize: 14,
                        color: color3D5586,
                      ),
                    ),
                  ],
                ),
              ),
              value: statusHTKT == StatusHTKT.CREATE
                  ? cubit.addTaskHTKTRequest.districtName
                  : cubit.nameArea,
              onSelectItem: (value) {
                statusHTKT == StatusHTKT.CREATE
                    ? cubit.selectArea(value)
                    : cubit.selectAreaEdit(value);
              },
              items: _areaList,
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: cubit.showErrorKhuVuc.stream,
          builder: (context, snapshot) {
            return snapshot.data ?? false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      S.current.khong_duoc_de_trong,
                      style: textNormalCustom(
                        color: redChart,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}
