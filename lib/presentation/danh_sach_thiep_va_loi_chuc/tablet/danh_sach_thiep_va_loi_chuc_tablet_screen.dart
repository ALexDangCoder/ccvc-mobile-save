import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/tablet/chi_tiet_thiep_chuc_mung_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/bloc/thiep_chuc_mung_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/widgets/loi_chuc_cell.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';

class DanhSachThiepVaLoiChucTabletScreen extends StatefulWidget {
  const DanhSachThiepVaLoiChucTabletScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ThiepChucMungCuBit cubit;

  @override
  _DanhSachThiepVaLoiChucMobileScreenState createState() =>
      _DanhSachThiepVaLoiChucMobileScreenState();
}

class _DanhSachThiepVaLoiChucMobileScreenState
    extends State<DanhSachThiepVaLoiChucTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDefaultBack(S.current.danh_sach_thiep_va_loi_chuc),
        backgroundColor: bgTabletColor,
        body: ListViewLoadMore(
          cubit: widget.cubit,
          callApi: (page) {
            widget.cubit.getListBirthday(page);
          },
          isListView: true,
          viewItem: (data, index) {
            if (data is BirthdayModel) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChiTietThiepChucTabletScreen(
                        data: data,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 24,
                    left: 30,
                    bottom: 12,
                    right: 30,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Colors.white,
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: shadowContainerColor.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: LoiChucCell(
                    data: data,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
