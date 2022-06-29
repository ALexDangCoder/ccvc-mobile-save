import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'ho_tro_ky_thuat_service.g.dart';

@RestApi()
abstract class HoTroKyThuatService {
  @factoryMethod
  factory HoTroKyThuatService(Dio dio, {String baseUrl}) = _HoTroKyThuatService;
}
