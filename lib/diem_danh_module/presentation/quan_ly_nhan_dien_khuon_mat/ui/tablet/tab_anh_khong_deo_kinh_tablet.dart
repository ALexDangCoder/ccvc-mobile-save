import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/type_permission.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_image.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';

class TabAnhKhongDeoKinhTablet extends StatefulWidget {
  final DiemDanhCubit cubit;
  final ImagePermission imagePermission;

  const TabAnhKhongDeoKinhTablet({
    Key? key,
    required this.cubit,
    required this.imagePermission,
  }) : super(key: key);

  @override
  State<TabAnhKhongDeoKinhTablet> createState() =>
      _TabAnhKhongDeoKinhTabletState();
}

class _TabAnhKhongDeoKinhTabletState extends State<TabAnhKhongDeoKinhTablet> {
  @override
  void initState() {
    super.initState();
    widget.cubit
        .getAllImageId(entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return widget.cubit
            .getAllImageId(entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH);
      },
      child: StreamBuilder<List<GetAllFilesIdModel>>(
        stream: widget.cubit.allFileKhongDeokinhStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<GetAllFilesIdModel>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 14,
                childAspectRatio: 1.1,
                children: widget.cubit.listDataKhongDeoKinh
                    .map(
                      (e) => ItemImageWidget(
                        imagePermission: widget.imagePermission,
                        cubit: widget.cubit,
                        dataUI: e,
                        initImage: widget.cubit.getUrlImage(
                          entityName: e.entityName,
                          fileTypeUpload: e.fileTypeUpload,
                        ),
                        id: widget.cubit.findId(
                          entityName: e.entityName,
                          fileTypeUpload: e.fileTypeUpload,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
