import 'dart:convert';
import 'dart:io';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_frame_conner.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_chup_anh_cmnd.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/bloc/cap_nhat_thong_tin_khach_hang_cubit.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/thong_tin_khach_vao_co_quan_screen.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_pick_image_default.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CapNhatThongTinKhachHangMobile extends StatefulWidget {
  const CapNhatThongTinKhachHangMobile({Key? key}) : super(key: key);

  @override
  _CapNhatThongTinKhachHangMobileState createState() =>
      _CapNhatThongTinKhachHangMobileState();
}

class _CapNhatThongTinKhachHangMobileState
    extends State<CapNhatThongTinKhachHangMobile> {
  final CapNhatThongTinKhachHangCubit cubit = CapNhatThongTinKhachHangCubit();

  @override
  void initState() {
    super.initState();
    cubit.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      stream: cubit.stateStream,
      child: Scaffold(
        appBar: AppBarDefaultBack(S.current.cap_nhat_nhan_dien_cmnd_cccd),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.anh_mat_truoc,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceH16,
                if (cubit.filePickImageFrontend.isNotEmpty)
                 SizedBox(
                   height: (MediaQuery.of(context).size.width - 32) / 1.8,
                   child: WidgetFrameConner(
                     child:  Stack(
                       children: [
                         Positioned.fill(
                           child: Image.file(
                             cubit.filePickImageFrontend.first,
                             fit: BoxFit.fill,
                           ),
                         ),
                         Positioned(
                           top: 10,
                           right: 10,
                           child: GestureDetector(
                             onTap: () {
                               cubit.filePickImageFrontend = [];
                               setState(() {});
                             },
                             child: SvgPicture.asset(
                               ImageAssets.icRemoveImg,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 )
                else
                  PickImageDefault(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WidgetChupAnhCMND(
                            title: S.current.chup_anh_mat_truoc,
                            onChange: (onChange) {
                              cubit.filePickImageFrontend = onChange;
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    S.current.anh_mat_sau,
                    style: textNormalCustom(
                      color: color3D5586,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (cubit.filePickImageBackEnd.isNotEmpty)
                  SizedBox(
                    height: (MediaQuery.of(context).size.width - 32) / 1.8,
                    child: WidgetFrameConner(
                      child:  Stack(
                        children: [
                          Positioned.fill(
                            child: Image.file(
                              cubit.filePickImageBackEnd.first,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                cubit.filePickImageBackEnd = [];
                                setState(() {});
                              },
                              child: SvgPicture.asset(
                                ImageAssets.icRemoveImg,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  PickImageDefault(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WidgetChupAnhCMND(
                            title: S.current.chup_anh_mat_sau,
                            onChange: (onChange) {
                              cubit.filePickImageBackEnd = onChange;
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 24.0,
            right: 16.0,
            left: 16.0,
            top: 16.0,
          ),
          child: StreamBuilder<CheckIdCardModel>(
              stream: cubit.checkIdCardModelsubject,
              builder: (context, snapshot) {
                final typeData = snapshot.data ??
                    CheckIdCardModel(
                      backContent: null,
                      frontContent: null,
                      requestId: '',
                    );
                return ButtonCustomBottom(
                  isColorBlue: cubit.filePickImageFrontend.isNotEmpty &&
                      cubit.filePickImageBackEnd.isNotEmpty,
                  title: S.current.tiep_theo,
                  onPressed: () {
                    if (cubit.filePickImageFrontend.isNotEmpty &&
                        cubit.filePickImageBackEnd.isNotEmpty) {
                      cubit.postCheckIdCard(context).then((value) {
                        if (value == false) {
                          final bytes =
                              File(cubit.filePickImageFrontend.first.path)
                                  .readAsBytesSync();
                          final String base64Image =
                              '$BASE_64,${base64Encode(bytes)}';
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ThongTinKhachVaoCoQuanScreen(
                                checkIdCardModel: typeData,
                                base64Image: base64Image,
                              ),
                            ),
                            (Route<dynamic> route) => route.isFirst,
                          );
                        } else {
                          showDiaLog(
                            context,
                            title: S.current.hinh_anh_nhan_dien_khong_hop_le,
                            icon: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: choVaoSoColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  6.0,
                                ),
                              ),
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                ImageAssets.icAlertDanger,
                              ),
                            ),
                            btnLeftTxt: S.current.dong,
                            btnRightTxt: S.current.thu_lai,
                            funcBtnRight: () {
                              cubit.filePickImageBackEnd = [];
                              cubit.filePickImageFrontend = [];
                              setState(() {});
                            },
                            showTablet: false,
                            textAlign: TextAlign.start,
                            textContent:
                                '${S.current.mesage_thong_tin_khach}\n${S.current.mesage_thong_tin_khach1}\n'
                                '${S.current.mesage_thong_tin_khach2}\n${S.current.mesage_thong_tin_khach3}\n'
                                '${S.current.mesage_thong_tin_khach4}',
                          );
                        }
                      });
                    } else {}
                  },
                );
              }),
        ),
      ),
    );
  }
}
