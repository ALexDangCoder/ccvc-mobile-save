import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/extension/report_statistical.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/report_statistical/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class DocumentInStatisticalPage extends StatelessWidget {
  final QLVBCCubit cubit;

  const DocumentInStatisticalPage({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            height: 122,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: StreamBuilder<List<InfoItemModel>>(
              stream: cubit.infoItemStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(
                      right: index == (data.length - 1) ? 0 : 16,
                    ),
                    child: infoItem(
                      title: data[index].name,
                      quantity: data[index].quantity,
                      lastYearQuantity: data[index].lastYearQuantity,
                      color: data[index].color,
                    ),
                  ),
                );
              },
            ),
          ),
          appDivider,
        ],
      ),
    );
  }
}
