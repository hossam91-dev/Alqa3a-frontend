import 'package:alqa3a/core/di/service_locator.dart';
import 'package:alqa3a/core/widgets/main_scaffold.dart';
import 'package:alqa3a/shared/auth/domain/entities/user_entity.dart';
import 'package:alqa3a/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:alqa3a/shared/auth/presentation/screens/forgot_password_screen.dart';
import 'package:alqa3a/shared/auth/presentation/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/halls/presentation/cubit/cubit.dart';
import '../../modules/halls/presentation/user/screens/hall_details_screen.dart';
import '../../shared/auth/presentation/screens/login_screen.dart';
import '../../shared/auth/presentation/screens/register_screen.dart';
import '../../shared/auth/presentation/screens/otp_screen.dart';
import '../../modules/halls/presentation/user/screens/home_screen.dart';
import '../../modules/halls/presentation/user/screens/halls_screen.dart';
import '../../modules/smart_match/presentation/screens/smart_match_screen.dart';
import '../../modules/smart_match/presentation/screens/smart_match_results_screen.dart';
import '../../modules/bookings/presentation/screens/booking_screen.dart';
import '../../modules/bookings/presentation/screens/booking_status_screen.dart';
import '../../modules/bookings/presentation/screens/my_bookings_screen.dart';
import '../../modules/saved_halls/presentation/screens/saved_halls_screen.dart';
import '../../modules/profile/presentation/screens/profile_screen.dart';
import '../widgets/splash_screen.dart';

class AppRoutes {
  // Splash
  static const String splash = '/';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';

  // User
  static const String home = '/home';
  static const String halls = '/halls';
  static const String hallDetails = '/halls/:id';
  static const String smartMatch = '/smart-match';
  static const String smartMatchResults = '/smart-match/results';
  static const String booking = '/booking/:hallId';
  static const String bookingStatus = '/bookings/:id/status';
  static const String myBookings = '/my-bookings';
  static const String savedHalls = '/saved-halls';
  static const String profile = '/profile';

  //Hall Owner
  static const String ownerDashboard = '/owner/dashboard';

  //Helpers
  static String hallDetailsPath(String id) => '/halls/$id';

  static String bookingPath(String hallId) => '/booking/$hallId';

  static String bookingStatusPath(String id) => '/bookings/$id/status';

  static String getHomeByRole(UserRole role) {
    return role.isHallOwner ? ownerDashboard : home;
  }
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // Splash
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    // Auth
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthCubit>(),
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) {
        final email = state.extra as String?;
        return BlocProvider(
          create: (_) => sl<AuthCubit>(),

          child: OtpScreen(email: email ?? ''),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: ForgotPasswordScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: ResetPasswordScreen(),
        );
      },
    ),

    // Main Shell (Bottom Nav)
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) =>  BlocProvider(
              create: (_)=> sl<HallsCubit>()..getHomeData(),
              child: HomeScreen()),
        ),
        GoRoute(
          path: AppRoutes.halls,
          builder: (context, state) => BlocProvider(
              create: (_)=> sl<HallsCubit>()..getHalls(),
              child: const HallsScreen()),
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

    // Halls
    GoRoute(
      path: AppRoutes.hallDetails,
      builder: (context, state) =>
          HallDetailsScreen(hallId: state.pathParameters['id']!),
    ),

    // Smart Match
    GoRoute(
      path: AppRoutes.smartMatch,
      builder: (context, state) => const SmartMatchScreen(),
    ),
    GoRoute(
      path: AppRoutes.smartMatchResults,
      builder: (context, state) => const SmartMatchResultsScreen(),
    ),

    // Booking
    GoRoute(
      path: AppRoutes.booking,
      builder: (context, state) =>
          BookingScreen(hallId: state.pathParameters['hallId']!),
    ),
    GoRoute(
      path: AppRoutes.bookingStatus,
      builder: (context, state) =>
          BookingStatusScreen(bookingId: state.pathParameters['id']!),
    ),

    // Saved Halls
    GoRoute(
      path: AppRoutes.savedHalls,
      builder: (context, state) => const SavedHallsScreen(),
    ),

    // Hall Owner
    GoRoute(
      path: AppRoutes.ownerDashboard,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Owner Dashboard — Coming Soon')),
      ),
    ),
  ],
);
