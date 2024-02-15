/*
import 'package:flutter/material.dart';
import 'controls.dart';


class Window extends Control{
  const Window({super.key});

  @override
  State<StatefulWidget> createState() => _Window ();

}

class _Window extends ChildContainerState{

  @override
  Widget buildWidget() {
    return Center(
      child: child
    );
  }

  @override
  List<Widget> getProperties() => [];
}


class ControlAdder extends StatefulWidget {
  final String text;
  final AddControl control;

  const ControlAdder(this.text, this.control, {super.key});

  @override
  State<StatefulWidget> createState() => _ControlAdder();
}

class _ControlAdder extends State<ControlAdder>{
  Color? color;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() { color  = Colors.blueGrey; }),
      onExit: (e) => setState(() { color  = null; }),
      cursor: SystemMouseCursors.click,
      child: LongPressDraggable<AddControl>(
          feedback: const Icon(Icons.layers, color: Colors.blue, size: 20),
          data: widget.control,
          child:  Container(
            alignment: Alignment.centerLeft,
            color: color,
            width: 200,
            height: 30,
            child: Text(widget.text),
          )
      ),
    );
  }

}

class Header extends StatelessWidget{
  final String text;
  const Header(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text,),
      )
    );
  }
  
}


class PropertyDisplay extends StatefulWidget {
  const PropertyDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _PropertyDisplay();
}

class _PropertyDisplay extends State<PropertyDisplay>{
  List<Widget> properties = [];
  ControlState? control;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DragTarget<ControlState>(
            builder: (c, l, b) =>   LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 300,
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Column(
                          children: properties,
                        ),
                      )
                  );
                }),
            onAccept: display,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: control == null || control?.parent == null ? [] : [
            IconButton(onPressed: goToParent , icon: const Icon(Icons.arrow_back, color: Colors.blue,)),
            IconButton(onPressed: remove , icon: const Icon(Icons.delete, color: Colors.blue,)),
          ],
        )
      ],
    );
  }

  void display(ControlState? state){
    setState(() {
      control = state;
      properties = state?.getProperties() ?? [];
    });
  }

  void remove(){
    control?.parent?.removeControl(control!);
    goToParent();
  }

  void goToParent() {
    display(control?.parent);
  }

}


////



class ChangeCheckBox extends StatefulWidget{
  final bool? checked;
  final void Function(bool?) onChange;
  const ChangeCheckBox(this.checked,this.onChange,{super.key});

  @override
  State<StatefulWidget> createState()  => _ChangeCheckBox();

}

class _ChangeCheckBox extends State<ChangeCheckBox>{
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

class ChangeExpansionPanel extends StatefulWidget{
  final String header;
  final Widget body;
  const ChangeExpansionPanel(this.header, this.body, {super.key});

  @override
  State<StatefulWidget> createState() => _ChangeExpansionPanel();
}

class _ChangeExpansionPanel extends State<ChangeExpansionPanel>{
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return  ExpansionPanelList(
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

class ChangeDropdownButton<T> extends StatefulWidget{
  final List<T> choices;
  final List<Widget> ?widgets;
  final T? initial;
  final void Function(T?) onchange;

  const ChangeDropdownButton(this.initial, this.choices, this.onchange, {super.key, this.widgets});

  @override
  State<StatefulWidget> createState() => _ChangeDropdownButton<T>();

}

class _ChangeDropdownButton<T> extends State<ChangeDropdownButton<T>>{
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
                child: widget.widgets?[i] ?? Text(widget.choices[i].toString().substring(widget.choices[i].toString().indexOf('.') + 1)),
              )
          )+ [
            DropdownMenuItem<T>(
              value: null,
              child: const Text(' '),
            )
          ],
          onChanged: (v) {
            widget.onchange(v);
            setState(() {
              value = v;
            });
          }
      ),
    );
  }

}

 */