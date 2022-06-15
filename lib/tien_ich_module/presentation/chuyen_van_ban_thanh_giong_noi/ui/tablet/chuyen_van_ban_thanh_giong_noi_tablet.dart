import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/bloc/chuyen_van_ban_thanh_giong_noi_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_van_ban_thanh_giong_noi/ui/mobile/chuyen_van_ban_thanh_giong_noi_mobile.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/dropdown/cool_drop_down.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChuyenVanBanThanhGiongNoiTablet extends StatefulWidget {
  const ChuyenVanBanThanhGiongNoiTablet({Key? key}) : super(key: key);

  @override
  _ChuyenVanBanThanhGiongNoiTabletState createState() =>
      _ChuyenVanBanThanhGiongNoiTabletState();
}

class _ChuyenVanBanThanhGiongNoiTabletState
    extends State<ChuyenVanBanThanhGiongNoiTablet> with WidgetsBindingObserver {
  ChuyenVanBanThanhGiongNoiCubit cubit = ChuyenVanBanThanhGiongNoiCubit();
  List<VoidTone> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    data = cubit.dataDrop;
    cubit.voidTone = KieuGiongNoi.north_female_lien;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    cubit.pauseMusic();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      cubit.pauseMusic();
    } else {
      cubit.playMusic(cubit.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(
        S.current.chuyen_van_ban_thanh_giong_noi,
      ),
      body: ProviderWidget<ChuyenVanBanThanhGiongNoiCubit>(
        cubit: cubit,
        child: StateStreamLayout(
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: cubit.stateStream,
          textEmpty: S.current.khong_co_du_lieu,
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width) *
                      0.55,
                  child: CoolDropDown(
                    initData: S.current.nu_mien_bac,
                    listData: data.map((e) => e.text ?? '').toList(),
                    onChange: (vl) {
                      final List<String> dataSelect =
                          data.map((e) => e.code ?? '').toList();
                      cubit.voidTone = dataSelect[vl];
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorNumberCellQLVB,
                      border: Border.all(color: borderColor.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      onChanged: (String value) {
                        cubit.text = value;
                        cubit.checkEnable();
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                StreamBuilder<bool>(
                  stream: cubit.enableButton,
                  builder: (context, snapshot) {
                    return btnListen(
                      onTap: () {
                        if (cubit.enableButton.value) {
                          cubit.chuyenVBSangGiongNoi();
                        }
                        cubit.pauseMusic();
                      },
                      isEnable: snapshot.data ?? true,
                    );
                  },
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
