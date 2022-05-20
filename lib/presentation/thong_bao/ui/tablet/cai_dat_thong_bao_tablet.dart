import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/thong_bao_type.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaiDatThongBaoTablet extends StatefulWidget {
  final ThongBaoCubit cubit;

  const CaiDatThongBaoTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _CaiDatThongBaoTabletState createState() => _CaiDatThongBaoTabletState();
}

class _CaiDatThongBaoTabletState extends State<CaiDatThongBaoTablet> {
  @override
  void initState() {
    super.initState();
    widget.cubit.initDataSetting();
  }

  @override
  Widget build(BuildContext context) {
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
              color: colorA2AEBD,
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
                color: color3D5586,
                fontWeight: FontWeight.w500,
                fontSize: 16.0.textScale(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.textScale()),
              child: StreamBuilder<List<ThongBaoModel>>(
                stream: widget.cubit.settingSubject.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ItemThongBaoMobile(
                        image:
                            data[index].code?.getIcon() ?? ImageAssets.icCamera,
                        title: data[index].name ?? '',
                        id: data[index].id ?? '',
                        unreadCount: data[index].total ?? 0,
                        isSwitch: true,
                        onTap: () {},
                        onChange: (bool status) {},
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
                color: color3D5586,
                fontWeight: FontWeight.w500,
                fontSize: 16.0.textScale(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
