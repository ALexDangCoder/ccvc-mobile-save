// import 'package:ccvc_mobile/config/resources/color.dart';
// import 'package:ccvc_mobile/config/resources/styles.dart';
// import 'package:ccvc_mobile/generated/l10n.dart';
// import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
// import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
// import 'package:flutter/material.dart';
//
// class TaiLieuWidget extends StatefulWidget {
//   const TaiLieuWidget({Key? key}) : super(key: key);
//
//   @override
//   _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
// }
//
// class _TaiLieuWidgetState extends State<TaiLieuWidget> {
//   bool isExpand = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20.0.textScale()),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 S.current.tai_lieu,
//                 style: textNormalCustom(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.0.textScale(),
//                   color: unselectedLabelColor,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   isExpand = !isExpand;
//                   setState(() {});
//                 },
//                 child: isExpand
//                     ? const Icon(
//                         Icons.keyboard_arrow_up_rounded,
//                         color: AqiColor,
//                       )
//                     : const Icon(
//                         Icons.keyboard_arrow_down_outlined,
//                         color: AqiColor,
//                       ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 16.5.textScale(),
//           ),
//           ButtonSelectFile(title: S.current.tai_lieu_dinh_kem)
//         ],
//       ),
//     );
//   }
// }
