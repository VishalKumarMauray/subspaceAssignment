import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:subspace/UI/splash/splash.dart';
import 'package:subspace/data/repository/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<HomeRepository>.value(
      value: HomeRepository(),
      child: ScreenUtilInit(
        designSize: const Size(423, 803),
        useInheritedMediaQuery: true,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog Assignment',
            theme: ThemeData(
              useMaterial3: true,
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: const SplashPage(),
            // initialRoute: SplashPage.route,
          );
        },
      ),
    );
  }
}

