import 'package:flutter/material.dart';
import 'package:jsonschema_forms/src/fields/json_form_field.dart';
import 'package:meta/meta.dart';

enum FormMode { fill, display, edit }

class FormWidget extends StatefulWidget {
  final Map<String, dynamic> dataSchema;
  final Map<String, dynamic> uiSchema;
  final Map<String, dynamic> formData;
  final FormMode formMode;

  FormWidget({
    @required this.dataSchema,
    this.uiSchema,
    this.formData,
    this.formMode: FormMode.fill,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  GlobalKey _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Form(
            key: _key,
            child: JsonFormField(
              fieldKey: 'root',
              dataSchema: widget.dataSchema,
              uiSchema: widget.uiSchema,
              formData: widget.formData,
              formMode: widget.formMode,
            ),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              print(_key.currentState);
            },
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> dump() {
    return {};
  }
}
