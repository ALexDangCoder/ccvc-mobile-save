import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/menu/diem_danh_menu_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/widget_item_thong_ke.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_diem_danh_ca_nhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiemDanhCaNhanTabletScreen extends StatefulWidget {
  DiemDanhCubit cubit;

  DiemDanhCaNhanTabletScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _DiemDanhCaNhanTabletScreenState createState() =>
      _DiemDanhCaNhanTabletScreenState();
}

class _DiemDanhCaNhanTabletScreenState
    extends State<DiemDanhCaNhanTabletScreen> {
  @override
  void initState() {
    widget.cubit.postDiemDanhThongKe();
    widget.cubit.postBangDiemDanhCaNhan();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:colorF9FAFF ,
      appBar: BaseAppBar(
        title: S.current.diem_danh_ca_nhan,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiemDanhMenuTablet(
                    cubit: widget.cubit,
                  ),
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ProviderWidget<DiemDanhCubit>(
            cubit: widget.cubit,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 28.0),
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorE2E8F0),
                          borderRadius: BorderRadius.circular(6.0),
                          color: colorFFFFFF,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ExpandOnlyWidget(
                          padingSize: 8,
                          isPadingIcon: true,
                          initExpand: true,
                          header: Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16.0),
                              child: Row(
                                children: [
                                  Text(
                                    S.current.thong_ke,
                                    style: textNormalCustom(
                                        color: color3D5586, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: StreamBuilder<ThongKeDiemDanhCaNhanModel>(
                              stream: widget.cubit.thongKeSubject,
                              builder: (context, snapshot) {
                                final data=snapshot.data;
                                return WidgetItemThongKe(
                                  thongKeDiemDanhCaNhanModel: data??ThongKeDiemDanhCaNhanModel(),
                                );
                              }
                          ),
                        ),
                      ),  ),
                      Expanded(child: Container()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
