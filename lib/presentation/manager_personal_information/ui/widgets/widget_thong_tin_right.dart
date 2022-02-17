import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/ui/widgets/widget_row_item.dart';
import 'package:flutter/material.dart';

class WidgetThongTinRight extends StatefulWidget {
  final ManagerPersonalInformationCubit cubit;

  const WidgetThongTinRight({Key? key, required this.cubit}) : super(key: key);

  @override
  State<WidgetThongTinRight> createState() => _WidgetThongTinRightState();
}

class _WidgetThongTinRightState extends State<WidgetThongTinRight> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: widget.cubit.managerPersonalInformationModel
                .toListAdress()
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
