import 'package:flutter/material.dart';

class ExpandableRow extends StatefulWidget {
  @override
  _ExpandableRowState createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow> {
  bool _expanded = false;
  double _defaultHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward),
            Container(
              height: _defaultHeight * 2,
              child: Center(child: Text('数字')),
            ),
            Icon(Icons.arrow_downward),
            if (_expanded)
              Container(
                height: _defaultHeight,
                color: Colors.orange,
                padding: EdgeInsets.all(8.0),
                child: Text('展开的文本'),
              )
          ],
        ),
      ),
    );
  }
}
