import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DanhSachCongViecTablet extends StatefulWidget {
  const DanhSachCongViecTablet({Key? key}) : super(key: key);

  @override
  _DanhSachCongViecTabletState createState() => _DanhSachCongViecTabletState();
}

class _DanhSachCongViecTabletState extends State<DanhSachCongViecTablet> {
  NhiemVuCubit cubit = NhiemVuCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.danh_sach_cong_viec),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: ChooseTimeScreen(
              today: DateTime.now(),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top:28.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listDanhSachCongViec.length,
                    itemBuilder: (context, index) {
                      return NhiemVuCellTablet(
                        onTap: () {},
                        title: listDanhSachCongViec[index].title ?? '',
                        noiDung: listDanhSachCongViec[index].noiDung ?? '',
                        dateTimeStart:
                            listDanhSachCongViec[index].timeStart ?? '',
                        dateTimeEnd: listDanhSachCongViec[index].timeEnd ?? '',
                        userName: listDanhSachCongViec[index].nguoiTao ?? '',
                        status: listDanhSachCongViec[index].trangThai ?? '',
                        userImage:
                            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                        index: index + 1,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
