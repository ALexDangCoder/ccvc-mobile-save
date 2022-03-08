import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/nguoi_dan_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/bloc/danh_sach_yknd_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class DanhSachYKNDTablet extends StatefulWidget {
  const DanhSachYKNDTablet({Key? key}) : super(key: key);

  @override
  _DanhSachYKNDTabletState createState() => _DanhSachYKNDTabletState();
}

class _DanhSachYKNDTabletState extends State<DanhSachYKNDTablet>
    with SingleTickerProviderStateMixin {
  DanhSachYKienNguoiDanCubit cubit = DanhSachYKienNguoiDanCubit();
  ChooseTimeCubit chooseTimeCubit=ChooseTimeCubit();
  @override
  void initState() {
    super.initState();
    cubit.getListYKien();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.danh_sach_y_kien_nguoi_Dan,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChooseTimeScreen(
              baseChooseTimeCubit: chooseTimeCubit,
              today: DateTime.now(),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 28, 30, 0),
              child: StreamBuilder<List<NguoiDanModel>>(
                stream: cubit.listYKienNguoiDan,
                builder: (context, snapshot) {
                  final List<NguoiDanModel> listData = snapshot.data ?? [];
                  if (listData.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        return YKienNguoiDanCell(
                          onTap: () {},
                          title: listData[index].ngheNghiep ?? '',
                          dateTime: listData[index].ngayThang ?? '',
                          userName: listData[index].ten ?? '',
                          status: listData[index].statusData.getText().text,
                          stausColor:
                              listData[index].statusData.getText().color,
                          userImage:
                              'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
