import 'package:flutter/material.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:major_project_fronted/view/widget/dashboard_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> formList = [];
    return FutureBuilder<Map<String,dynamic>>(
      future: FormServices.getForm(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            for(var i in snapshot.data!['data']){
              formList.add(i as Map);
            }
            if(formList.last['isVerified'] == true) {
              return DashboardWidget(formData: formList.last,);
            }else{
              return const Text('It is in progress');
            }
          }else{
            return const Text("Server Error");
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
