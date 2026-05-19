import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/models.dart';

part 'api_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth
  @POST('/api/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/api/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/api/auth/refresh')
  Future<AuthResponse> refresh(@Body() RefreshRequest request);

  @POST('/api/auth/logout')
  Future<void> logout(@Body() RefreshRequest request);

  @POST('/api/auth/forget-password')
  Future<String> forgetPassword(@Body() ForgetPasswordRequest request);

  @POST('/api/auth/reset-password')
  Future<String> resetPassword(@Body() ResetPasswordRequest request);

  // User
  @GET('/api/users/me')
  Future<UserResponse> getMe();

  @PUT('/api/users/me')
  Future<UserResponse> updateMe(@Body() UserRequest request);

  @DELETE('/api/users/me')
  Future<void> deleteMe();

  @PUT('/api/users/change-password')
  Future<void> changePassword(@Body() ChangePasswordRequest request);

  @PATCH('/api/users/fcm-token')
  Future<void> updateFcmToken(@Body() FcmTokenRequest request);

  // Profile
  @GET('/api/profile')
  Future<ProfileResponse> getProfile();

  @POST('/api/profile')
  Future<ProfileResponse> createProfile(@Body() ProfileRequest request);

  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(@Body() ProfileRequest request);

  // Meals
  @GET('/api/meals')
  Future<List<MealResponse>> getMeals();

  @POST('/api/meals')
  Future<MealResponse> createMeal(@Body() MealRequest request);

  @GET('/api/meals/{id}')
  Future<MealResponse> getMeal(@Path('id') int id);

  @PUT('/api/meals/{id}')
  Future<MealResponse> updateMeal(
    @Path('id') int id,
    @Body() MealRequest request,
  );

  @DELETE('/api/meals/{id}')
  Future<void> deleteMeal(@Path('id') int id);

  @POST('/api/meals/{id}/image')
  @MultiPart()
  Future<MealResponse> uploadMealImage(
    @Path('id') int id,
    @Part(name: 'file') List<int> file,
  );

  // Bolus
  @GET('/api/bolus')
  Future<List<BolusResponse>> getBoluses();

  @POST('/api/bolus')
  Future<BolusResponse> createBolus(@Body() BolusRequest request);

  @DELETE('/api/bolus/{id}')
  Future<void> deleteBolus(@Path('id') int id);

  // Alerts
  @GET('/api/alerts')
  Future<List<AlertResponse>> getAlerts();

  @POST('/api/alerts')
  Future<AlertResponse> createAlert(@Body() AlertRequest request);

  @PUT('/api/alerts/{id}')
  Future<AlertResponse> updateAlert(
    @Path('id') int id,
    @Body() AlertRequest request,
  );

  @DELETE('/api/alerts/{id}')
  Future<void> deleteAlert(@Path('id') int id);

  // Alert History
  @GET('/api/alert-history')
  Future<List<AlertHistoryResponse>> getAlertHistory();

  // Glucose
  @GET('/api/glucose/health-data')
  Future<GlucoseSummaryResponse> getHealthData(
    @Query('days') int days,
  );

  @GET('/api/glucose/trend')
  Future<Map<String, dynamic>> getTrend();

  @GET('/api/glucose/tir-by-day')
  Future<Map<String, dynamic>> getTirByDay(
    @Query('days') int days,
  );

  @GET('/api/glucose/agp')
  Future<Map<String, dynamic>> getAgp(
    @Query('days') int days,
  );

  @GET('/api/glucose/daily-average-by-hour')
  Future<Map<String, dynamic>> getDailyAverageByHour(
    @Query('days') int days,
  );

  @GET('/api/glucose/rapid-events')
  Future<Map<String, dynamic>> getRapidEvents(
    @Query('days') int days,
  );

  @GET('/api/glucose/risk')
  Future<Map<String, dynamic>> getRisk(
    @Query('days') int days,
  );

  @GET('/api/glucose/insulin-sensitivity')
  Future<Map<String, dynamic>> getInsulinSensitivity(
    @Query('days') int days,
  );

  // Health Data
  @GET('/api/health-data')
  Future<List<HealthDataResponse>> getHealthDataEntries();

  @POST('/api/health-data')
  Future<HealthDataResponse> createHealthData(@Body() HealthDataRequest request);

  @DELETE('/api/health-data/{id}')
  Future<void> deleteHealthData(@Path('id') int id);

  // Labo
  @GET('/api/labo')
  Future<List<LaboAnalysisResponse>> getLaboAnalyses();

  @POST('/api/labo')
  Future<LaboAnalysisResponse> createLaboAnalysis(@Body() LaboAnalysisRequest request);

  @PUT('/api/labo/{id}')
  Future<LaboAnalysisResponse> updateLaboAnalysis(
    @Path('id') int id,
    @Body() LaboAnalysisRequest request,
  );

  @DELETE('/api/labo/{id}')
  Future<void> deleteLaboAnalysis(@Path('id') int id);
}
