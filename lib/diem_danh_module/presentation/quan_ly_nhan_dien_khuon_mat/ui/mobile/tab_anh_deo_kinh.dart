import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/extension/quan_ly_nhan_dien_khuon_mat_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/widget/item_image.dart';
import 'package:flutter/material.dart';

class TabAnhDeoKinh extends StatefulWidget {
  final DiemDanhCubit cubit;

  const TabAnhDeoKinh({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TabAnhDeoKinh> createState() => _TabAnhDeoKinhState();
}

class _TabAnhDeoKinhState extends State<TabAnhDeoKinh> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getAllImageDeoKinhId();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return widget.cubit.getAllImageDeoKinhId();
      },
      child: StreamBuilder<GetAllFilesIdModel>(
        stream: widget.cubit.allFileDeokinhStream,
        initialData: GetAllFilesIdModel.empty(),
        builder:
            (BuildContext context, AsyncSnapshot<GetAllFilesIdModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: widget.cubit.listDataDeoKinh
                    .map(
                      (e) => ItemImageWidget(
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
