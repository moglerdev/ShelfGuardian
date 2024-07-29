/// A class that defines the route URIs used in the navigation service.
class NavigationServiceRoutes {
  static const String _authRouteUri = '/auth';
  static const String signInRouteUri = '/';
  static const String signUpRouteUri = '$_authRouteUri/sign-up';
  static const String forgotPasswordRouteUri = '$_authRouteUri/forgot-password';
  static const String homeRouteUri = '/';
  static const String scannerRouteUri = '/scanner';
  static const String settingsRouteUri = '/settings';
  static const String filterRouteUri = '/filter';

  static const String _editorRouteUri = '/editor';
  static const String editRouterUri = '$_editorRouteUri/open/:id';
  static const String createWithBarcodeRouteUri =
      '$_editorRouteUri/create/:barcode';
  static const String createRouteUri = '$_editorRouteUri/create';
}
