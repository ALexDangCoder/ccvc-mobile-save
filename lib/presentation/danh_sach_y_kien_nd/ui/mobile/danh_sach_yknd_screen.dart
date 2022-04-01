import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan%20_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/bloc/danh_sach_yknd_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachYKND extends StatefulWidget {
  final String startDate;
  final String endDate;

  const DanhSachYKND({required this.startDate, required this.endDate, Key? key})
      : super(key: key);

  @override
  _DanhSachYKNDState createState() => _DanhSachYKNDState();
}

class _DanhSachYKNDState extends State<DanhSachYKND> {
  DanhSachYKienNguoiDanCubit cubit = DanhSachYKienNguoiDanCubit();

  @override
  void initState() {
    super.initState();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<bool>(
          stream: cubit.selectSreach,
          builder: (context, snapshot) {
            final selectData = snapshot.data ?? false;
            return selectData
                ? TextFormField(
                    onChanged: (value) {
                      cubit.callSearchApi(
                        value,
                        widget.startDate,
                        widget.endDate,
                        10,
                        1,
                      );
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.current.tim_kiem,
                      hintStyle: textNormalCustom(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: unselectLabelColor,
                      ),
                    ),
                  )
                : Text(
                    S.current.danh_sach_y_kien_nguoi_Dan,
                    style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
                  );
          },
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cubit.setSelectSearch();
            },
            icon: SvgPicture.asset(ImageAssets.ic_search_calendar),
          ),
        ],
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          cubit.callApi();
        },
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('', S.current.something_went_wrong),
          stream: cubit.stateStream,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder<List<YKienNguoiDanModel>>(
              stream: cubit.listYKienNguoiDan,
              builder: (context, snapshot) {
                final listData = snapshot.data ?? [];
                if (listData.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return YKienNguoiDanCell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChiTietYKNDScreen(
                                iD: listData[index].id,
                                taskID: listData[index].taskID,
                              ),
                            ),
                          );
                        },
                        title: listData[index].tieuDe,
                        dateTime: listData[index].ngayNhan,
                        userName: 'Ha Kieu Anh',
                        status: listData[index].soNgayToiHan,
                        userImage:
                            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
