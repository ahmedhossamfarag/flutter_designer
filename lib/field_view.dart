import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_designer/dynamic.dart';
import 'package:flutter_designer/field.dart';

abstract class FieldView<T extends Field> extends StatelessWidget{
  final T field;
  const FieldView(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 25,
            alignment: Alignment.centerLeft,
            child: Text(field.name, style: const TextStyle(fontSize: 16), overflow: TextOverflow.clip,),
          ),
          SizedBox(
            width: 150,
            height: 25,
            child: displayField(),
          )
        ],
      ),
    );
  }

  Widget displayField();
}

abstract class TextFieldView<T> extends FieldView<Field<T>>{
  final List<TextInputFormatter> formatter;
  const TextFieldView(super.field, {this.formatter = const <TextInputFormatter>[], super.key});

  @override
  Widget displayField(){
    return TextFormField(
      initialValue: field.abstractValue?.toString(),
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: formatter,
      onChanged: (v){change(v.isEmpty ? null : v);},
    );
  }

  void change(String? v);
}

class StringFieldView extends TextFieldView<String?>{
  const StringFieldView(super.field, {super.key});

  @override
  void change(String? v) =>  field.value = v;


}

class IntFieldView extends TextFieldView<int?>{
  IntFieldView(super.field, {super.key}) :
        super(formatter: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]);

  @override
  void change(String? v) =>  field.value = v != null ? int.tryParse(v) : null;
}

class DoubleFieldView extends TextFieldView<double?>{
  DoubleFieldView(super.field, {super.key}) :
        super(formatter : [FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]?[0-9]*'))]);

  @override
  void change(String? v) =>  field.value =  v != null ? double.tryParse(v) : null;
}

class BoolFieldView extends FieldView<BoolField>{

  const BoolFieldView(super.field, {super.key});

  @override
  Widget displayField() {
    return DynamicCheckBox(checked : field.abstractValue, onChange: (v){field.value = v;});
  }

}

class BiBoolFieldView extends FieldView<BiBoolField>{

  const BiBoolFieldView(super.field, {super.key});

  @override
  Widget displayField() {
    return DynamicSwitch(value : field.abstractValue ?? true , onChanged: (v){field.value = v;});
  }

}

class EnumFieldView<T> extends FieldView<EnumField<T>>{
  final List<Widget> ?widgets;
  const EnumFieldView(super.field,{super.key, this.widgets});


  @override
  Widget displayField(){
    return  DynamicDropdownButton(initial: field.abstractValue,choices: field.choices, onChange: (v){field.value = v;}, widgets: widgets,);
  }

}

class ExpandedFieldView<T> extends FieldView<CompositeField<T>>{
  const ExpandedFieldView(super.field, {super.key});

  List<Widget> get editView => field.fields.where((element) => element.isEditable).map((e) => e.view).toList();


  @override
  Widget build(BuildContext context){
    return DynamicExpansionPanel(
      header: field.name,
      body: displayField(),
    );
  }

  @override
  Widget displayField() {
    return
        Column(
          children: editView,
        );
  }
}

class MultiTypeFieldView<T> extends FieldView<MultiTypeField<T>>{
  const MultiTypeFieldView(super.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColumn<Type>(
        name: field.name,
        choices: field.types,
        widgets: field.fields.map((e) => e.view).toList(),
        onChange: field.onChange,
    );
  }

  @override
  Widget displayField() {
    throw UnimplementedError();
  }

}

class ListFieldView<T> extends FieldView<ListField<T>>{
  const ListFieldView(super.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicList(
        name: field.name,
        widgets: field.fields.map((e) => e.view).toList(),
        min: field.minLength,
        onPlus: (i, list){
          var x = field.createField();
          field.applyChange(() {field.fields.add(x);});
          list.add(x.view);
        },
        onMinus: (i, list){
          field.applyChange(() {field.fields.removeLast();});
          list.removeLast();
        }
    );
  }

  @override
  Widget displayField() {
    throw UnimplementedError();
  }

}

class ColorFieldView extends TextFieldView<Color?>{
  ColorFieldView(super.field, {super.key}) :
        super(formatter : [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]*'))]);

  @override
  void change(String? v) =>  field.value =  v != null ? Color(int.parse('0x$v')) : null;
}

class CounterFieldView extends FieldView<CounterField>{
  const CounterFieldView(super.field, {super.key});

  @override
  Widget displayField() {
    return DynamicCounter(onPlus: field.onPlus, onMinus: field.onMinus, min: field.min ?? 0, max: field.max ?? 100,);
  }

}