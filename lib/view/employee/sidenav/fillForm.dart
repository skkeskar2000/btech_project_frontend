import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:major_project_fronted/services/service_const.dart';
import 'package:major_project_fronted/view/widget/dropdown_widget.dart';

class FillForm extends StatefulWidget {
  const FillForm({Key? key}) : super(key: key);

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  bool isFilled = false;

  late Future<Tuple> checkFormFilled;
  @override
  void initState() {
    setState(() {
      checkFormFilled = FormServices.checkFormFilled();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = ['1', '2', '3', '4', '5'];
    Map<String, dynamic> formData = {};
    return Material(
      child: FutureBuilder<Tuple>(
          future: checkFormFilled,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              isFilled = !snapshot.data!.status;
              return isFilled
                  ? const Center(
                      child: Text(
                        "All ready Filled",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      )
                  : Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: FormServices.getFormAttribute(),
                          builder: (context, snapshots) {
                            if (ConnectionState.done ==
                                snapshots.connectionState) {
                              if (snapshots.hasData) {
                                int length = snapshots.data!.length;
                                return Column(
                                  children: [
                                    ListView.builder(
                                        itemCount: length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          String heading = "";
                                          String value = "";
                                          snapshots.data![index].forEach((k, v) {
                                            heading = k;
                                            value = v.toString();
                                          });
                                          return index > 0 && index < length - 1
                                              ? DropDownButtonWidget(
                                                  items: items,
                                                  onChanged: (value) {
                                                    formData[heading] = value;
                                                  },
                                                  questionTitle: heading)
                                              : Container();
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (await FormServices.saveForm(
                                            formData)) {
                                          flutterToast('Successfully Submitted');
                                          setState(() {
                                            isFilled = true;
                                            checkFormFilled = FormServices.checkFormFilled();
                                          });
                                        } else {
                                          flutterToast('Unable to Submitted');
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text("Unable to get Form");
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                  );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
