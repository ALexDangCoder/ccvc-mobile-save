import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/bloc/danh_sach_yknd_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhSachYKND extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String trangThai;

  const DanhSachYKND({
    required this.startDate,
    required this.endDate,
    this.trangThai = '',
    Key? key,
  }) : super(key: key);

  @override
  _DanhSachYKNDState createState() => _DanhSachYKNDState();
}

class _DanhSachYKNDState extends State<DanhSachYKND> {
  DanhSachYKienNguoiDanCubit cubit = DanhSachYKienNguoiDanCubit();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit.callApi(
      widget.startDate,
      widget.endDate,
      trangThai: widget.trangThai,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: StreamBuilder<bool>(
          stream: cubit.selectSreach,
          builder: (context, snapshot) {
            final selectData = snapshot.data ?? false;
            return selectData
                ? TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                      cubit.search = value;
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
      body: _content(),
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
      trangThai: widget.trangThai,
      pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
      pageNumber: page,
    );
  }

  Widget itemDanhSachYKXL(YKienNguoiDanModel data) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: YKienNguoiDanCell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietYKNDScreen(
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
