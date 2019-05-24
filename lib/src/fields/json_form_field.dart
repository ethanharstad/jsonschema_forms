import 'package:flutter/material.dart';
import 'package:jsonschema_forms/src/fields/array_field.dart';
import 'package:jsonschema_forms/src/fields/boolean_field.dart';
import 'package:jsonschema_forms/src/fields/number_field.dart';
import 'package:jsonschema_forms/src/fields/object_field.dart';
import 'package:jsonschema_forms/src/fields/string_field.dart';
import 'package:jsonschema_forms/src/form_widget.dart';
import 'package:meta/meta.dart';

class JsonFormField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;
  final Map<String, dynamic> uiSchema;
  final Map<String, dynamic> formData;
  final FormMode formMode;
  final void Function(String, dynamic) onEdited;
  final void Function(String, dynamic) setProperty;

  JsonFormField({
    @required this.fieldKey,
    @required this.dataSchema,
    this.uiSchema,
    this.formData,
    this.formMode: FormMode.fill,
    this.onEdited,
    this.setProperty,
  });

  @override
  _JsonFormFieldState createState() => _JsonFormFieldState();
}

class _JsonFormFieldState extends State<JsonFormField> {
  @override
  Widget build(BuildContext context) {
    dynamic formData = _extractFormData();
    switch (widget.dataSchema['type']) {
      case 'array':
        return ArrayField(
          fieldKey: widget.fieldKey,
          dataSchema: widget.dataSchema,
        );
      case 'object':
        return ObjectField(
          fieldKey: widget.fieldKey,
          dataSchema: widget.dataSchema,
          formData: formData,
          onEdited: _handleChanges,
          setProperty: widget.setProperty,
        );
      case 'string':
        return StringField(
          fieldKey: widget.fieldKey,
          dataSchema: widget.dataSchema,
          formData: formData,
          onEdited: _handleChanges,
          setProperty: widget.setProperty,
        );
      case 'boolean':
        return BooleanField(
          fieldKey: widget.fieldKey,
          dataSchema: widget.dataSchema,
        );
      case 'number':
      case 'integer':
      case 'float':
        return NumberField(
          fieldKey: widget.fieldKey,
          dataSchema: widget.dataSchema,
        );
      default:
        if (widget.dataSchema['title'] != null) {
          return Text(
              '${widget.dataSchema['title']}: ${widget.dataSchema['type']} not supported yet');
        }
        return Placeholder(
          fallbackHeight: 48.0,
        );
    }
  }

  void _handleChanges(String key, dynamic value) {
    print('json_form_field ${widget.fieldKey}: $value');
    if (widget.onEdited != null) {
      widget.onEdited(widget.fieldKey, value);
    }
  }

  dynamic _extractFormData() {
    if (widget.formData == null) {
      return null;
    }
    if (widget.fieldKey == 'root') {
      return widget.formData;
    }
    String segment = widget.fieldKey.split('.').last;
    if (widget.formData.containsKey(segment)) {
      return widget.formData[segment];
    }
    return null;
  }
}
