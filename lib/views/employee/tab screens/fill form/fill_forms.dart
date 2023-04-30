import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/tab%20screens/evaluation_tab/show_custom_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'heading_view_fill_form.dart';

class FillForm extends StatefulWidget {
  final String id;
  final String name;

  const FillForm({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FormController>(context, listen: false)
        .getCustomFormAttribute();
    Provider.of<FormController>(context, listen: false).getDefaultFormList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            HeadingFillForm(),
            ShowCustomForms(isFilling: true, id: widget.id, name: widget.name,)
          ],),
        );
      },
    );
  }
}
