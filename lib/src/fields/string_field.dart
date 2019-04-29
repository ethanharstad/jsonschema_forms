import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class StringField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;
  final String formData;

  StringField(
      {@required this.fieldKey, @required this.dataSchema, this.formData});

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
    print('StringField(${widget.fieldKey}): ${widget.formData}');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: '${widget.dataSchema['title']} (${widget.fieldKey})',
        ),
      ),
    );
  }
}
