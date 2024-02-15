import 'package:flutter/material.dart';
import 'extension.dart';

class DynamicCheckBox extends StatefulWidget{
  final bool? checked;
  final void Function(bool?) onChange;
  const DynamicCheckBox({this.checked,required this.onChange,super.key});

  @override
  State<StatefulWidget> createState()  => _DynamicCheckBox();

}

class _DynamicCheckBox extends State<DynamicCheckBox>{
  bool? checked;

  @override
  void initState(){
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: checked, tristate: true, onChanged:(v){
      setState(() {
        checked = v;
      });
      widget.onChange(v);
    });
  }

}

class DynamicSwitch extends StatefulWidget{
  final bool value;
  final void Function(bool)? onChanged;
  const DynamicSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _DynamicSwitch();

}

class _DynamicSwitch extends State<DynamicSwitch>{
  late bool value;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged:(b){
      setState(() {
        value = b;
      });
      widget.onChanged?.call(b);
    });
  }

}

class DynamicExpansionPanel extends StatefulWidget{
  final String header;
  final Widget body;
  const DynamicExpansionPanel({required this.header,required this.body, super.key});

  @override
  State<StatefulWidget> createState() => _DynamicExpansionPanel();
}

class _DynamicExpansionPanel extends State<DynamicExpansionPanel>{
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (i, b) => setState(() {
        expanded = !b;
      }),
      children: [
        ExpansionPanel(
          headerBuilder: (c, b) => Container(height: 20, alignment: Alignment.centerLeft,child: Text(widget.header,),),
          body: widget.body,
          isExpanded: expanded,
        )
      ],
    );
  }
}

class DynamicDropdownButton<T> extends StatefulWidget{
  final List<T> choices;
  final List<Widget> ?widgets;
  final T? initial;
  final void Function(T?) onChange;

  const DynamicDropdownButton({this.initial, required this.choices, required this.onChange, super.key, this.widgets});

  @override
  State<StatefulWidget> createState() => _DynamicDropdownButton<T>();

}

class _DynamicDropdownButton<T> extends State<DynamicDropdownButton<T>>{
  T? value;
  @override
  void initState(){
    super.initState();
    value = widget.initial;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:  DropdownButton<T>(
          value: value,
          isExpanded: true,
          isDense: true,
          alignment: AlignmentDirectional.bottomEnd,
          items: List.generate(widget.choices.length, (i) =>
              DropdownMenuItem<T>(
                value: widget.choices[i],
                child: SizedBox(
                  height: 25,
                  child: widget.widgets?[i] ?? Text(shortStr(widget.choices[i].toString())),
                ),
              )
          )+ [
            DropdownMenuItem<T>(
              value: null,
              child: const Text(' '),
            )
          ],
          onChanged: (v) {
            widget.onChange(v);
            setState(() {
              value = v;
            });
          }
      ),
    );
  }

}

class DynamicCounter extends StatefulWidget{
  final int min, max, initial;
  final void Function(int) onPlus, onMinus;
  const DynamicCounter({this.min = 0, this.max = 100, this.initial = 0, required this.onPlus, required this.onMinus, super.key}) : assert(initial >= min && initial <= max);

  @override
  State<StatefulWidget> createState() => _DynamicCounter();

}

class _DynamicCounter extends State<DynamicCounter>{
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: minus, child: const Icon(Icons.exposure_minus_1, color: Colors.blue, ),),
        Text('$value'),
        TextButton(onPressed: plus, child: const Icon(Icons.plus_one, color: Colors.blue,))
      ],
    );
  }


  void minus() {
    if(value != widget.min){
      setState(() {
        value--;
      });
      widget.onMinus(value);
    }
  }

  void plus() {
    if(value != widget.max){
      setState(() {
        value++;
      });
      widget.onPlus(value);
    }
  }
}

class DynamicColumn<T> extends StatefulWidget{
  final String name;
  final T? initial;
  final List<T> choices;
  final List<Widget> widgets;
  final void Function(T?) onChange;

  const DynamicColumn({super.key,required this.name, this.initial, required this.choices, required this.widgets, required this.onChange});

  @override
  State<StatefulWidget> createState() => _DynamicColumn<T>();

}

class _DynamicColumn<T> extends State<DynamicColumn<T>>{
  Widget? innerWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 25,
                alignment: Alignment.centerLeft,
                child: Text(widget.name, style: const TextStyle(fontSize: 16),),
              ),
              SizedBox(
                width: 150,
                height: 25,
                child: DynamicDropdownButton<T>(initial: widget.initial,choices: widget.choices, onChange:  (v){
                  setState(() {
                  innerWidget = v == null? null : widget.widgets[widget.choices.indexOf(v)];
                  });
                  widget.onChange(v);
                  },),
              )
            ],
          ),
        ),
        if(innerWidget != null) innerWidget!,
      ],
    );
  }

}

class DynamicList extends StatefulWidget{
  final String name;
  final void Function(int, List<Widget>) onPlus, onMinus;
  final List<Widget> widgets;
  final int min;
  const DynamicList({super.key,required this.name, required this.widgets, required this.onPlus, required this.onMinus, this.min = 0});

  @override
  State<StatefulWidget> createState() => _DynamicList();

}

class _DynamicList extends State<DynamicList>{
  late List<Widget> innerWidgets;

  @override
  void initState() {
    super.initState();
    innerWidgets = widget.widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Row(
            children: [
              Container(
                width: 150,
                height: 25,
                alignment: Alignment.centerLeft,
                child: Text(widget.name, style: const TextStyle(fontSize: 16),),
              ),
              SizedBox(
                width: 150,
                height: 25,
                child: DynamicCounter(initial: innerWidgets.length, min: widget.min,
                  onPlus: (v){setState(() {
                    widget.onPlus(v, innerWidgets);
                  });
                  }, onMinus:  (v){setState(() {
                    widget.onMinus(v, innerWidgets);
                  });
                  },),
              )
            ],
          ),
        ),
      ] + innerWidgets,
    );
  }

}

