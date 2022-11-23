import 'package:fluent_ui/fluent_ui.dart';
import 'package:major_project_fronted/view/employee/sidenav/dashboard.dart';

class ViewDashboard extends StatelessWidget {
  const ViewDashboard({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: IconButton(icon: const Icon(FluentIcons.back), onPressed: (){
        Navigator.pop(context);
      }),
      content: Dashboard(userId: userId),
    );
  }
}
