import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/employee_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeManagerTab extends StatefulWidget {
  final String id;

  const EmployeeManagerTab({Key? key, required this.id}) : super(key: key);

  @override
  State<EmployeeManagerTab> createState() => _EmployeeManagerTabState();
}

class _EmployeeManagerTabState extends State<EmployeeManagerTab> {
  @override
  void initState() {
    // TODO: implement initState
    apiCall();

  }
  apiCall()async{
    await Provider.of<AuthController>(context, listen: false)
        .getAllUsers(currentId: widget.id);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 5 / 6,
                  ),
                  itemCount: provider.allEmployeeList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Do you want to remove this employee',
                                              style: kContentStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                            content: const Image(
                                              image: AssetImage(
                                                  'assets/images/delete.jpg'),
                                            ),
                                            alignment: Alignment.center,
                                            actionsAlignment: MainAxisAlignment.center,
                                            actions: [
                                              InkWell(
                                                onTap: () {
                                                  Provider.of<AuthController>(
                                                          context,
                                                          listen: false)
                                                      .removeUser(
                                                          userId: provider
                                                              .allEmployeeList[
                                                                  index]
                                                              .id!,
                                                          currentId: widget.id).then((value) => Navigator.pop(
                                                      context));
                                                },
                                                child: const IconTextButton(
                                                  icon: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ),
                                                  title: 'Yes',
                                                  isSelected: true,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const IconTextButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                  title: 'No',
                                                  isSelected: false,
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EmployeeEvaluationDashboard(
                                    id: provider.allEmployeeList[index].id!,
                                    name: provider.allEmployeeList[index].name!,
                                    text:
                                        '${provider.allEmployeeList[index].name!}\'s',
                                  );
                                }));
                              },
                              hoverColor: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    child: Icon(Icons.person),
                                  ),
                                  Text(
                                    '${provider.allEmployeeList[index].name}',
                                    style: kContentStyle,
                                  ),
                                  Text(
                                    '${provider.allEmployeeList[index].role}',
                                    style: kContentStyle,
                                  ),
                                  Text(
                                    'Joined on ${provider.allEmployeeList[index].createdAt?.substring(0, 10)}',
                                    style: kGreyText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}
