import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/tin_radio_quoc_te_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/tin_radio_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/tin_radio_trong_nuoc_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_btn_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_item.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_item_quoc_te.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/widgets/ban_tin_item_trong_nuoc.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

enum dropDown { tinRadio, tinTrongNuoc }

class TinTucThoiSuScreenTablet extends StatefulWidget {
  final TinTucThoiSuBloc tinTucThoiSuBloc;
  final BuildContext pContext;

  const TinTucThoiSuScreenTablet({
    Key? key,
    required this.tinTucThoiSuBloc,
    required this.pContext,
  }) : super(key: key);

  @override
  State<TinTucThoiSuScreenTablet> createState() =>
      _TinTucThoiSuScreenTabletState();
}

class _TinTucThoiSuScreenTabletState extends State<TinTucThoiSuScreenTablet>
    with AutomaticKeepAliveClientMixin {
  dropDown? valueChoose = dropDown.tinRadio;

  @override
  void initState() {
    super.initState();
    widget.tinTucThoiSuBloc.listTinTuc.clear();
    widget.tinTucThoiSuBloc.getListTinTucRadio(
        ApiConstants.PAGE_BEGIN, ApiConstants.DEFAULT_PAGE_SIZE);
    widget.tinTucThoiSuBloc.getListTinTucRadioTrongNuoc(
        ApiConstants.PAGE_BEGIN, ApiConstants.DEFAULT_PAGE_SIZE);
    widget.tinTucThoiSuBloc.getListTinTucRadioQuocTe(
        ApiConstants.PAGE_BEGIN, ApiConstants.DEFAULT_PAGE_SIZE);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: widget.tinTucThoiSuBloc.stateStream,
        child: SingleChildScrollView(
          child: Container(
            color: bgCalenderColor,
            padding: const EdgeInsets.fromLTRB(30, 28, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<TinTucRadioResponseModel>(
                  stream: widget.tinTucThoiSuBloc.listTinTucRadio,
                  builder: (context, snapshot) {
                    return BanTinItemTablet(
                      listTinTuc: widget.tinTucThoiSuBloc.listTinTuc,
                      clickXemThem: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TinRadioTabletScreen(
                              pContext: widget.pContext,
                              tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                              title: S.current.tin_radio,
                              listBanTin: widget.tinTucThoiSuBloc.listTinTuc,
                            ),
                          ),
                        );
                        widget.tinTucThoiSuBloc.listTinTuc.clear();
                      },
                      title: S.current.tin_radio,
                      description: S.current.tin_radio_mieu_ta,
                      clickPLay: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.ban_tin_trua_ngay,
                          child: BanTinBtnSheetTablet(
                            listTinTuc: widget.tinTucThoiSuBloc.listTinTuc,
                          ),
                        );
                      },
                      tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                    );
                  },
                ),
                const SizedBox(
                  height: 28,
                ),
                const Divider(
                  height: 1,
                  color: bgDropDown,
                ),
                const SizedBox(
                  height: 28,
                ),
                StreamBuilder<TinTucRadioResponseModel>(
                  stream: widget.tinTucThoiSuBloc.listTinTucRadioTrongNuoc,
                  builder: (context, snapshot) {
                    return BanTinItemTrongNuocTablet(
                      listTinTuc: widget.tinTucThoiSuBloc.listTinTucTrongNuoc,
                      clickXemThem: () {
                        if (widget
                            .tinTucThoiSuBloc.listTinTucTrongNuoc.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TinRadioTrongNuocTabletScreen(
                                title: S.current.tin_trong_nuoc,
                                listBanTin:
                                    widget.tinTucThoiSuBloc.listTinTucTrongNuoc,
                                pContext: widget.pContext,
                                tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                              ),
                            ),
                          );
                          widget.tinTucThoiSuBloc.listTinTucTrongNuoc.clear();
                        } else {
                          return Container();
                        }
                      },
                      title: S.current.tin_trong_nuoc,
                      description: S.current.tin_trong_nuoc_mieu_ta,
                      clickPLay: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.ban_tin_trua_ngay,
                          child: BanTinBtnSheetTablet(
                            listTinTuc:
                                widget.tinTucThoiSuBloc.listTinTucTrongNuoc,
                          ),
                        );
                      },
                      tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                    );
                  },
                ),
                const SizedBox(
                  height: 28,
                ),
                const Divider(
                  height: 1,
                  color: bgDropDown,
                ),
                const SizedBox(
                  height: 28,
                ),
                StreamBuilder<TinTucRadioResponseModel>(
                  stream: widget.tinTucThoiSuBloc.listTinTucRadioQuocTe,
                  builder: (context, snapshot) {
                    return BanTinItemQuocTeTablet(
                      listTinTuc: widget.tinTucThoiSuBloc.listTinTucQuocTe,
                      clickXemThem: () {
                        if (widget
                            .tinTucThoiSuBloc.listTinTucQuocTe.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TinRadioQuocTeTabletScreen(
                                title: S.current.tin_quoc_te,
                                listBanTin:
                                    widget.tinTucThoiSuBloc.listTinTucQuocTe,
                                pContext: widget.pContext,
                                tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                              ),
                            ),
                          );
                          widget.tinTucThoiSuBloc.listTinTucQuocTe.clear();
                        } else {
                          return Container();
                        }
                      },
                      title: S.current.tin_quoc_te,
                      description: S.current.tin_trong_nuoc_mieu_ta,
                      clickPLay: () {
                        showBottomSheetCustom(
                          context,
                          title: S.current.ban_tin_trua_ngay,
                          child: BanTinBtnSheetTablet(
                            listTinTuc:
                                widget.tinTucThoiSuBloc.listTinTucQuocTe,
                          ),
                        );
                      },
                      tinTucThoiSuBloc: widget.tinTucThoiSuBloc,
                    );
                  },
                ),
                const SizedBox(
                  height: 28.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
