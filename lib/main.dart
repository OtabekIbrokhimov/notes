import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(child: MyApp(), supportedLocales: [Locale("en",'EN'),Locale("uz",'UZ'),], path: 'assets/translation',
        fallbackLocale: Locale("en",'EN'),
      )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // his widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: HomePage(),
      routes: {

      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
   );
  }
}
