class AppConstants {
  static const String appName = 'GlucoCoach';
  static const String jwtAccessTokenKey = 'access_token';
  static const String jwtRefreshTokenKey = 'refresh_token';
  static const String tokenTypeKey = 'token_type';
  static const int connectionTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;
}

class GlucoseRanges {
  static const double low = 70.0;
  static const double veryLow = 54.0;
  static const double high = 180.0;
  static const double veryHigh = 250.0;
  static const double targetLow = 70.0;
  static const double targetHigh = 180.0;
}
