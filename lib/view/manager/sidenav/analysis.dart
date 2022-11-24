import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:major_project_fronted/services/service_const.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  Future<Map<String, dynamic>> _getAllForm =
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
                      const SizedBox(
                        height: 10,
                      ),
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
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      ListView.builder(
                        itemCount: _formList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>_cardWidget(_formList[index], (index+1).toString())
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
  Widget _cardWidget(Map<dynamic, dynamic> formData,String index){
    String userName = '';
    int total = 0;
    String formId = '';
    bool isVerified = false;
    Map<String, dynamic> score = {};

    formData.forEach((key, value) {
        if (key == 'createdAt' ||
            key == 'updatedAt' ||
            key == '__v' ||
            key == 'role' ||
            key == 'userId') {
        } else if (key == 'userName') {
          userName = value;
        } else if (key == 'total') {
          total = int.parse(value);
        } else if (key == '_id') {
          formId = value;
        } else if (key == 'isVerified') {
          isVerified =  value=='true';
        } else {
          score[key] = value;
        }
      });
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  index,
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
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      )
                    : const Text(
                        'Pending',
                        style: TextStyle(fontSize: 18, color: Colors.red),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(formId, score),
                      ).then((value) {
                        print("close dialoge");
                        setState(() {
                          _getAllForm = FormServices.getAllForm(role: 'employee');
                        });
                      });
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
  Widget _buildPopupDialog(String formId, Map<String, dynamic> score) {
    return AlertDialog(
      title: Center(
        child: Column(
          children: const [
            Text(
              'Records',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Divider()
          ],
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.2,
        child: SingleChildScrollView(
          child: Column(
            children: score.entries
                .map((e) => SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.key,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Text(
                    e.value,
                    style:const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ))
                .toList(),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () async {
            if (await FormServices.updateForm(
                formId: formId, isVerified: true)) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text('Verified'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Reject'),
        ),
      ],
    );
  }

}
