import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class WidgetFilterCaNhanXuLy extends StatelessWidget {
  final BaoCaoThongKeCubit cubit;

  const WidgetFilterCaNhanXuLy({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DonViModel>?>(
      stream: cubit.listCaNhanXuLy,
      builder: (context, snapshot) {
        final list = snapshot.data;
        return list != null
            ? list.isNotEmpty
                ? SizedBox(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => cubit.onChangeCaNhanXuLy(list[index]),
                        child: Container(
                          color: list[index].name ==
                                  cubit.textCaNhanXuLyFilter.value
                              ? radioUnfocusColor
                              : backgroundColorApp,
                          child: Text(
                            list[index].name,
                            style: textNormalCustom(
                              color: color3D5586,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  )
                : noData()
            : const SizedBox.shrink();
      },
    );
  }
}

Widget noData() {
  return Center(
    child: Text(
      S.current.khong_co_du_lieu,
      style: textNormalCustom(
        fontSize: 16.0.textScale(space: 4.0),
        color: grayChart,
      ),
    ),
  );
}
