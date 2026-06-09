abstract class ApiConstants {
  static const String baseUrl = 'https://alqa3a.up.railway.app/api/v1';

  // Authentication Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String userProfileEndpoint = '/auth/me';
  static const String googleSignInEndpoint = '/auth/google/token';
  static const String sendOtpEndpoint = '/auth/send-otp';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';

  // Halls Endpoints
  static const String hallsEndpoint = '/halls';
  static const String popularHallsEndpoint = '$hallsEndpoint/popular';
  static const String hallsWithDiscountsEndpoint = '$hallsEndpoint/with-discounts';

  // Blocked Dates Endpoints
  static const String blockedDatesEndpoint = '/blocked-dates';

  // Bookings Endpoints
  static const String bookingsEndpoint = '/bookings';
  static const String userBookingsEndpoint = '$bookingsEndpoint/my';
  static const String cancelBooking = '/cancel';

  // Smart Match Endpoints
  static const String smartMatchEndpoint = '/smart-match';

  // Saved Halls Endpoints
  static const String savedHallsEndpoint = '/saved-halls';

  // Upload Image Endpoint
  static const String uploadImageEndpoint = '/upload';

  // Discounts Endpoints
  static const String discountsEndpoint = '/discounts';
  static const String activeDiscountEndpoint = 'discounts/hall/active';
}