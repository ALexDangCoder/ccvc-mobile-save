import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lichlv_danh_sach_y_kien/bloc/y_kien_cubit.dart';
import 'package:ccvc_mobile/presentation/lichlv_danh_sach_y_kien/bloc/y_kien_state.dart';
import 'package:ccvc_mobile/presentation/lichlv_danh_sach_y_kien/ui/mobile/widgets/item_y_kiem.dart';
import 'package:flutter/material.dart';

class DanhSachYKienScreen extends StatefulWidget {
  const DanhSachYKienScreen({Key? key}) : super(key: key);

  @override
  _DanhSachYKienScreenState createState() => _DanhSachYKienScreenState();
}

class _DanhSachYKienScreenState extends State<DanhSachYKienScreen> {
  YKienCubit cubit = YKienCubit(YKienStateIntial());

  @override
  void initState() {
    super.initState();
    cubit.fakeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: StreamBuilder<List<YKienModel>>(
            stream: cubit.listYKien,
            builder: (context, snapshot) {
              final listData = snapshot.data ?? [];
              if (listData.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return ItemYKien(
                      time: listData[index].time,
                      name: listData[index].name,
                      imgAvatar: listData[index].imgAvatar,
                      nameFile: listData[index].fileName,
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(S.current.no_data),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
