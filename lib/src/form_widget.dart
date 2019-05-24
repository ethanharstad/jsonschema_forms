import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jsonschema_forms/src/fields/json_form_field.dart';
import 'package:meta/meta.dart';

enum FormMode { fill, display, edit }

class FormWidget extends StatefulWidget {
  final Map<String, dynamic> dataSchema;
  final Map<String, dynamic> uiSchema;
  final Map<String, dynamic> formData;
  final FormMode formMode;
  final void Function(Map<String, dynamic>) onSaved;

  FormWidget({
    @required this.dataSchema,
    this.uiSchema,
    this.formData,
    this.formMode: FormMode.fill,
    this.onSaved,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: JsonFormField(
              fieldKey: 'root',
              dataSchema: widget.dataSchema,
              uiSchema: widget.uiSchema,
              formData: widget.formData,
              formMode: widget.formMode,
//              onEdited: _handleChanges,
              setProperty: _setProperty,
            ),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              _formKey.currentState.save();
              print('FORM DATA');
              print(_data);
            },
          ),
        ],
      ),
    );
  }

  void _setProperty(String key, dynamic value) {
    print("set: $key = $value");
    Map<String, dynamic> data = _data;
    List<String> tokens = key.split(RegExp(r'[.\[\]]'));
    tokens.removeWhere((value) => value.isEmpty);
    print('tokens: $tokens');
    HasNextIterator<String> it = HasNextIterator(tokens.iterator);
    while (it.hasNext) {
      String token = it.next();

      data.putIfAbsent(token, () {});
    }
  }

  void _handleChanges(String key, dynamic value) {
    Map<String, dynamic> data = _data;
    for (String token in key.split('.')) {
      if (data.containsKey(token)) {
        if (data[key] is Map) {
          data = data[key];
        }
      }
    }
  }
}
