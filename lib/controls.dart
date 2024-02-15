
/*
import 'package:flutter/material.dart';
import 'package:flutter_designer/property.dart';

typedef AddControl = Control Function(ContainerState?);

abstract class Control extends StatefulWidget {
  final ContainerState? parent;
  const Control({super.key, this.parent});
}

abstract class ControlState<T extends Control> extends State<T> {
  ContainerState? get parent => widget.parent;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<ControlState>(
          feedback: const Icon(Icons.edit, color: Colors.blue,size: 20,),
          data: this,
          child: buildWidget(),
    );
  }

  Widget buildWidget();

  List<Widget> getProperties();
}

abstract class ContainerState<T extends Control> extends ControlState<T> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<ControlState>(
          feedback: const Icon(Icons.edit, color: Colors.blue,size: 20,),
          data: this,
          child: DragTarget<AddControl>(
              builder: (c,l,b) => buildWidget(),
              onAccept: (c) => acceptControl(c(this)),
            ),
    );
  }

  void acceptControl(Control c);
  void removeControl(ControlState c);
}

abstract class ChildContainerState<T extends Control> extends ContainerState<T>{
  Widget? child;

  @override
  void acceptControl(Control c) => child = c;

  @override
  void removeControl(ControlState c) => setState(() {  child = null; });

}

abstract class MultiChildContainerState<T extends Control> extends ContainerState<T>{
  List<Widget> children = [];

  @override
  void acceptControl(Control c){
    setState(() {
      children.add(c);
    });
  }

  @override
  void removeControl(ControlState c) {
    setState(() {
      children.remove(c.widget);
    });
  }

}



class Room extends StatelessWidget{
  final String text;
  const Room(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
      return DecoratedBox(decoration: BoxDecoration(border: Border.all()), child: Text(text),);
  }

}

class ChildRoom extends Control{
  final String text;
  final void Function(Control) onAdd;
  const ChildRoom(this.text,this.onAdd,{super.key, super.parent});

  @override
  State<StatefulWidget> createState() => ChildRoomState();

}

class ChildRoomState extends State<ChildRoom>{

  @override
  Widget build(BuildContext context) {
    return DragTarget<AddControl>(
      builder: (c,l,b) => Room(widget.text),
      onAccept: (c) => widget.onAdd(c(widget.parent)),
    );
  }
}


abstract class SpecialControlState extends ContainerState{

  final ContainerState<Control>? stateParent;

  SpecialControlState({this.stateParent});

  @override
  // TODO: implement parent
  ContainerState<Control>? get parent => stateParent ?? widget.parent;

  @override
  Widget buildWidget() {
    return const Room('Invalid');
  }

  @override
  void acceptControl(Control c) {
    // TODO: implement acceptControl
  }
}
 */