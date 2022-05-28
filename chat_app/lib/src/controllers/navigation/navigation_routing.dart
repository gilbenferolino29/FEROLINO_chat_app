part of 'navigation_service.dart';

PageRoute getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.route:
      return FadeRoute(page: const AuthScreen(), settings: settings);
    case HomeScreen.route:
      return FadeRoute(page: const HomeScreen(), settings: settings);
    case RegisterScreen.route:
      return FadeRoute(page: const RegisterScreen(), settings: settings);
    case LandingScreen.route:
      return FadeRoute(page: const LandingScreen(), settings: settings);
    case SplashScreen.route:
      return FadeRoute(page: const SplashScreen(), settings: settings);
    case ChatScreen.route:
      return SlideRightRoute(page: const ChatScreen(), settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
