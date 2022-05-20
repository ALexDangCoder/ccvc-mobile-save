import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/setting_notify_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/thong_bao_type.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaiDatThongBaoMobile extends StatefulWidget {
  final ThongBaoCubit cubit;

  const CaiDatThongBaoMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _CaiDatThongBaoMobileState createState() => _CaiDatThongBaoMobileState();
}

class _CaiDatThongBaoMobileState extends State<CaiDatThongBaoMobile> {
  @override
  void initState() {
    super.initState();
    widget.cubit.showContent();
    widget.cubit.getSettingNoti();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: widget.cubit.stateStream,
      retry: () {},
      textEmpty: S.current.khong_co_du_lieu,
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      child: StreamBuilder<SettingNotifyModel>(
        stream: widget.cubit.settingSubject.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: BaseAppBar(
              title: S.current.thong_bao,
              elevation: 0.5,
              leadingIcon: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                  height: 18,
                  width: 18,
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: textBodyTime,
                  ),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8.0.textScale(),
                vertical: 14.0.textScale(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.thong_bao_quan_trong,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0.textScale()),
                    child: StreamBuilder<List<ThongBaoModel>>(
                      stream: widget.cubit.thongBaoStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ItemThongBaoMobile(
                              image: data[index].code?.getIcon() ??
                                  ImageAssets.icCamera,
                              title: data[index].name ?? '',
                              id: data[index].id ?? '',
                              unreadCount: data[index].total ?? 0,
                              isSwitch: true,
                              onTap: () {},
                              valueSwitch: widget.cubit.stateAppCode.contains(
                                  (data[index].code ?? '').trim(),),
                              onChange: (bool status) {
                                widget.cubit.changeSwitch(
                                  (data[index].code ?? '').trim(),
                                  status,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    S.current.chung,
                    style: textNormalCustom(
                      color: textTitle,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
