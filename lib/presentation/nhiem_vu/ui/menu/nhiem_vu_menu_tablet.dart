import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NhiemVuMenuTablet extends StatefulWidget {
  final NhiemVuCubit cubit;

  const NhiemVuMenuTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _NhiemVuMenuTabletState createState() => _NhiemVuMenuTabletState();
}

class _NhiemVuMenuTabletState extends State<NhiemVuMenuTablet> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu,
        leadingIcon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: 10,
            width: 10,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                ImageAssets.icExit,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<List<bool>>(
          stream: widget.cubit.selectTypeNhiemVuSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [true, false];
            return Column(
              children: [
                TheoDangLichWidget(
                  icon: ImageAssets.icPerson,
                  name: S.current.nhiem_vu_ca_nhan,
                  onTap: () {
                    widget.cubit.selectTypeNhiemVuSubject.add([true, false]);
                    widget.cubit.emit(NhiemVuCaNhan());
                    Navigator.pop(context);
                  },
                  isSelect: data[0],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
                TheoDangLichWidget(
                  icon: ImageAssets.icTheoDangDanhSachGrey,
                  name: S.current.nhiem_vu_don_vi,
                  onTap: () {
                    widget.cubit.selectTypeNhiemVuSubject.add([false, true]);
                    widget.cubit.emit(NhiemVuDonVi());
                    Navigator.pop(context);
                  },
                  isSelect: data[1],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
