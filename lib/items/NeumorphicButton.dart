import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeumorphicButton extends StatefulWidget {
  bool value;
  final Color buttonColor;
  final Widget child;
  final Function onChanged;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  NeumorphicButton({
    Key? key,
    required this.value,
    this.buttonColor = const Color(0xffE9E5E5),
    this.child = const Text(""),
    required this.onChanged,
    this.height = 50,
    this.width = 100,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {

  bool _value = true;
  late Widget _child;
  late Color _buttonColor;
  late double _height;
  late double _width;
  late BorderRadius _borderRadius;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _child = widget.child;
    _buttonColor = widget.buttonColor;
    _height = widget.height;
    _width = widget.width;
    _borderRadius = widget.borderRadius;
  }

  @override
  void didUpdateWidget(NeumorphicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _value = !_value;
          });
          widget.onChanged.call(_value);
        },
        child: AnimatedContainer(
          child: Center(
            child: _child,
          ),

          // 拟态特效
          duration: const Duration(milliseconds: 200),
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _buttonColor,
            boxShadow: _value
                ?
            null
                :
            [
              const BoxShadow(
                color: Color(0xFFBEBEBE),
                offset: Offset(8, 8),
                blurRadius: 30,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-8, -8),
                blurRadius: 30,
                spreadRadius: 1,
              ),
            ]

          ),
        ),
      ),
    );
  }
}
