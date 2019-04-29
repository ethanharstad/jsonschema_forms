import 'package:flutter/material.dart';
import 'package:jsonschema_forms/src/fields/json_form_field.dart';
import 'package:meta/meta.dart';

class ObjectField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;
  final Map<String, dynamic> formData;

  ObjectField({
    @required this.fieldKey,
    @required this.dataSchema,
    this.formData,
  });

  @override
  _ObjectFieldState createState() => _ObjectFieldState();
}

class _ObjectFieldState extends State<ObjectField> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _buildTitle(),
      _buildDescription(),
      _buildProperties()
    ];
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: children.where((Widget element) => element != null).toList(),
    );
  }

  Widget _buildTitle() {
    if (widget.dataSchema['title'] != null) {
      return Text(
        '${widget.dataSchema['title']} (${widget.fieldKey})',
        style: Theme.of(context).textTheme.title,
      );
    }
    return null;
  }

  Widget _buildDescription() {
    if (widget.dataSchema['description'] != null) {
      return Text(
        widget.dataSchema['description'],
        style: Theme.of(context).textTheme.body2,
      );
    }
    return null;
  }

  Widget _buildProperties() {
    String keyPrefix = widget.fieldKey != 'root' ? '${widget.fieldKey}.' : '';
    List<Widget> widgets = <Widget>[];
    widget.dataSchema['properties'].forEach((String key, dynamic value) {
      widgets.add(JsonFormField(
        fieldKey: '$keyPrefix$key',
        dataSchema: value,
        formData: widget.formData,
      ));
    });
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: widgets,
    );
  }
}
