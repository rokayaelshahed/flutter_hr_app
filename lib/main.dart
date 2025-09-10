import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/views/screens/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        locale: const Locale('ar'),

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.cairoTextTheme(),

          colorScheme: const ColorScheme.light(
            primary: Color(0xFF1F1F1F), // header/selected day
            onPrimary: Colors.white, // text on primary
            surface: Colors.white, // dialog bg
            onSurface: Color(0xFF1F1F1F),
            // default text/icons
          ),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
          ),
          timePickerTheme: TimePickerThemeData(

              dayPeriodColor : Colors.grey[400],
          )
        ),
        // ThemeData(
        //   scaffoldBackgroundColor: Colors.white,
        //   dialogBackgroundColor: Colors.white,
        //   canvasColor: Colors.white,
        //   textTheme: GoogleFonts.cairoTextTheme(),
        //  // fontFamily: 'Nunito',
        // ),
        home: LoginPage(),
        //HomeCheckInPage()
        //LoginPage(),
      ),
    );
  }
}
