import 'package:fluent_ui/fluent_ui.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({Key? key, required this.mobile, required this.web, required this.tab})
      : super(key: key);
  final Widget mobile;
  final Widget web;
  final Widget tab;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobile;
      }else if(constraints.maxWidth>=600&&constraints.maxWidth<1100){
        return tab;
    } else{
        return web;
      }
    });
  }
}
