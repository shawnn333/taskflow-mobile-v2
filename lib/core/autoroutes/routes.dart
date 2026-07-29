import 'package:auto_route/auto_route.dart';
import 'package:taskflow_mobile/core/autoroutes/authguard.dart';
import 'package:taskflow_mobile/core/autoroutes/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final _authGuard = AuthGuard();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: TodoRoute.page, guards: [_authGuard]),
      ];
}
