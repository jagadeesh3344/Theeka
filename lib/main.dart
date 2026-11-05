import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/thekaa_colors.dart';
import 'screens/main_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ThekaaColors.cardBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ThekaaApp());
}

class ThekaaApp extends StatelessWidget {
  const ThekaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THEKAA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ThekaaColors.mainBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThekaaColors.terracotta,
          primary: ThekaaColors.terracotta,
          surface: ThekaaColors.cardBackground,
        ),
      ),
      home: const MainScaffold(),
    );
  }
}
