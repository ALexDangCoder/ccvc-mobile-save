import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ThongTinChungYKNDScreen extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDScreenState createState() =>
      _ThongTinChungYKNDScreenState();
}

class _ThongTinChungYKNDScreenState extends State<ThongTinChungYKNDScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.cubit.initTimeRange();
    widget.cubit.callApi();
    widget.cubit.getDanhSachPAKN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: StreamBuilder<bool>(
          stream: widget.cubit.selectSreach,
          builder: (context, snapshot) {
            final selectData = snapshot.data ?? false;
            return selectData
                ? TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                      widget.cubit.search = value;
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
                    S.current.thong_tin_pakn,
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
          GestureDetector(
            onTap: () {
              widget.cubit.setSelectSearch();
            },
            child: SvgPicture.asset(ImageAssets.icSearchPAKN),
          ),
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: YKienNguoiDanMenu(
                  cubit: widget.cubit,
                ),
              );
            },
            child: SvgPicture.asset(ImageAssets.icMenuCalender),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        centerTitle: true,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        stream: widget.cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () {},
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (widget.cubit.canLoadMoreList && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              widget.cubit.loadMoreGetDSPAKN();
            }
            return true;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterDateTimeWidget(
                  context: context,
                  isMobile: true,
                  onChooseDateFilter: (DateTime startDate, DateTime endDate) {
                    widget.cubit.getDanhSachPAKN();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ExpandPAKNWidget(
                    name: S.current.tinh_hinh_xu_ly_pakn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TiepCanWidget(),
                        SizedBox(
                          height: 33,
                        ),
                        XuLyWidget(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  color: homeColor,
                  height: 6,
                ),
                spaceH20,
                InkWell(
                  onTap: () {
                    // goTo(context, ChiTietPKAN(iD: 'fd393528-3b62-4766-8014-235cc30210cc', taskID: '2509abc0-97c5-494b-baf3-45422ec35ce1',));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(S.current.danh_sach_pakn, style: textNormalCustom(color: textTitle, fontSize: 16, fontWeight: FontWeight.w500,),),
                  ),
                ),
                StreamBuilder<List<DanhSachKetQuaPAKNModel>>(
                  stream: widget.cubit.listDanhSachKetQuaPakn.stream,
                  initialData: [],
                  builder: (context, snapShot) {
                    final data = snapShot.data ?? [];
                    if (data.isEmpty) {
                      return Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),child: const NodataWidget());
                    } else {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return _itemDanhSachPAKN(dsKetQuaPakn: data[index]);
                          });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemDanhSachPAKN({required DanhSachKetQuaPAKNModel dsKetQuaPakn}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(color: cellColorborder),
      ),
      child: Column(
        children: [
          Text(
            'Chậm trễ hỗ trợ tiền lương ngừng việc do COVID19',
            style: textNormalCustom(
              color: textTitle,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          spaceH8,
          Row(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  ImageAssets.icInformation,
                  height: 16,
                  width: 16,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Số: ',
                  style: textNormalCustom(
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          spaceH8,
          Row(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  ImageAssets.icLocation,
                  height: 16,
                  width: 16,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  '${S.current.ten_ca_nhan_tc}: ',
                  style: textNormalCustom(
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          spaceH8,
          Row(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  ImageAssets.icClock,
                  height: 16,
                  width: 16,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  '${S.current.han_xu_ly}: ${dsKetQuaPakn.hanXuLy}',
                  style: textNormalCustom(
                    color: infoColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Color statusTrangThai(int trangThai) {
    switch(trangThai) {
      case YKienNguoiDanCubitt.TRONGHAN : {
        return choTrinhKyColor;
      }
      case YKienNguoiDanCubitt.DENHAN : {
        return choVaoSoColor;
      }
      default :
        //QUA HAN
        return statusCalenderRed;
    }
  }
}
