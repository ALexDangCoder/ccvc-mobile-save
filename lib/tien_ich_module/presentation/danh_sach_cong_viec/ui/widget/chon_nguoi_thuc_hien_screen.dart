import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_sach_cong_viec/bloc/danh_sach_cong_viec_tien_ich_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/dialog/loading_loadmore.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/search/base_search_bar.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChonNguoiThucHienScreen extends StatefulWidget {
  final DanhSachCongViecTienIchCubit cubit;
  final TextEditingController searchController;

  const ChonNguoiThucHienScreen({
    Key? key,
    required this.cubit,
    required this.searchController,
  }) : super(key: key);

  @override
  _DanhSachCongViecTienIchMobileState createState() =>
      _DanhSachCongViecTienIchMobileState();
}

class _DanhSachCongViecTienIchMobileState
    extends State<ChonNguoiThucHienScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.chon_nguoi_thuc_hien),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            final loadingMore =
                widget.cubit.showLoadNguoiThucHien.valueOrNull ?? false;
            if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200 &&
                widget.cubit.canLoadMoreNguoiThucHien &&
                !loadingMore) {
              ++widget.cubit.indexNguoiThucHien;
              widget.cubit.listNguoiThucHien(widget.searchController.text);
            }
            return true;
          },
          child: Column(
            children: [
              if (!isMobile())spaceH20,
              BaseSearchBar(
                hintText: S.current.ho_va_ten_can_bo,
                controller: widget.searchController,
                onChange: (value) {
                  widget.cubit.indexNguoiThucHien = ApiConstants.PAGE_BEGIN;
                  widget.cubit.waitToDelay(
                    actionNeedDelay: () {
                      widget.cubit.listNguoiThucHienSubject.sink.add([]);
                      widget.cubit.listNguoiThucHien(
                        value,
                      );
                    },
                    timeSecond: 1,
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<List<NguoiThucHienModel>>(
                        stream: widget.cubit.listNguoiThucHienSubject.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          if (data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final todo = data[index];
                                final showCheck = todo.id ==
                                    widget.cubit.nguoiThucHienSubject.valueOrNull?.id;
                                return GestureDetector(
                                  onTap: () {
                                    widget.cubit.nguoiThucHienSubject.sink.add(todo);
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              todo.dataAll(),
                                              style: textNormalCustom(
                                                color: titleItemEdit,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0.textScale(),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                        if (showCheck)
                                          SvgPicture.asset(
                                            ImageAssets.icCheck,
                                            color:
                                                AppTheme.getInstance().colorField(),
                                            width: 16,
                                            height: 16,
                                          )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: NodataWidget(),
                          );
                        },
                      ),
                      spaceH12,
                      StreamBuilder<bool>(
                        stream: widget.cubit.showLoadNguoiThucHien,
                        builder: (context, snapshot) {
                          if (snapshot.data ?? false) {
                            return LoadingItem();
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
