import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DanhSachNhiemVuTablet extends StatefulWidget {
  const DanhSachNhiemVuTablet({Key? key}) : super(key: key);

  @override
  _DanhSachNhiemVuTabletState createState() => _DanhSachNhiemVuTabletState();
}

class _DanhSachNhiemVuTabletState extends State<DanhSachNhiemVuTablet> {
  NhiemVuCubit cubit = NhiemVuCubit();
  ChooseTimeCubit chooseTimeCubit=ChooseTimeCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.danh_sach_nhiem_vu),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: ChooseTimeScreen(
              baseChooseTimeCubit: chooseTimeCubit,
              today: DateTime.now(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 28.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listDanhSachNhiemVu.length,
                    itemBuilder: (context, index) {
                      return NhiemVuCellTablet(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChiTietNhiemVuTabletScreen(),
                            ),
                          );
                        },
                        title: listDanhSachNhiemVu[index].title ?? '',
                        noiDung: listDanhSachNhiemVu[index].noiDung ?? '',
                        dateTimeStart:
                            listDanhSachNhiemVu[index].timeStart ?? '',
                        dateTimeEnd: listDanhSachNhiemVu[index].timeEnd ?? '',
                        userName: listDanhSachNhiemVu[index].nguoiTao ?? '',
                        status: listDanhSachNhiemVu[index].trangThai ?? '',
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
