import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/routes/app_pages.dart';
import 'package:kkw_blog/src/core/values/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        Size size = ScreenUtil.defaultSize;

        if (sizingInformation.isDesktop) {
          size = const Size(1440, 1024);
        } else if (sizingInformation.isMobile) {
          size = const Size(360, 1024);
        }

        return ScreenUtilInit(
          designSize: size,
          builder: (context, child) => MaterialApp.router(
            localizationsDelegates: const [
              Messages.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: Messages.delegate.supportedLocales,
            theme: AppTheme.lightTheme,
            highContrastTheme: AppTheme.lightHighContrastThemeData,
            darkTheme: AppTheme.darkTheme,
            highContrastDarkTheme: AppTheme.darkHighContrastThemeData,
            themeMode: ThemeMode.dark,
            routerConfig: AppPages.routeConfigs,
          ),
        );
      },
    );
  }
}
