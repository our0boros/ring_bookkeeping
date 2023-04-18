import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeumorphicSwitch extends StatefulWidget {

  bool value;
  final Function(bool)? onChanged;

  final double size;

  final Color offColor;
  final Color onColor;
  final Color selectColor; //白色选中框

  final Duration aniDuration;

  NeumorphicSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 60,
    this.offColor = const Color(0xffE9E5E5),
    this.onColor = Colors.lightBlue,
    this.selectColor = Colors.white,
    this.aniDuration = const Duration(milliseconds: 300),
  });

  @override
  State<NeumorphicSwitch> createState() => _NeumorphicSwitchState();
}

class _NeumorphicSwitchState extends State<NeumorphicSwitch>
    with SingleTickerProviderStateMixin {
  bool isDarkMode = true;

  late bool _value;
  late double centerPoint; //中心点
  late Duration _duration;

  double _padding = 4;
  double _dragDistance = 0;

  void getPrefsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDarkMode") == null) {
      prefs.setBool("isDarkMode", false);
    }

    setState(() {
      isDarkMode = prefs.getBool("isDarkMode")!;

    });
  }

  @override
  void initState() {
    super.initState();
    getPrefsSettings();

    centerPoint = widget.size / 2; //计算中心点
    _duration = widget.aniDuration;
    _value = widget.value;
  }

  @override
  void didUpdateWidget(NeumorphicSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          backgroundWidget(),
          switchWidget(),
        ],
      ),
    );
  }

  Widget backgroundWidget() {
    return GestureDetector(
      onTap: () {
        debugPrint("[SETTINGS] change to dark mode");
        setState(() {
          _value = !_value;
        });
        widget.onChanged?.call(_value);
      },
      child: Container(
        width: widget.size,
        height: widget.size / 2,
        decoration: BoxDecoration(
          //设置底色和圆角
          color: _value ? widget.onColor : widget.offColor,
          borderRadius: BorderRadius.circular(widget.size / 4),
          boxShadow: [
            BoxShadow(
              color: _value ? Color(0x9A000000) : Color(0x9Affffff),
              spreadRadius: 0,
              blurRadius: 8,
              offset: _value ? Offset(8, 8) : Offset(-8, -8),
              inset: true,
            ),
            BoxShadow(
              color: _value ? Color(0x4Affffff) : Color(0x4A000000),
              spreadRadius: 0,
              blurRadius: 8,
              offset: _value ? Offset(-8, -8) : Offset(8, 8),
              inset: true,
            )
          ]
        ),
      ),
    );
  }

  //白色开关控件
  Widget switchWidget() {
    //添加位置的动画
    return AnimatedPositioned(
        //这里根据选中选项，判断左侧的边距
        left: widget.value ? centerPoint - _padding : 0,
        duration: _duration,
        child: GestureDetector(
          onTap: () {
            debugPrint("[SETTINGS] change to dark mode");
            setState(() {
              _value = !_value;
            });
            widget.onChanged?.call(_value);
          },
          child: Container(
            width: centerPoint - _padding,
            height: widget.size / 2 - _padding * 2,
            decoration: BoxDecoration(
              color: widget.selectColor,
              borderRadius: BorderRadius.circular(
                (widget.size / 2 - _padding * 2) / 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _value ? Color(0x5Affffff) : Color(0x1A000000),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset((_value ? -8 : 8), 0),
                ),
              ]
            ),
            margin: EdgeInsets.all(_padding),
          ),
        ));
  }
}
