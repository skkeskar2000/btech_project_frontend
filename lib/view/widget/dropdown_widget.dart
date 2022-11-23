import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/utils.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget(
      {Key? key,
      required this.items,
      required this.onChanged,
      required this.questionTitle})
      : super(key: key);
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String questionTitle;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.questionTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10, spreadRadius: 1, color: Colors.grey),
                    ]),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: const Color(0xFFE3E8FB),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        alignment: AlignmentDirectional.topCenter,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Center(
                              child: Text(
                            "Select Value..",
                            style: TextStyle(
                              color: Color(0xFF939393),
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                        value: dropDownValue,
                        style: TextStyle(
                          color: headingTextColor,
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: headingTextColor,
                          ),
                        ),
                        // style: Theme.of(context).textTheme.title,
                        items: widget.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                          widget.onChanged(newValue!);
                        },
                        dropdownColor: const Color(0xFFE3E8FB),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
