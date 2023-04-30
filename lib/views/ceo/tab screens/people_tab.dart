import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/model/usermodel.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/manager/tab_screen/manager_employee_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeopleTab extends StatefulWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  apiCall() async {

  }
  List<UserModel>ManagerList=[];
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, provider, child) {
        ManagerList=provider.allManagerList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Managers',
                    style: kHeadingTextStyle,
                  ),
                ),
                Card(
                  elevation: 20,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 270,
                    child: !provider.managerLoading
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 5 / 6,
                            ),
                            itemCount: ManagerList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      content: const Image(
                                                        image: AssetImage(
                                                            'assets/images/delete.jpg'),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      actions: [
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<AuthController>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .removeUser(
                                                                    userId:
                                                                    ManagerList[
                                                                            index]
                                                                        .id!,
                                                                    currentId:
                                                                        's')
                                                                .then((value) =>
                                                                    Navigator.pop(
                                                                        context));
                                                          },
                                                          child:
                                                              const IconTextButton(
                                                            icon: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            title: 'Yes',
                                                            isSelected: true,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const IconTextButton(
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
                                        onTap: () {},
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
                                              '${ManagerList[index].name}',
                                              style: kContentStyle,
                                            ),
                                            Text(
                                              '${ManagerList[index].role}',
                                              style: kContentStyle,
                                            ),
                                            Text(
                                              'Joined on ${ManagerList[index].createdAt?.substring(0, 10)}',
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
                            })
                        : Container(
                      padding: EdgeInsets.symmetric(horizontal: 150),
                            child: Center(child: Text('No Managers On-Board',style: kHeadingTextStyle,)),
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Employees',
                    style: kHeadingTextStyle,
                  ),
                ),
                Card(
                  elevation: 15,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 270,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: EmployeeManagerTab(
                      id: 's',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
