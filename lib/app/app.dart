import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_solution_task/presentation/screens/splash_screen.dart';

import 'package:sizer/sizer.dart';
// import 'package:device_preview/device_preview.dart';

import '../presentation/cubit/create_account/create_account_cubit.dart';
import '../presentation/cubit/domain/domain_cubit.dart';
import '../presentation/cubit/email_details/email_details_cubit.dart';
import '../presentation/cubit/home/home_cubit.dart';
import '../presentation/cubit/login/login_cubit.dart';
import '../presentation/cubit/splash/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EmailDetailsCubit()),
          BlocProvider(create: (context) => SplashCubit()),
          BlocProvider(create: (context) => DomainCubit()),
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => CreateAccountCubit()),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.system,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                foregroundColor: Colors.white,
                backgroundColor:
                    const Color(0xffF5C754), // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ), // Padding
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor:
                    const Color(0xff29384D), // Button background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ), // Padding
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xffE5E5E5), // Background color
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color:
                      Color(0xffE5E5E5), // Same as fill color for seamless look
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffC0C0C0), // Slightly darker than fill color
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xffC0C0C0), // Slightly darker than fill color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xff8A9EBF),
                ),
              ),
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            colorScheme: const ColorScheme(
              primary: Color(0xffF5C754),
              onPrimary: Colors.white,
              secondary: Color(0xff8A9EBF),
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              surface: Color(0xffE5E5E5),
              onSurface: Colors.black,
              brightness: Brightness.light,
            ),
            // Add other theme properties as needed
          ),
          darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF121C24),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffF5C754), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12), // Padding
              )),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: const Color(0xff29384D),
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              )),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color(
                    0xff212833), // Slightly darker than background for contrast
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(
                        0xff212833), // Same as fill color for seamless look
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(
                        0xff33405C), // Same as fill color for seamless look
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(
                        0xff33405C), // Same as fill color for seamless look
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xff8A9EBF),
                  ),
                ),
                hintStyle: const TextStyle(color: Colors.white70),
              ),
              colorScheme: const ColorScheme(
                primary: Color(0xffF5C754),
                onPrimary: Color(0xff212833),
                secondary: Color(0xff8A9EBF),
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                surface: Color(0xff212833),
                onSurface: Colors.white,
                brightness: Brightness.dark,
              ),
              useMaterial3: false),
          debugShowCheckedModeBanner: false,
          title: '@mail.tm',
          home: const SplashScreen(),
        ),
      );
    });
  }
}
