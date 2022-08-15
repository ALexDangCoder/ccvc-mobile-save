import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/cai_dat_thong_bao_mobile.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/mobile/thong_bao_quan_ly_vb_screen.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/thong_bao_type.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/type_detail.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_mobile.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_quan_trong.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/thong_bao_quan_trong_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThongBaoScreen extends StatefulWidget {
  const ThongBaoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ThongBaoScreenState createState() => _ThongBaoScreenState();
}

class _ThongBaoScreenState extends State<ThongBaoScreen> {
  final ThongBaoCubit thongBaoCubit = Get.find();

  @override
  void initState() {
    super.initState();
    thongBaoCubit.initData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await thongBaoCubit.initData();
      },
      child: StateStreamLayout(
        stream: thongBaoCubit.stateStream,
        retry: () {},
        textEmpty: S.current.khong_co_du_lieu,
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        child: Scaffold(
          appBar: BaseAppBar(
            title: S.current.thong_bao,
            elevation: 0.5,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaiDatThongBaoMobile(
                        cubit: thongBaoCubit,
                      ),
                    ),
                  ).then((value) {
                    thongBaoCubit.getThongBaoQuanTrong();
                  });
                },
                child: SvgPicture.asset(ImageAssets.icSettingNotify),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
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
            color: Colors.white,
            child: StreamBuilder<List<ThongBaoModel>>(
              stream: thongBaoCubit.thongBaoStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (!snapshot.hasData) {
                  return dontData();
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ItemThongBaoMobile(
                              image: data[index].thongBaoType?.getIcon() ??
                                  ImageAssets.icCamera,
                              title: data[index].thongBaoType?.getTitle() ?? '',
                              id: data[index].id ?? '',
                              unreadCount: data[index].total ?? 0,
                              isLine: index != data.length - 1,
                              onTap: () {
                                thongBaoCubit
                                    .selectNotiAppCode(data[index].code ?? '');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ThongBaoQuanLyVanBanScreen(
                                      cubit: thongBaoCubit,
                                      title: data[index].name ?? '',
                                    ),
                                  ),
                                );
                              },
                              onChange: (bool status) {},
                            );
                          },
                        ),
                      ),
                      ThongBaoQuanTrongWidget(
                        cubit: thongBaoCubit,
                      ),
                      StreamBuilder<ThongBaoQuanTrongModel>(
                        stream: thongBaoCubit.thongBaoQuanTrongStream,
                        builder: (context, snapshot) {
                          final dataTBQT = snapshot.data?.items ?? [];
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dataTBQT.length,
                            itemBuilder: (context, index) {
                              return ItemThongBaoQuanTrong(
                                title: dataTBQT[index].title ?? '',
                                message: dataTBQT[index].message ?? '',
                                date: dataTBQT[index].seenDate ?? '',
                                seen: dataTBQT[index].seen ?? false,
                                id: dataTBQT[index].id ?? '',
                                cubit: thongBaoCubit,
                                onTap: () {
                                  (dataTBQT[index].subSystem ?? '')
                                      .getEnumDetail
                                      .getScreenDetail(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget dontData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.icDontData,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            S.current.hien_tai_ban_chua_co_thong_bao,
            style: textNormalCustom(
              color: titleColumn,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

class ThongBaoInherted extends InheritedWidget {
  final ThongBaoCubit thongBaoCubit;

  const ThongBaoInherted({
    Key? key,
    required this.thongBaoCubit,
    required Widget child,
  }) : super(key: key, child: child);

  static ThongBaoInherted of(BuildContext context) {
    final ThongBaoInherted? result =
        context.dependOnInheritedWidgetOfExactType<ThongBaoInherted>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
