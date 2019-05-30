import 'package:flutter/material.dart';
import 'package:jsonschema_forms/src/fields/json_form_field.dart';
import 'package:meta/meta.dart';

class ObjectField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;
  final Map<String, dynamic> formData;
  final void Function(String, dynamic) onEdited;
  final void Function(String, dynamic) setProperty;

  ObjectField({
    @required this.fieldKey,
    @required this.dataSchema,
    this.formData,
    this.onEdited,
    this.setProperty,
  });

  @override
  _ObjectFieldState createState() => _ObjectFieldState();
}

class _ObjectFieldState extends State<ObjectField> {
  @override
  Widget build(BuildContext context) {
    String keyPrefix = widget.fieldKey != 'root' ? '${widget.fieldKey}.' : '';
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        if (widget.dataSchema['title'] != null)
          Text(
            '${widget.dataSchema['title']} (${widget.fieldKey})',
            style: Theme.of(context).textTheme.title,
          ),
        if (widget.dataSchema['description'] != null)
          Text(
            widget.dataSchema['description'],
            style: Theme.of(context).textTheme.body2,
          ),
        ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            for (String key in widget.dataSchema['properties'].keys)
              JsonFormField(
                fieldKey: '$keyPrefix$key',
                dataSchema: widget.dataSchema['properties'][key],
                formData: widget.formData,
                onEdited: widget.onEdited,
                setProperty: widget.setProperty,
              )
          ],
        ),
      ],
    );
  }
}
