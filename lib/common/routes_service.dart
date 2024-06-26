class NavigationServiceRoutes {
  static const String _authRouteUri = '/auth';
  static const String signInRouteUri = '$_authRouteUri/sign-in';
  static const String signUpRouteUri = '$_authRouteUri/sign-up';
  static const String forgotPasswordRouteUri = '$_authRouteUri/forgot-password';
  static const String homeRouteUri = '/';
  static const String scannerRouteUri = '/scanner';
  static const String settingsRouteUri = '/settings';
  static const String filterRouteUri = '/filter';

  static const String editorRouteUri = '/editor';
  static const String editorWithIdRouteUri = '$editorRouteUri/:id';
}
