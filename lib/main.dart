import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home.dart';

void main() => runApp(const ClinicApp());

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar','EG'),
      supportedLocales: const [Locale('ar','EG')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      theme: ThemeData(
        fontFamily: 'NotoNaskhArabic',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF158F99))
            .copyWith(primary: const Color(0xFF158F99), secondary: const Color(0xFF8E0D2A)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
