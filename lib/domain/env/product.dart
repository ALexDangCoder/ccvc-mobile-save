import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonLiteral('product.json', asConst: true)
Map<String, dynamic> get configProductEnv => _$configProductEnvJsonLiteral;
