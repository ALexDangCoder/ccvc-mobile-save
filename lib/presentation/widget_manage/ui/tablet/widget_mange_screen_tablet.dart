import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage_cubit.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/mobile/prev_view_widget.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/tablet/prev_view_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/drag_item_list.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/widgets/item_not%20_use.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class WidgetManageScreenTablet extends StatefulWidget {
  const WidgetManageScreenTablet({Key? key}) : super(key: key);

  @override
  _WidgetManageScreenTabletState createState() =>
      _WidgetManageScreenTabletState();
}

class _WidgetManageScreenTabletState extends State<WidgetManageScreenTablet> {
  WidgetManageCubit widgetManageCubit = WidgetManageCubit();
  GlobalKey globalKey=GlobalKey();
  late double  height=0;
  final BehaviorSubject<double> setHeight = BehaviorSubject.seeded(0);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widgetManageCubit.loadApi();
     widgetManageCubit.listWidgetUsing.listen((event) {
       final renderBox =
       globalKey.currentContext?.findRenderObject() as RenderBox;
       height = renderBox.size.height;
       setHeight.sink.add(height);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   backgroundColor: bgWidgets,
    //   appBar: BaseAppBar(
    //     title: S.current.widget_manage,
    //     leadingIcon: IconButton(
    //       onPressed: () => {Navigator.pop(context)},
    //       icon: SvgPicture.asset(
    //         ImageAssets.icBack,
    //       ),
    //     ),
    //     actions: [
    //       GestureDetector(
    //         child: Center(
    //           child: Text(
    //             S.current.mac_dinh,
    //             style: textNormalCustom(
    //               fontWeight: FontWeight.w700,
    //               fontSize: 16,
    //               color: AppTheme.getInstance().colorField(),
    //             ),
    //           ),
    //         ),
    //         onTap: () {
    //           widgetManageCubit.resetListWidget();
    //         },
    //       ),
    //     ],
    //   ),
    //   body: StateStreamLayout(
    //     textEmpty: S.current.khong_co_du_lieu,
    //     retry: () {},
    //     error: AppException(
    //       S.current.error,
    //       S.current.error,
    //     ),
    //     stream: widgetManageCubit.stateStream,
    //     child: RefreshIndicator(
    //       onRefresh: () async {
    //         await widgetManageCubit.onRefreshData();
    //       },
    //       child: Stack(
    //         children: [
    //           // StreamBuilder<double>(
    //           //   stream: setHeight.stream,
    //           //   builder: (context, snapshot){
    //           //     return Positioned.fill(
    //           //       child: Container(),
    //           //     );
    //           //   },
    //           // ),
    //           StreamBuilder<List<WidgetModel>>(
    //             stream: widgetManageCubit.listWidgetUsing,
    //             builder: (context, snapshot) {
    //               final data = snapshot.data ?? [];
    //               if (data.isNotEmpty) {
    //                 final List<WidgetModel> listWidgetUsing = data;
    //                 return DragItemList(
    //                   key: globalKey,
    //                   headerList: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Container(color: Colors.blue,height: 700,),
    //                       const SizedBox(
    //                         height: 12,
    //                       ),
    //                       Container(
    //                         padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
    //                         height: 45,
    //                         width: double.maxFinite,
    //                         decoration: BoxDecoration(
    //                           color: backgroundWidget,
    //                           borderRadius: BorderRadius.circular(8),
    //                         ),
    //                         child: Row(
    //                           children: [
    //                             SvgPicture.asset(ImageAssets.icHoiChamTron),
    //                             const SizedBox(
    //                               width: 14,
    //                             ),
    //                             Text(
    //                               S.current.keep_drop,
    //                               style: textNormalCustom(
    //                                 color: textTitle,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       Text(
    //                         S.current.using,
    //                         style: textNormalCustom(
    //                           color: itemWidgetUsing,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                     ],
    //                   ),
    //                   footerList: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       Text(
    //                         S.current.not_use,
    //                         style: textNormalCustom(
    //                           color: itemWidgetNotUse,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       StreamBuilder<List<WidgetModel>>(
    //                         stream: widgetManageCubit.listWidgetNotUse,
    //                         builder: (context, snapshot) {
    //                           final data = snapshot.data ?? [];
    //                           if (data.isNotEmpty) {
    //                             final List<WidgetModel> listWidgetNotUse = data;
    //                             return ListView.builder(
    //                               physics: const NeverScrollableScrollPhysics(),
    //                               shrinkWrap: true,
    //                               itemCount: data.length,
    //                               itemBuilder: (context, index) {
    //                                 return ItemWidgetNotUse(
    //                                   widgetItem: listWidgetNotUse[index],
    //                                   cubit: widgetManageCubit,
    //                                   index: index,
    //                                   contentWidget: listWidgetNotUse[index].name,
    //                                 );
    //                               },
    //                             );
    //                           } else {
    //                             return Padding(
    //                               padding: const EdgeInsets.only(bottom: 16),
    //                               child: Center(
    //                                 child: Text(S.current.no_data),
    //                               ),
    //                             );
    //                           }
    //                         },
    //                       ),
    //                       ButtonCustomBottom(
    //                         border: 4.0,
    //                         title: S.current.xem_truoc,
    //                         isColorBlue: true,
    //                         onPressed: () {
    //                           Navigator.push(
    //                             context,
    //                             PageRouteBuilder(
    //                               pageBuilder: (_, __, ___) => PrevViewWidget(
    //                                 cubit: widgetManageCubit,
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                       const SizedBox(
    //                         height: 24,
    //                       ),
    //                     ],
    //                   ),
    //                   listWidget: listWidgetUsing,
    //                   widgetManageCubit: widgetManageCubit,
    //                   isUsing: true,
    //                 );
    //               } else {
    //                 return DragItemList(
    //                   headerList: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       const SizedBox(
    //                         height: 12,
    //                       ),
    //                       Container(
    //                         padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
    //                         height: 45,
    //                         width: double.maxFinite,
    //                         decoration: BoxDecoration(
    //                           color: backgroundWidget,
    //                           borderRadius: BorderRadius.circular(8),
    //                         ),
    //                         child: Row(
    //                           children: [
    //                             SvgPicture.asset(ImageAssets.icHoiChamTron),
    //                             const SizedBox(
    //                               width: 14,
    //                             ),
    //                             Text(
    //                               S.current.keep_drop,
    //                               style:textNormalCustom(color: textTitle),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       Text(
    //                         S.current.using,
    //                         style: textNormalCustom(
    //                           color: itemWidgetUsing,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       Center(
    //                         child: Text(S.current.no_data),
    //                       ),
    //                     ],
    //                   ),
    //                   footerList: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       Text(
    //                         S.current.not_use,
    //                         style: textNormalCustom(
    //                           color: itemWidgetNotUse,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 16,
    //                       ),
    //                       StreamBuilder<List<WidgetModel>>(
    //                         stream: widgetManageCubit.listWidgetNotUse,
    //                         builder: (context, snapshot) {
    //                           final data = snapshot.data ?? [];
    //                           if (data.isNotEmpty) {
    //                             final List<WidgetModel> listWidgetNotUse = data;
    //                             return ListView.builder(
    //                               physics: const NeverScrollableScrollPhysics(),
    //                               shrinkWrap: true,
    //                               itemCount: data.length,
    //                               itemBuilder: (context, index) {
    //                                 return ItemWidgetNotUse(
    //                                   widgetItem: listWidgetNotUse[index],
    //                                   cubit: widgetManageCubit,
    //                                   index: index,
    //                                   contentWidget: listWidgetNotUse[index].name,
    //                                 );
    //                               },
    //                             );
    //                           } else {
    //                             return Padding(
    //                               padding: const EdgeInsets.only(bottom: 16),
    //                               child: Center(
    //                                 child: Text(S.current.no_data),
    //                               ),
    //                             );
    //                           }
    //                         },
    //                       ),
    //                       ButtonCustomBottom(
    //                         border: 4.0,
    //                         title: S.current.xem_truoc,
    //                         isColorBlue: true,
    //                         onPressed: () {
    //                           Navigator.push(
    //                             context,
    //                             PageRouteBuilder(
    //                               pageBuilder: (_, __, ___) => PrevViewWidget(
    //                                 cubit: widgetManageCubit,
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                       const SizedBox(
    //                         height: 24,
    //                       ),
    //                     ],
    //                   ),
    //                   listWidget: const [],
    //                   widgetManageCubit: widgetManageCubit,
    //                   isUsing: true,
    //                 );
    //               }
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //
    //   // body: StateStreamLayout(
    //   //   textEmpty: S.current.khong_co_du_lieu,
    //   //   retry: () {},
    //   //   error: AppException(
    //   //     S.current.error,
    //   //     S.current.error,
    //   //   ),
    //   //   stream: widgetManageCubit.stateStream,
    //   //   child: RefreshIndicator(
    //   //     onRefresh: () async {
    //   //       await widgetManageCubit.onRefreshData();
    //   //     },
    //   //     child: SingleChildScrollView(
    //   //       physics: const AlwaysScrollableScrollPhysics(),
    //   //       child: Column(
    //   //         children: [
    //   //           Container(
    //   //             padding: const EdgeInsets.fromLTRB(30, 28, 30, 5),
    //   //             child: Container(
    //   //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //   //               decoration: BoxDecoration(
    //   //                 borderRadius: BorderRadius.circular(12),
    //   //                 border: Border.all(
    //   //                   color: borderColor.withOpacity(0.5),
    //   //                 ),
    //   //                 color: backgroundColorApp,
    //   //               ),
    //   //               child: Column(
    //   //                 crossAxisAlignment: CrossAxisAlignment.start,
    //   //                 children: [
    //   //                   const SizedBox(
    //   //                     height: 20,
    //   //                   ),
    //   //                   Row(
    //   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   //                     children: [
    //   //                       Row(
    //   //                         children: [
    //   //                           SvgPicture.asset(ImageAssets.ic_hoicham),
    //   //                           const SizedBox(
    //   //                             width: 8,
    //   //                           ),
    //   //                           Text(
    //   //                             S.current.keep_drop,
    //   //                             style: textNormal(
    //   //                               textTitle,
    //   //                               14.0.textScale(),
    //   //                             ),
    //   //                           ),
    //   //                         ],
    //   //                       ),
    //   //                     ],
    //   //                   ),
    //   //                   const SizedBox(
    //   //                     height: 28,
    //   //                   ),
    //   //                   Text(
    //   //                     S.current.using,
    //   //                     style: textNormalCustom(
    //   //                       color: itemWidgetUsing,
    //   //                       fontSize: 16.0.textScale(),
    //   //                     ),
    //   //                   ),
    //   //                   const SizedBox(
    //   //                     height: 16,
    //   //                   ),
    //   //                   StreamBuilder<List<WidgetModel>>(
    //   //                     stream: widgetManageCubit.listWidgetUsing,
    //   //                     builder: (context, snapshot) {
    //   //                       final data = snapshot.data ?? [];
    //   //                       if (data.isNotEmpty) {
    //   //                         final List<WidgetModel> listWidgetUsing = data;
    //   //                         return DragItemList(
    //   //                           headerList: const SizedBox(),
    //   //                           footerList: const SizedBox(),
    //   //                           listWidget: listWidgetUsing,
    //   //                           widgetManageCubit: widgetManageCubit,
    //   //                           isUsing: true,
    //   //                         );
    //   //                       } else {
    //   //                         return Center(
    //   //                           child: Text(S.current.no_data),
    //   //                         );
    //   //                       }
    //   //                     },
    //   //                   ),
    //   //                   const SizedBox(
    //   //                     height: 20,
    //   //                   ),
    //   //                   Text(
    //   //                     S.current.not_use,
    //   //                     style: textNormalCustom(
    //   //                       color: itemWidgetNotUse,
    //   //                       fontSize: 16.0.textScale(),
    //   //                     ),
    //   //                   ),
    //   //                   const SizedBox(
    //   //                     height: 24,
    //   //                   ),
    //   //                   StreamBuilder<List<WidgetModel>>(
    //   //                     stream: widgetManageCubit.listWidgetNotUse,
    //   //                     builder: (context, snapshot) {
    //   //                       final data = snapshot.data ?? [];
    //   //                       if (data.isNotEmpty) {
    //   //                         final List<WidgetModel> listWidgetNotUse = data;
    //   //                         return DragItemList(
    //   //                           headerList: const SizedBox(),
    //   //                           footerList: const SizedBox(),
    //   //                           listWidget: listWidgetNotUse,
    //   //                           widgetManageCubit: widgetManageCubit,
    //   //                           isUsing: false,
    //   //                         );
    //   //                       } else {
    //   //                         return Center(
    //   //                           child: Text(S.current.no_data),
    //   //                         );
    //   //                       }
    //   //                     },
    //   //                   ),
    //   //                   const SizedBox(
    //   //                     height: 28,
    //   //                   ),
    //   //                 ],
    //   //               ),
    //   //             ),
    //   //           ),
    //   //           const SizedBox(
    //   //             height: 28,
    //   //           ),
    //   //           Center(
    //   //             child: SizedBox(
    //   //               width: 160,
    //   //               height: 44,
    //   //               child: ButtonCustomBottom(
    //   //                 border: 8,
    //   //                 title: S.current.xem_truoc,
    //   //                 isColorBlue: true,
    //   //                 onPressed: () {
    //   //                   Navigator.push(
    //   //                     context,
    //   //                     PageRouteBuilder(
    //   //                       pageBuilder: (_, __, ___) =>
    //   //                           const PrevViewWidgetTablet(),
    //   //                     ),
    //   //                   );
    //   //                 },
    //   //                 size: 16.0,
    //   //               ),
    //   //             ),
    //   //           ),
    //   //           const SizedBox(
    //   //             height: 28,
    //   //           ),
    //   //         ],
    //   //       ),
    //   //     ),
    //   //   ),
    //   // ),
    // );
  }
}
