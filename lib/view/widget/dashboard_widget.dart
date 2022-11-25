import 'package:flutter/material.dart';
import 'package:major_project_fronted/view/widget/bar_chart_widget.dart';
import 'package:major_project_fronted/view/widget/dashboard_widget.dart';
import 'package:major_project_fronted/view/widget/pie_chart_widget.dart';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key, required, required this.formData})
      : super(key: key);

  final List<Map<dynamic, dynamic>> formData;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  Map<String, dynamic> score = {};
  String userName = '';
  int total = 0;
  int length = 0;
  int index = 0;
  final List<ListItem> _dropdownItems = [
    ListItem(0, (DateTime.now().year-0000).toString()),
    ListItem(1, (DateTime.now().year-0001).toString()),
    ListItem(2, (DateTime.now().year-0002).toString()),
    ListItem(3, (DateTime.now().year-0003).toString()),
  ];

  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  late ListItem _selectedItem;

  @override
  void initState() {
    length=widget.formData.length-1;
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value!;
    super.initState();
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];

    for(int i=0;i<=length;i++){
      items.add(
        DropdownMenuItem(
          value: listItems[i],
          child: Text(listItems[i].name),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    widget.formData[length-index].forEach((key, value) {
      if (key == '_id' ||
          key == 'createdAt' ||
          key == 'updatedAt' ||
          key == 'isVerified' ||
          key == '__v' ||
          key == 'role' ||
          key == 'userId') {
      } else if (key == 'userName') {
        userName = value;
      } else if (key == 'total') {
        total = int.parse(value);
      } else {
        score[key] = value;
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: DropdownButton<ListItem>(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                          index = value!.value;
                        });
                      }),
                ),
              ],
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
                                  Text(
                                      (int.parse(entry.value) * 10).toString()),
                                ],
                              ),
                            );
                            return w;
                          }).toList()),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Percentage',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ((total / (score.length * 10)) * 100)
                                      .toString(),
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: BarChartWidget(
                            scoreData: score,
                          ),
                        ),
                        Container(
                          height: 280,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: PieChartWidget(
                            formData: score,
                          ),
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
