import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:flutter/material.dart';

class DataViewTypeList extends StatefulWidget {
  const DataViewTypeList({Key? key, required this.cubit}) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<DataViewTypeList> createState() => _DataViewTypeListState();
}

class _DataViewTypeListState extends State<DataViewTypeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) {
        return Container(
          height: 50,
          margin: const  EdgeInsets.all(20),
          color: Colors.red,
        );
      },
    );
  }
}
