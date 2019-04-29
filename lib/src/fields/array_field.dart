import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ArrayField extends StatefulWidget {
  final String fieldKey;
  final Map<String, dynamic> dataSchema;

  ArrayField({@required this.fieldKey, @required this.dataSchema});

  @override
  _ArrayFieldState createState() => _ArrayFieldState();
}

class _ArrayFieldState extends State<ArrayField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.dataSchema['title'],
          style: Theme.of(context).textTheme.title,
        ),
        _buildItem(),
        _buildItem(),
        _buildItem(),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildItem() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Placeholder(
            fallbackHeight: 60.0,
          ),
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
            ),
          ],
        )
      ],
    );
  }
}
