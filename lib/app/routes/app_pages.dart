import 'package:Findings/app/modules/searchFindings/views/search_result_view.dart';
import 'package:get/get.dart';

import '../modules/createUsers/bindings/create_users_binding.dart';
import '../modules/createUsers/views/create_users_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/fileFindings/bindings/file_findings_binding.dart';
import '../modules/fileFindings/views/file_findings_view.dart';
import '../modules/findingsApproval/bindings/findings_approval_binding.dart';
import '../modules/findingsApproval/views/findings_approval_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchFindings/bindings/search_findings_binding.dart';
import '../modules/searchFindings/views/search_findings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/submittedFindings/bindings/submitted_findings_binding.dart';
import '../modules/submittedFindings/views/edit_submitted_findings_view.dart';
import '../modules/submittedFindings/views/submitted_findings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_FINDINGS,
      page: () => const SearchFindingsView(),
      binding: SearchFindingsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RESULT_FINDINGS,
      page: () => SearchResultFindingsView(),
      binding: SearchFindingsBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.FILE_FINDINGS,
      page: () => const FileFindingsView(),
      binding: FileFindingsBinding(),
    ),
    GetPage(
      name: _Paths.SUBMITTED_FINDINGS,
      page: () => const SubmittedFindingsView(),
      binding: SubmittedFindingsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_SUBMITTED_FINDINGS,
      page: () => EditSubmittedFindingsView(),
      binding: SubmittedFindingsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_USERS,
      page: () => const CreateUsersView(),
      binding: CreateUsersBinding(),
    ),
    GetPage(
      name: _Paths.FINDINGS_APPROVAL,
      page: () => const FindingsApprovalView(),
      binding: FindingsApprovalBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
