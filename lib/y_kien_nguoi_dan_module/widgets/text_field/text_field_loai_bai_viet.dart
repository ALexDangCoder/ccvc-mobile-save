// import 'package:ccvc_mobile/config/resources/color.dart';
// import 'package:ccvc_mobile/generated/l10n.dart';
// import 'package:ccvc_mobile/ket_noi_module/widgets/custom_mutil_select/custom_mutil_select.dart';
// import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class TextFieldLoaiBaiViet extends StatefulWidget {
//   final String? hintText;
//   final String urlIcon;
//   final int maxLines;
//   final BuildContext context;
//
//   const TextFieldLoaiBaiViet({
//     Key? key,
//     this.hintText,
//     required this.urlIcon,
//     this.maxLines = 1,
//     required this.context,
//   }) : super(key: key);
//
//   @override
//   State<TextFieldLoaiBaiViet> createState() => _TextFieldLoaiBaiVietState();
// }
//
// class _TextFieldLoaiBaiVietState extends State<TextFieldLoaiBaiViet> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: widget.maxLines == 1
//           ? CrossAxisAlignment.center
//           : CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 16.0.textScale(space: 4),
//           height: 16.0.textScale(space: 4),
//           color: Colors.transparent,
//           child: SvgPicture.asset(widget.urlIcon),
//         ),
//         const SizedBox(
//           width: 14,
//         ),
//         Expanded(
//           child: Container(
//             padding:
//                 EdgeInsets.symmetric(vertical: widget.maxLines == 1 ? 9 : 0),
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(color: lineColor),
//               ),
//             ),
//             child: CustomSelectMultiItems(
//               title: S.current.loai_bai_viet,
//               context: widget.context,
//               items: ['luc', 'ens', 'ss', 'aaa'],
//               onChange: (listIndex) {
//                 // widget.viewmodel.select(listIndex, 1);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
