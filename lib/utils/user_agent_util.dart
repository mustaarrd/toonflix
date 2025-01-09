import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';

class UserAgentUtil {
  static Future<String> getDynamicUserAgent() async {
    // 플랫폼 정보
    final os = Platform.operatingSystem; // 예: android, ios, windows
    final osVersion = Platform.operatingSystemVersion; // 운영체제 버전

    // 앱 정보
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.appName; // 예: MyFlutterApp
    final appVersion = packageInfo.version; // 예: 1.0.0

    // 동적 User-Agent 생성
    final userAgent = "$appName/$appVersion ($os; $osVersion)";
    return userAgent;
  }
}

class MyHttpOverrides extends HttpOverrides {
  final String userAgent;

  MyHttpOverrides(this.userAgent);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..userAgent = userAgent;
  }
}

Future<void> setupHttpOverrides() async {
  // 비동기적으로 User-Agent 로드
  final userAgent = await UserAgentUtil.getDynamicUserAgent();

  // HttpOverrides 설정
  HttpOverrides.global = MyHttpOverrides(userAgent);
}
