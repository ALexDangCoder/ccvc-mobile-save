import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_cubit.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/widget/item_thong_bao_quan_trong.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongBaoQuanLyVanBanScreen extends StatefulWidget {
  final ThongBaoCubit cubit;

  const ThongBaoQuanLyVanBanScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<ThongBaoQuanLyVanBanScreen> createState() =>
      _ThongBaoQuanLyVanBanScreenState();
}

class _ThongBaoQuanLyVanBanScreenState
    extends State<ThongBaoQuanLyVanBanScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getListThongBao();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.cubit.getListThongBao();
      },
      child: StateStreamLayout(
        stream: widget.cubit.stateStream,
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
                onTap: () {},
                child: SvgPicture.asset(ImageAssets.icPickAll),
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
          body: StreamBuilder<ThongBaoQuanTrongModel>(
            stream: widget.cubit.getListNotiStream,
            builder: (context, snapshot) {
              final data = snapshot.data?.items ?? [];
              if (data.isEmpty) {
                return dontData();
              }

             else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemThongBaoQuanTrong(
                      title: data[index].title ?? '',
                      message: data[index].message ?? '',
                      date: data[index].seenDate ?? '',
                      seen: data[index].seen ?? false,
                      id: data[index].id ?? '',
                      cubit: widget.cubit,
                    );
                  },
                );
              }
            },
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
