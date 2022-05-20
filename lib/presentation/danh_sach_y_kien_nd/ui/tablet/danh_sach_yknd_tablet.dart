import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/chi_tiet_yknd_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/bloc/danh_sach_yknd_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachYKNDTablet extends StatefulWidget {
  final String startDate;
  final String endDate;

  const DanhSachYKNDTablet({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  _DanhSachYKNDTabletState createState() => _DanhSachYKNDTabletState();
}

class _DanhSachYKNDTabletState extends State<DanhSachYKNDTablet>
    with SingleTickerProviderStateMixin {
  DanhSachYKienNguoiDanCubit cubit = DanhSachYKienNguoiDanCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();

  @override
  void initState() {
    super.initState();
    cubit.callApi(widget.startDate, widget.endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorF9FAFF,
      appBar: AppBar(
        elevation: 0.7,
        title: StreamBuilder<bool>(
          stream: cubit.selectSreach,
          builder: (context, snapshot) {
            final selectData = snapshot.data ?? false;
            return selectData
                ? TextFormField(
                    onChanged: (value) {
                      setState(() {});
                      cubit.search = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.current.tim_kiem,
                      hintStyle: textNormalCustom(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: colorA2AEBD,
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
            icon: Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset(
                ImageAssets.ic_search_calendar,
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24.0),
          Expanded(child: _content()),
        ],
      ),
    );
  }

  Widget _content() {
    return ListViewLoadMore(
      cubit: cubit,
      isListView: true,
      callApi: (page) => {
        callApi(
          page,
        )
      },
      viewItem: (value, index) => itemDanhSachYKXL(value as YKienNguoiDanModel),
    );
  }

  void callApi(int page) {
    cubit.searchDanhSachYKienNguoiDan(
      tuNgay: widget.startDate,
      denNgay: widget.endDate,
      pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
      pageNumber: page,
    );
  }

  Widget itemDanhSachYKXL(YKienNguoiDanModel data) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
      ),
      child: YKienNguoiDanCell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietVanBanTabletScreen(
                iD: data.id ?? '',
                taskID: data.taskID ?? '',
              ),
            ),
          );
        },
        title: data.tieuDe ?? '',
        dateTime: data.ngayNhan ?? '',
        userName: data.tenNguoiPhanAnh ?? '',
        status: data.soNgayToiHan ?? 0,
        userImage:
            'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
      ),
    );
  }
}
