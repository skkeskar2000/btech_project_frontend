import 'package:flutter/material.dart';
import 'package:major_project_fronted/view/widget/bar_chart_widget.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget(
      {Key? key, required, required this.formData })
      : super(key: key);
  final Map<dynamic,dynamic> formData;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  Map<String,dynamic> score = {};
  String userName = '';
  String total = '';
  @override
  void initState() {
    widget.formData.forEach((key, value) {
      if(key=='_id' || key == 'createdAt' || key == 'updatedAt' || key == 'isVerified' || key=='__v' || key == 'role' || key=='userId'){

      }else if(key == 'userName'){
        userName = value;
      }else if(key == 'total'){
        total = value;
      }
      else{
        score[key] = value;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(score);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ]),
              child: ListTile(
                minLeadingWidth: 0,
                leading: const Icon(Icons.person_pin),
                title: Text(userName),
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 5),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]),
                      child: Column(
                        children: [
                          const Text(
                            'RESULT',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Column(
                              children: score.entries.map((entry) {
                                var w = Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(entry.key),
                                      Text(entry.value),
                                    ],
                                  ),
                                );
                                return w;
                              }).toList()
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 3),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Percentage',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  total,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 320,
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.black12),
                          ),
                          child: BarChartWidget(
                            // formData: state.formData,
                          ),
                        ),
                        Container(
                          height: 280,
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.black12),
                          ),
                          // child: PieChartWidget(
                          //   // formEntity: state.formData,
                          // ),
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
