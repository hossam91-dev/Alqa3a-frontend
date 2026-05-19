import 'package:alqa3a/core/widgets/main_scaffold.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/halls/presentation/screens/home_screen.dart';
import '../../features/halls/presentation/screens/browse_screen.dart';
import '../../features/halls/presentation/screens/hall_details_screen.dart';
import '../../features/smart_match/presentation/screens/smart_match_screen.dart';
import '../../features/smart_match/presentation/screens/smart_match_results_screen.dart';
import '../../features/bookings/presentation/screens/booking_screen.dart';
import '../../features/bookings/presentation/screens/booking_status_screen.dart';
import '../../features/bookings/presentation/screens/my_bookings_screen.dart';
import '../../features/saved_halls/presentation/screens/saved_halls_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class AppRoutes {
  static const String login          = '/login';
  static const String register       = '/register';
  static const String otp            = '/otp';
  static const String home           = '/home';
  static const String browse         = '/browse';
  static const String hallDetails    = '/halls/:id';
  static const String smartMatch     = '/smart-match';
  static const String smartMatchResults = '/smart-match/results';
  static const String booking        = '/booking/:hallId';
  static const String bookingStatus  = '/bookings/:id/status';
  static const String myBookings     = '/my-bookings';
  static const String savedHalls     = '/saved-halls';
  static const String profile        = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    // ─── Auth ────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) => const OtpScreen(),
    ),

    // ─── Main Shell (Bottom Nav) ─────────────────
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.browse,
          builder: (context, state) => const BrowseScreen(),
        ),
        GoRoute(
          path: AppRoutes.myBookings,
          builder: (context, state) => const MyBookingsScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // ─── Halls ───────────────────────────────────
    GoRoute(
      path: AppRoutes.hallDetails,
      builder: (context, state) => HallDetailsScreen(
        hallId: state.pathParameters['id']!,
      ),
    ),

    // ─── Smart Match ─────────────────────────────
    GoRoute(
      path: AppRoutes.smartMatch,
      builder: (context, state) => const SmartMatchScreen(),
    ),
    GoRoute(
      path: AppRoutes.smartMatchResults,
      builder: (context, state) => const SmartMatchResultsScreen(),
    ),

    // ─── Booking ─────────────────────────────────
    GoRoute(
      path: AppRoutes.booking,
      builder: (context, state) => BookingScreen(
        hallId: state.pathParameters['hallId']!,
      ),
    ),
    GoRoute(
      path: AppRoutes.bookingStatus,
      builder: (context, state) => BookingStatusScreen(
        bookingId: state.pathParameters['id']!,
      ),
    ),

    // ─── Saved Halls ─────────────────────────────
    GoRoute(
      path: AppRoutes.savedHalls,
      builder: (context, state) => const SavedHallsScreen(),
    ),
  ],
);