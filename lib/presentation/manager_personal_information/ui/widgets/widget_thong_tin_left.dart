import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_row_item.dart';
import 'package:flutter/material.dart';

class WidgetThongTinLeft extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;

  const WidgetThongTinLeft({Key? key, required this.cubit}) : super(key: key);

  @override
  State<WidgetThongTinLeft> createState() => _WidgetThongTinLeftState();
}

class _WidgetThongTinLeftState extends State<WidgetThongTinLeft> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: widget.cubit.managerPersonalInformationModel
                .toListRowDetailJob()
                .map(
                  (row) => WidgetRowItem(
                    row: row,
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
