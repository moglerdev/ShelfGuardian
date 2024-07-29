import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_controller.dart';
import 'package:shelf_guardian/features/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/features/auth/views/forgot_password_page.dart';
import 'package:shelf_guardian/features/auth/views/sign_in_page.dart';
import 'package:shelf_guardian/features/auth/views/sign_up_page.dart';
import 'package:shelf_guardian/features/editor/views/editor_page.dart';
import 'package:shelf_guardian/features/filter/views/filter_page.dart';
import 'package:shelf_guardian/features/scanner/views/scanner_page.dart';
import 'package:shelf_guardian/features/settings/views/settings_page.dart';
import 'package:shelf_guardian/features/product/views/product_page.dart';
import 'package:shelf_guardian/common/routes_service.dart';

/// The routes configuration for the application.
final routes = GoRouter(
  routes: [
    GoRoute(
      path: NavigationServiceRoutes.signUpRouteUri,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: NavigationServiceRoutes.forgotPasswordRouteUri,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: NavigationServiceRoutes.homeRouteUri,
      builder: (context, state) {
        return BlocBuilder<AuthControllerCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const ProductPage();
            } else {
              return const SignInPage();
            }
          },
        );
      },
    ),
    GoRoute(
      path: NavigationServiceRoutes.scannerRouteUri,
      builder: (context, state) => const ScannerPage(),
    ),
    GoRoute(
      path: NavigationServiceRoutes.createWithBarcodeRouteUri,
      builder: (context, state) {
        final barcode = state.pathParameters['barcode'] ?? '';
        return EditorPage(code: barcode, id: -1);
      },
    ),
    GoRoute(
      path: NavigationServiceRoutes.createRouteUri,
      builder: (context, state) {
        return const EditorPage(code: "", id: -1);
      },
    ),
    GoRoute(
      path: NavigationServiceRoutes.editRouterUri,
      builder: (context, state) {
        final idStr = state.pathParameters['id'] ?? '';
        final id = int.tryParse(idStr) ?? -1;
        return EditorPage(
          code: "",
          id: id,
        );
      },
    ),
    GoRoute(
      path: NavigationServiceRoutes.settingsRouteUri,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: NavigationServiceRoutes.filterRouteUri,
      builder: (context, state) => const FilterPage(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    debugPrint(state.fullPath);
    final isAuthRoute = state.fullPath!.startsWith("/auth");
    final isAuthenticated =
        AuthenticationState.of(context) is AuthenticatedState;

    if (isAuthenticated && isAuthRoute) {
      return NavigationServiceRoutes.homeRouteUri;
    } else if (!isAuthenticated && !isAuthRoute) {
      if (state.fullPath == "/") return null;
      return "/";
    }

    return null;
  },
);
