import 'package:flutter/material.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:major_project_fronted/view/widget/dashboard_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> formList = [];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Map<String,dynamic>>(
        future: FormServices.getForm(userId: userId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              for(var i in snapshot.data!['data']){
                formList.add(i as Map);
              }
              if(formList.isNotEmpty && formList.last['isVerified']=='true') {
                return DashboardWidget(formData: formList,);
              }else{
                return const Text('It is in progress');
              }
            }else{
              return const Text("Server Error");
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
