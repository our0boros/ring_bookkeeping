import 'package:flutter/material.dart';
import 'package:ring_bookkeeping/data/node.dart';

class dateEntryRow extends StatefulWidget {
  final List<Node> entries;
  final double width;
  final double lineHeight;
  final double dateHeight;
  final double rowDuration;

  final int incomeDetail;

  const dateEntryRow({
    super.key,
    required this.entries,
    required this.width,
    this.lineHeight = 74,
    this.dateHeight = 12,
    this.rowDuration = 19,

    this.incomeDetail = 3,
  });

  @override
  State<dateEntryRow> createState() => _dateEntryRowState();
}

class _dateEntryRowState extends State<dateEntryRow> {

  List<String> weekdays = [
    'Mon.',
    'Tue.',
    'Wed.',
    'Thu.',
    'Fri.',
    'Sat.',
    'Sun.',
  ];

  late List<Node> _entries;
  late double _width;
  late double _lineHeight;
  late double _dateHeight;
  late double _rowDuration;

  late int _incomeDetail;

  late String _date;
  late double _income;



  @override
  void initState() {
    super.initState();

    _entries = widget.entries;
    _width = widget.width;
    _lineHeight = widget.lineHeight;
    _dateHeight = widget.dateHeight;
    _rowDuration = widget.rowDuration;

    _incomeDetail = widget.incomeDetail;

    // 获取当前日期与星期
    var currentDate = _entries[0].date.toString().substring(0, 10);
    debugPrint("[EntryRow] current date: $currentDate");

    _date = "${currentDate.substring(5).replaceAll("-", "/")} ${weekdays[DateTime.parse(currentDate).weekday]}";
    _income = 231;
  }

  @override
  void didUpdateWidget(dateEntryRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entries != _entries) {
      _entries = widget.entries;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _width,
        height: _entries.length * _lineHeight + _dateHeight,
        margin: EdgeInsets.only(top: _rowDuration),
        child: Column(
          children: [
            Container(
              height: _dateHeight,
              width: _width,
              color: Colors.deepOrangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_date, style: TextStyle(
                    fontSize: _dateHeight,
                    color: Color(0xff615F5F),
                    // fontFamily:
                  ),),
                  Text(_income.toStringAsFixed(_incomeDetail), style: TextStyle(
                    fontSize: _dateHeight,
                  ),),
                ],
              ),
            ),
            Container(
              height: _entries.length * _lineHeight,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: _entries.length,
                itemBuilder: (BuildContext innerContext, int index) {
                  return Text(_entries[index].title);
                },
              ),
            )
          ],
        )
    );
  }
}