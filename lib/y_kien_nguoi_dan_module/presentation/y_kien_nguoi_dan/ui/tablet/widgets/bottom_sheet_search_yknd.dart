import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/ui/mobile/widget/selectdate.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/widgets/tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetSearchYKND extends StatefulWidget {
  const BottomSheetSearchYKND({Key? key}) : super(key: key);

  @override
  _BottomSheetSearchYKNDState createState() => _BottomSheetSearchYKNDState();
}

class _BottomSheetSearchYKNDState extends State<BottomSheetSearchYKND> {
  final ThemDonViCubit _themDonViCubit = ThemDonViCubit();
  final ThanhPhanThamGiaCubit cubit = ThanhPhanThamGiaCubit();
  @override
  void initState() {
    super.initState();
    cubit.getTree();
    cubit.getTreeDonVi.listen((event) {
      _themDonViCubit.getTreeDonVi(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.danh_sach_don_vi_tham_gia,
            style: textNormalCustom(
              fontSize: 14,
              color: titleItemEdit,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          StreamBuilder<List<Node<DonViModel>>>(
            stream: _themDonViCubit.getTree,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <Node<DonViModel>>[];
              if (data.isNotEmpty) {
                return ListView.builder(
                  keyboardDismissBehavior: isMobile()
                      ? ScrollViewKeyboardDismissBehavior.onDrag
                      : ScrollViewKeyboardDismissBehavior.manual,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TreeViewWidget(
                      themDonViCubit: _themDonViCubit,
                      node: data[index],
                    );
                  },
                );
              }
              return Column(
                children: const [
                  NodataWidget(),
                ],
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                S.current.tu_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              const Text('~'),
              const SizedBox(
                width: 1,
              ),
              Text(
                S.current.den_ngay,
                style: textNormalCustom(
                  fontSize: 14,
                  color: titleItemEdit,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: DateTime.now().toString(),
                  onSelectDate: (dateTime) {},
                ),
              ),
              const SizedBox(
                width: 40,
                child: Center(
                  child: Text('~'),
                ),
              ),
              Expanded(
                child: SelectDate(
                  key: UniqueKey(),
                  paddings: 10,
                  leadingIcon: SvgPicture.asset(ImageAssets.ic_Calendar_tui),
                  value: '2022-01-01',
                  onSelectDate: (dateTime) {},
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ButtonCustomBottom(
                  title: S.current.dong,
                  isColorBlue: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: ButtonCustomBottom(
                  title: S.current.tim_kiem,
                  isColorBlue: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
