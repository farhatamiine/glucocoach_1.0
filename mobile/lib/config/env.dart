import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'http://141.94.121.93:8080')
  static const String apiBaseUrl = _Env.apiBaseUrl;
}
