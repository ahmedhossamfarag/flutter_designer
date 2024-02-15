import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_designer/base.dart';
import 'package:flutter_designer/lib.dart';

class Designer extends StatelessWidget{
  const Designer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Row(
        children: const [
          WidgetsPanel(),
          Expanded(
              child: ViewPanel()
          ),
          EditPanel()
        ],
      )
    );
  }

}

class WidgetsPanel extends StatefulWidget{
  const WidgetsPanel({super.key});

  @override
  State<StatefulWidget> createState() => _WidgetsPanel();
}

class _WidgetsPanel extends State<WidgetsPanel>{

  var widgets = Library.controls.entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white70,
      child: LayoutBuilder(builder: (context,constrains) =>
          Column(
            children: [
            CupertinoSearchTextField(onChanged: search,),
            SizedBox(
                height: constrains.maxHeight - 40,
                child: ListView(
                  children: widgets.map((e) => WidgetGenerator(e)).toList(),
                )
            )
          ],
      ),)
    );
  }

  void search(String value) {
    value = value.toLowerCase();
    setState(() {
      if(value.isEmpty){
        widgets = Library.controls.entries;
      }
      else{
        widgets = Library.controls.entries.where((e) => e.key.toString().toLowerCase().contains(value));
      }
    });
  }
}

class ViewPanel extends StatefulWidget{
  const ViewPanel({super.key});

  @override
  State<StatefulWidget> createState() => _ViewPanel();
}

class _ViewPanel extends State<ViewPanel>{
  Control? view;
  var key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: DragTarget<Generator>(
              builder: (context, objects , builder){
                return Center(
                  child:  view,
                );
              },
              onAccept: accept,
            )),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (buildContext) => TextPanel(view?.access.state?.text() ?? '')));
            },
            child: const Chip(
              avatar: Icon(Icons.open_in_new),
              label: Text('Open Text Panel'),
            ),
          ),
        )
      ],
    );
  }


  void accept(Generator data) {
    setState(() {
      view = data.generate();
    });
    data.accept?.call();
    view?.access.remove = (){
      setState(() {
        view = null;
      });
    };
  }
}

class EditPanel extends StatefulWidget{
  const EditPanel({super.key});

  @override
  State<StatefulWidget> createState() => _EditPanel();
}

class _EditPanel extends State<EditPanel>{
  ControlState? state;
  Control? cutOff;
  @override
  Widget build(BuildContext context) {
   return Container(
       width: 350,
       color: Colors.white70,
       child: LayoutBuilder(builder: (context,constrains) =>
           Row(
             children: [
               Column(
                 children:  <Widget>[if(cutOff != null) LongPressDraggable(
                   feedback: const Icon(Icons.edit, color: Colors.blue,),
                   data: Generator(() => cutOff!, accept: (){setState(() {  cutOff = null; });}),
                   child: const Card(child: Icon(Icons.folder_copy_outlined, color: Colors.blue,)))] + ((state != null)? [
                   IconButton(onPressed: (){setState(() { state = state?.access.parent; });}, icon: const Icon(Icons.open_in_new, color: Colors.blue,)),
                   if(state?.widget != null) IconButton(onPressed: (){setState(cut);}, icon: const Icon(Icons.cut, color: Colors.blue,)),
                   IconButton(onPressed: (){setState(remove);}, icon: const Icon(Icons.delete, color: Colors.blue,)),
                 ] : []),
               ),
               SizedBox(
                   width : 300,
                   child: DragTarget<ControlState>(
                     builder: (context, states, list){
                       return ListView(
                         children: state?.editView ?? [],
                       );
                     },
                     onAccept: (state){setState(() { this.state = state; });},
                   )
               ),

             ],
           ),)
   );
  }


  void remove() {
    state?.access.remove?.call();
    state = state?.access.parent;
  }

  void cut() {
    if(state?.widget != null) {
      cutOff = state?.widget;
      remove();
    }
  }
}

class WidgetGenerator extends StatelessWidget{
  final MapEntry<Type, Control Function()> data;
  const WidgetGenerator(this.data,{super.key});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        feedback: const Icon(Icons.queue, color: Colors.blue,),
        data: Generator(data.value),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.grey, Colors.white, Colors.grey],begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Text(data.key.toString()),
        ),
    );
  }
  
}

class TextPanel extends StatelessWidget{
  final String data;
  const TextPanel(this.data,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.of(context).pop(this);}, icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton( onPressed: (){Clipboard.setData(ClipboardData(text: data));}, icon : const Icon(Icons.copy))
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(data),
            ),
          )
        ],
      ),
    );
  }

}