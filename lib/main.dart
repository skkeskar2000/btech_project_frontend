import 'package:fluent_ui/fluent_ui.dart';
import 'package:major_project_fronted/constant/app_route.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:major_project_fronted/preferences.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPreferenceHelper.init();
    return OKToast(
      child: FluentApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)
        ),
        onGenerateRoute: AppRoute.route,
        initialRoute: AppConst.welcomeScreen,
      ),
    );
  }
}
