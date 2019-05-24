import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class StringField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;
  final String formData;
  final void Function(String, dynamic) onEdited;
  final void Function(String, dynamic) setProperty;

  StringField({
    @required this.fieldKey,
    @required this.dataSchema,
    this.formData,
    this.onEdited,
    this.setProperty,
  });

  @override
  _StringFieldState createState() => _StringFieldState();
}

class _StringFieldState extends State<StringField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(
        text: widget.formData ?? widget.dataSchema['default']);
    _controller.addListener(_handleChanges);
    print('StringField(${widget.fieldKey}): ${widget.formData}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: '${widget.dataSchema['title']} (${widget.fieldKey})',
        ),
        onSaved: _handleSaved,
      ),
    );
  }

  void _handleSaved(String value) {
    widget.setProperty?.call(widget.fieldKey, value);
  }

  void _handleChanges() {
    String value = _controller.text;
    if (widget.onEdited != null) {
      widget.onEdited(widget.fieldKey, value);
    }
  }
}
