import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quan_li_widget_response.g.dart';

@JsonSerializable()
class QuanLyWidgetResponse {
  @JsonKey(name: 'data')
  List<WidgetData> listWidget;

  QuanLyWidgetResponse(this.listWidget);

  factory QuanLyWidgetResponse.fromJson(Map<String, dynamic> json) =>
      _$QuanLyWidgetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuanLyWidgetResponseToJson(this);

  List<WidgetModel> toDomain() {
    return listWidget.map((e) => e.toDomain()).toList();
  }
}

@JsonSerializable()
class WidgetData {
  @JsonKey(name: 'id')
  String? id = '';
  @JsonKey(name: 'name')
  String? name = '';
  @JsonKey(name: 'widgetTypeId')
  String? widgetTypeId;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'width')
  int? width;
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'minWidth')
  int? minWidth;
  @JsonKey(name: 'minHeight')
  int? minHeight;
  @JsonKey(name: 'maxHeight')
  int? maxHeight;
  @JsonKey(name: 'maxWidth')
  int? maxWidth;
  @JsonKey(name: 'component')
  String? component = '';
  @JsonKey(name: 'static')
  bool? static;
  @JsonKey(name: 'isResizable')
  bool? isResizable;
  @JsonKey(name: 'thumbnail')
  String? thumbnail;
  @JsonKey(name: 'appId')
  String? appId;
  @JsonKey(name: 'order')
  int? order;
  @JsonKey(name: 'isShowing')
  bool? isShowing;
  @JsonKey(name: 'x')
  int? x;
  @JsonKey(name: 'y')
  int? y;
  // @JsonKey(name: 'i')
  // String? i;
  @JsonKey(name: 'enable')
  bool? enable;
  @JsonKey(name: 'moved')
  bool? moved;
  @JsonKey(name: 'w')
  int? w;
  @JsonKey(name: 'h')
  int? h;
  @JsonKey(name: 'maxH')
  int? maxH;
  @JsonKey(name: 'maxW')
  int? maxW;
  @JsonKey(name: 'minH')
  int? minH;
  @JsonKey(name: 'minW')
  int? minW;
  WidgetData(this.id, this.name, this.component);

  factory WidgetData.fromJson(Map<String, dynamic> json) =>
      _$WidgetDataFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetDataToJson(this);

  WidgetModel toDomain() => WidgetModel(
    id: id ?? '',
    name: name ?? '',
    component: component??'',
    widgetTypeId: widgetTypeId,
    description: description,
    code: code,
    width: width ?? 0,
    height: height ?? 0,
    minWidth: minWidth ?? 0,
    minHeight: minHeight ?? 0,
    maxHeight: maxHeight ?? 0,
    maxWidth: maxWidth ?? 0,
    static: static ?? false,
    isResizable: isResizable ?? false,
    thumbnail: thumbnail ?? '',
    appId: appId ?? '',
    order: order ?? 0,
    isShowing: isShowing ?? false,
    x: x ?? 0,
    y: y ?? 0,
    // i: i ?? '',
    enable: enable ?? false,
    moved: moved ?? false,
    w: w ?? 0,
    h: h ?? 0,
    maxH: maxH ?? 0,
    maxW: maxW ?? 0,
    minH: minH ?? 0,
    minW: minW ?? 0,
      );
}
