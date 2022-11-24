import 'package:flutter/material.dart';
import 'package:major_project_fronted/services/form_services.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final Future<Map<String, dynamic>> _getAllForm =
      FormServices.getAllForm(role: 'employee');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getAllForm,
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.done) {
            if (snapshots.hasData) {
              if (snapshots.data!['status']) {
                List<Map<dynamic, dynamic>> _formList = [];
                for (var i in snapshots.data!['data'] as List) {
                  _formList.add(i as Map);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'SrNo',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'ID',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Name',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Status',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      const Divider(
                        color: Colors.black12,
                      ),
                      ListView.builder(
                        itemCount: _formList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AnalysisCardWidget(
                          formData: _formList[index],
                          index: (index+1).toString(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text(snapshots.data!['msg']);
              }
            } else {
              return const Text('Server Error Occure');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class AnalysisCardWidget extends StatefulWidget {
  const AnalysisCardWidget({Key? key, required this.formData, required this.index})
      : super(key: key);
  final Map<dynamic, dynamic> formData;
  final String index;
  @override
  State<AnalysisCardWidget> createState() => _AnalysisCardWidgetState();
}

class _AnalysisCardWidgetState extends State<AnalysisCardWidget> {
  String userName = '';
  int total = 0;
  String formId = '';
  bool isVerified = false;
  Map<String,dynamic>score = {};
  @override
  void initState() {
    widget.formData.forEach((key, value) {
      if(key == 'createdAt' || key == 'updatedAt' || key=='__v' || key == 'role' || key=='userId'){

      }else if(key == 'userName'){
        userName = value;
      }else if(key == 'total'){
        total = int.parse(value);
      }else if(key=='_id'){
        formId = value;
      }
      else if(key == 'isVerified'){
        isVerified = value;
      }
      else{
        score[key] = value;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.index,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  formId,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: isVerified
                    ? const Text(
                  'Verified',
                  style: TextStyle(
                      fontSize: 18, color: Colors.green),
                )
                    : const Text(
                  'Pending',
                  style:
                  TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (isVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User All Ready Verified'),
                        ),
                      );
                    } else {
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );

  }
}
