
import 'package:flutter/material.dart';

import 'field.dart';

class Access {
  ControlState? parent;

  void Function()? remove;

  ControlState? state;
}

abstract class Accessible {
  Access get access;
}

class Generator<T extends Control>{
  final T Function() generate;
  final void Function()? accept;
  final void Function()? reject;

  const Generator(this.generate, {this.accept, this.reject});
}

abstract class Control extends StatefulWidget implements Accessible{
  @override
  final Access access;
  Control({super.key}) : access = Access();


}

abstract class ControlState<T extends Control> extends State<T> implements FieldListenable, Accessible{
  Type get type;

  List<Field> get widgetFields;

  set widgetFields(List<Field> fields);

  List<Widget> get editView => widgetFields.where((element) => element.isEditable).map((e) => e.view).toList();

  @override
  Access get access => widget.access;

  @override
  void applyChange(void Function() fun) {
    setState(fun);
  }

  @override
  void initState() {
    super.initState();
    if(access.state != null)
      {
        widgetFields = access.state!.widgetFields;
      }
    widget.access.state = this;

  }

  String text({String prefix = ''}) {
    return "$type(\n${widgetFields.where((e) => e.isAddable).map((e) => e.text(prefix: '$prefix\t\t')).join('\n')}\n$prefix\t)";
  }
}

abstract class DraggableControlState<T extends Control> extends ControlState<T>{
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      feedback: const Icon(Icons.edit, color: Colors.blue,),
      data: this,
      child: buildWidget(context)
    );
  }

  buildWidget(BuildContext context);
}

class WidgetRoom extends StatelessWidget{
  final ControlState parent;
  final void Function(Generator) accept;
  final String name;

  const WidgetRoom({required this.parent, required this.name, required this.accept, super.key});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        feedback: const Icon(Icons.edit, color: Colors.blue,),
        data: parent,
        child: DragTarget<Generator>(
          onAccept: accept,
          builder: (context,list1, list2){
            return Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Text(name),
            );
          },
        ) ,
    );
  }


}

