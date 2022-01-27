import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class ItemSelectModel {
  bool isSelect;
  String text;
  Color? color;

  ItemSelectModel({required this.isSelect, required this.text, this.color});
}

List<ItemSelectModel> listLoaiLich = [
  ItemSelectModel(isSelect: false, text: S.current.lich_cong_tac_trong_nuoc),
  ItemSelectModel(isSelect: false, text: S.current.lich_lam_viec),
  ItemSelectModel(isSelect: false, text: S.current.lich_cong_tac_trong_nuoc),
  ItemSelectModel(isSelect: false, text: S.current.lich_cong_tac_trong_nuoc),
  ItemSelectModel(isSelect: true, text: S.current.lich_cong_tac_trong_nuoc),
];

List<String> listPerson = [
  'Trần Minh Phương',
  'Trần Minh Phương',
];

List<ItemSelectModel> listTime = [
  ItemSelectModel(text: 'Không bao giờ', isSelect: false),
  ItemSelectModel(text: 'Trước 5 phút', isSelect: false),
  ItemSelectModel(text: 'Trước 10 phút', isSelect: false),
  ItemSelectModel(text: 'Trước 15 phút', isSelect: true),
  ItemSelectModel(text: 'Trước 30 phút', isSelect: false),
  ItemSelectModel(text: 'Trước 1 giờ', isSelect: false),
];

List<ItemSelectModel> listColorDefault = [
  ItemSelectModel(
    isSelect: true,
    text: 'Màu mặc định',
    color: choTrinhKyColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu đỏ',
    color: statusCalenderRed,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu cam',
    color: itemWidgetNotUse,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu vàng',
    color: yellowColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu xanh lá cây',
    color: greenColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu xanh lá nhạt',
    color: itemWidgetUsing,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu xanh nước biển',
    color: choXuLyColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu việt quất',
    color: blueberryColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu oải hương',
    color: lavenderColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu nho',
    color: grapeColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu hồng',
    color: pinkColor,
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Màu khói',
    color: smokeColor,
  ),
];

List<ItemSelectModel> listChuTri = [
  ItemSelectModel(
    isSelect: true,
    text: 'Cao Tiến Dũng - UBND Tỉnh Đồng Nai',
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Nguyễn Thị Hoàng - UBND Tỉnh Đồng Nai',
  ),
  ItemSelectModel(
    isSelect: false,
    text: 'Lê Sĩ Lâm - UBND Tỉnh Đồng Nai',
  ),
];

List<ItemSelectModel> listLinhVuc = [
  ItemSelectModel(isSelect: true, text: 'Khác'),
  ItemSelectModel(isSelect: false, text: 'Xúc tiến thương mại'),
  ItemSelectModel(isSelect: false, text: 'Ngoại giao'),
  ItemSelectModel(isSelect: false, text: 'Xuất khẩu lao động'),
];
