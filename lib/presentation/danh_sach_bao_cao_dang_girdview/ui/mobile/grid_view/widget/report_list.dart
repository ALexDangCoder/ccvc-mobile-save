import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/widget/item_gridview.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/widget/item_list.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/item_chi_tiet.dart';
import 'package:flutter/material.dart';



class ReportList extends StatelessWidget {
  const ReportList({
    Key? key,
    required this.isCheckList,
  }) : super(key: key);
  final bool isCheckList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: isCheckList
            ? GridView.builder(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 17,
                  crossAxisSpacing: 17,
                  childAspectRatio: 1.5,
                  mainAxisExtent: 130,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return ItemGridView();
                },
              )
            : Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: ListView.builder(
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ItemChiTiet(),
                          ),
                        );
                      },
                      child: const ItemList(),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
