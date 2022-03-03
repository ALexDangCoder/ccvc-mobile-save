import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetInExpand extends StatelessWidget {
  final List<RowDataExpandModel> row;
  final ChiTietNVCubit cubit;

  const WidgetInExpand({
    Key? key,
    required this.row,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.0.textScale(),
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: bgDropDown.withOpacity(0.1),
        border: Border.all(
          color: bgDropDown.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(6.0.textScale(space: 6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: row
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        e.key,
                        style: textNormalCustom(
                          color: dateColor,
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14.0.textScale(),
                    ),
                    Expanded(
                        flex: 5, child: e.type.getWidget(row: e, cubit: cubit)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
