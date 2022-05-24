import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/sinh_nhat_model.dart';
import 'package:ccvc_mobile/home_module/presentation/thiep_chuc_sinh_nhat_screen.dart/bloc/chuc_sinh_nhat_bloc.dart';
import 'package:ccvc_mobile/home_module/presentation/thiep_chuc_sinh_nhat_screen.dart/bloc/chuc_sinh_nhat_state.dart';

import 'package:ccvc_mobile/home_module/presentation/thiep_chuc_sinh_nhat_screen.dart/widgets/page_view_transition.dart';
import 'package:ccvc_mobile/home_module/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/home_module/widgets/text_filed/block_textview.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kHeightKeyBoard = 150;

class ThiepChucMungTabletScreen extends StatefulWidget {
  final SinhNhatUserModel sinhNhatUserModel;
  const ThiepChucMungTabletScreen({Key? key, required this.sinhNhatUserModel})
      : super(key: key);

  @override
  _ThiepChucMungScreenState createState() => _ThiepChucMungScreenState();
}

class _ThiepChucMungScreenState extends State<ThiepChucMungTabletScreen> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final cubit = ChucSinhNhatCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (state is Succeeded) {
          Navigator.pop(context, S.current.gui_thiep_thanh_cong);
        }
      },
      child: Scaffold(
        appBar: AppBarDefaultBack(S.current.thiep_va_loi_chuc),
        body: StateStreamLayout(
          stream: cubit.stateStream,
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('', S.current.something_went_wrong),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 320,
                          child: PageViewWidget(
                            listImage: [
                              'https://ccvc-uat.chinhquyendientu.vn/img/thiep-1.fecb24e1.png',
                              'https://ccvc-uat.chinhquyendientu.vn/img/thiep-2.795a7971.png',
                              'https://ccvc-uat.chinhquyendientu.vn/img/thiep-3.ab60d036.png',
                              'https://ccvc-uat.chinhquyendientu.vn/img/thiep-4.05a66da6.png',
                              'https://ccvc-uat.chinhquyendientu.vn/img/thiep-5.962434c7.png'
                            ],
                            onSelect: (index) {},
                          )),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: BlockTextView(
                          hintText:
                              '${S.current.gui_loi_chuc_toi} ${widget.sinhNhatUserModel.tenCanBo}',
                          contentController: controller,
                          formKey: formKey,
                          title: S.current.gui_loi_chuc,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible:
                    MediaQuery.of(context).viewInsets.bottom < kHeightKeyBoard,
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 32, right: 16, left: 16),
                    child: DoubleButtonBottom(
                      onPressed2: () {
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.guiLoiChuc(
                              controller.text.trim(), widget.sinhNhatUserModel);
                        }
                      },
                      title2: S.current.gui,
                      onPressed1: () {
                        Navigator.pop(context);
                      },
                      title1: S.current.huy,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
