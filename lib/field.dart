import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_designer/base.dart';
import 'package:flutter_designer/field_view.dart';

abstract class FieldListenable{
  void applyChange(void Function() fun);
}

abstract class Field<T>{
  final FieldListenable parent;
  final String name;
  final T? defaultValue;
  final String? defaultString;
  final bool isNamed;
  final bool isDefault;
  final bool isNullable;
  final bool isEditable;
  late final bool Function()? isRequired;
  late final bool Function(T?)? constrain;

  Field(this.parent,this.name,{this.defaultValue, this.defaultString, this.isNamed = true,this.isDefault = false, this.isNullable = true,bool Function()? isRequired, this.isEditable = true, bool Function(T?)? constrain}) :
    assert(isNullable || defaultValue != null),
    assert(!isDefault || defaultValue != null){
    this.isRequired = isRequired ?? () => false;
    this.constrain = constrain ?? (t) => true;
  }

  T? _value, _savedValue;

  T? get value{
    if(_value != _savedValue && constrain!(_savedValue))
      {
        _value = _savedValue;
      }
    return _value ?? defaultValue;
  }

  set value(T? v){
      if(constrain!(v)){
        parent.applyChange((){
          _value = v;
          _savedValue = v;
        });
      }else{
        _savedValue = v;
      }
  }

  T? get abstractValue => _value;

  bool get hasChanged => _value != null && _value != defaultValue;

  bool get isAddable => isRequired!() || !isNamed || hasChanged || (!isNullable && !isDefault) ;

  Widget get view;

  @override
  String toString({String prefix = ''}) {
    return  '$value';
  }

  String text({String prefix = ''}){
    return "$prefix${(isNamed)? '$name : ' : ''}${toString(prefix: prefix)},";
  }
}

abstract class CompositeField<T> extends Field<T> implements FieldListenable{
  CompositeField(super.parent,super.name,{super.defaultValue, super.defaultString, super.isNamed ,super.isDefault , super.isRequired, super.isNullable, super.isEditable , super.constrain});

  List<Field> get fields;

  String get constructor => T.toString();

  String fieldsText({String prefix = ''}) {
    return fields.where((e) => e.isAddable).map((e) => e.text(prefix: '$prefix\t\t')).join('\n');
  }

  @override
  String toString({String prefix = ''}) {
    return _value == null ? defaultString ?? '$defaultValue' : "$constructor(\n${fieldsText(prefix: prefix)}\n$prefix)";
  }

  @override
  Widget get view => ExpandedFieldView(this,  key: Key('$hashCode'),);
}

abstract class MultiTypeField<T> extends CompositeField<T>{
  MultiTypeField(super.parent,super.name,{super.defaultValue, super.defaultString, super.isNamed, super.isRequired, super.isDefault, super.isNullable, super.isEditable, super.constrain});

  int? index;

  List<Type> get types;

  @override
  void applyChange(void Function() fun) {
    fun();
    if(index == null || !fields[index!].hasChanged){
      value = null;
      return;
    }
    value = fields[index!].value;
  }

  void onChange(Type? t) {
    applyChange(() {
      index = t == null ? null : types.indexOf(t);
    });
  }

  @override
  String text({String prefix = ''}) {
    return index == null ? super.text(prefix: prefix) : fields[index!].text(prefix: prefix);
  }

  @override
  Widget get view => MultiTypeFieldView(this, key: Key('$hashCode'),);
}

abstract class ListField<T> extends Field<List<T>> implements FieldListenable{
  final int minLength;
  ListField(super.parent,super.name,{super.defaultValue, super.defaultString, super.isNamed, super.isRequired, super.isDefault, super.isNullable, super.isEditable, super.constrain, this.minLength = 0})
  {
    for(int i = 0; i < minLength; i++){
      fields.add(createField());
    }
  }
  var fields = <Field<T>>[];

  @override
  List<T>? get value {
    var l = fields.map((e) => e.value!).toList();
    return (fields.isEmpty || fields.length < minLength || !constrain!(l)) ? defaultValue : l;
  }

  @override
  bool get hasChanged => fields.any((element) => element.hasChanged);

  Field<T> createField();

  @override
  void applyChange(void Function() fun) {
    parent.applyChange(fun);
  }

  @override
  Widget get view => ListFieldView(this);

  @override
  String toString({String prefix = ''}) {
    return fields.isEmpty ? '$defaultValue' :  "[${fields.map((e) => e.text(prefix: prefix)).join('')}]";
  }
}

class StringField extends Field<String>{
  StringField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.isRequired});

  @override
  Widget get view => StringFieldView(this, key: Key('$hashCode'),);

  @override
  String toString({String prefix = ''}) {
    return "'$value'";
  }
}

class IntField extends Field<int>{
  IntField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.constrain});

  @override
  Widget get view => IntFieldView(this, key: Key('$hashCode'),);

}

class DoubleField extends Field<double>{
  DoubleField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.isRequired, super.constrain});

  @override
  Widget get view => DoubleFieldView(this, key: Key('$hashCode'),);

}

class BoolField extends Field<bool>{
  BoolField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.constrain, super.isRequired});

  @override
  Widget get view => BoolFieldView(this, key: Key('$hashCode'),);

}

class BiBoolField extends Field<bool>{
  BiBoolField(super.parent, super.name,{super.isNamed,super.isDefault , super.isEditable}) : super(isNullable: false,  defaultValue: true);

  @override
  Widget get view => BiBoolFieldView(this, key: Key('$hashCode'),);

}

class EnumField<T> extends Field<T>{
  final List<T> choices;
  final List<Widget>? widgets;
  EnumField(super.parent, super.name,{required this.choices,super.defaultValue, super.defaultString, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.isRequired, super.constrain , this.widgets});

  @override
  Widget get view => EnumFieldView(this, key: Key('$hashCode'),widgets: widgets,);


}

/*
  Fields
 */

class CounterField extends Field<int>{
  final int? min, max;
  final void Function(int) onPlus, onMinus;
  CounterField(super.parent, super.name,{this.min, this.max, required this.onPlus, required this.onMinus});

  @override
  Widget get view => IntFieldView(this, key: Key('$hashCode'),);

}

class ColorField extends Field<Color>{
  ColorField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.constrain});

  @override
  Widget get view => ColorFieldView(this, key: Key('$hashCode'),);

}

class AlignmentField extends EnumField<Alignment>{
  static const alignment = [
    Alignment.topLeft, Alignment.topCenter, Alignment.topRight,
    Alignment.centerLeft, Alignment.center, Alignment.centerRight,
    Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight,
  ];

  static var string = ['topLeft', 'topCenter', 'topRight', 'centerLeft', 'center', 'centerRight', 'bottomLeft', 'bottomCenter', 'bottomRight'].map((e) => Text(e)).toList();
  AlignmentField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.isRequired}) :
        super(
          choices: alignment,
        widgets: string
      );

 @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "Alignment.${string[alignment.indexOf(value!)].data}";
  }
}

class WidgetField extends Field<Widget>{
  WidgetField(super.parent, super.name,{super.isNamed,super.isDefault , super.isNullable, super.isRequired}) : super(isEditable : false);


  @override
  Widget? get value => _value ?? WidgetRoom(
      parent: parent as ControlState,
      name: name,
      accept: (widget){
        try{
          var value = widget.generate();
          this.value = value;
          value.access.parent = parent as ControlState;
          value.access.remove = (){
            this.value = null;
          };
          widget.accept?.call();
        }catch(e){
          widget.reject?.call();
        }
      });

  @override
  String toString({String prefix = ''}) {
    return "${_value == null ? 'ToDo' : (_value as Control).access.state?.text(prefix:  prefix)}";
  }

  @override
  Widget get view => throw UnimplementedError();

}

class ListWidgetField extends Field<List<Widget>> implements FieldListenable{
  ListWidgetField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable,super.isRequired}){
    _value = [];
  }

  late BiBoolField show = BiBoolField(this, name,);

  @override
  List<Widget>? get value => _value! + [if(show.value == true || _value!.isEmpty)  WidgetRoom(
      parent: parent as ControlState,
      name: name,
      accept: (widget){
        try{
          var value = widget.generate();
          applyChange(() {_value?.add(value);});
          value.access.parent = parent as ControlState;
          value.access.remove = (){
            applyChange(() {_value?.remove(value);});
          };
          widget.accept?.call();
        }catch(e){
          widget.reject?.call();
        }
      })];

  @override
  Widget get view => show.view;

  @override
  bool get hasChanged => _value!.isNotEmpty;

  @override
  void applyChange(void Function() fun) {
    parent.applyChange(fun);
  }

  @override
  String toString({String prefix = ''}) {
    return "[\n$prefix${_value!.map( (e) => (e as Control).access.state?.text(prefix:  prefix)).join('\n$prefix')}\n$prefix]";
  }

}

class TextStyleField extends CompositeField<TextStyle>{

  TextStyleField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable, super.isRequired});

  @override
  late var fields = <Field>[
    BoolField(this, 'inherit' , defaultValue : true, isNullable : false, isDefault: true),
    ColorField(this, 'color' ),
    ColorField(this, 'backgroundColor' ),
    DoubleField(this, 'fontSize' ),
    EnumField(this, 'fontWeight', choices : FontWeight.values ),
    EnumField(this, 'fontStyle', choices : FontStyle.values ),
    DoubleField(this, 'letterSpacing' ),
    DoubleField(this, 'wordSpacing' ),
    EnumField(this, 'textBaseline', choices : TextBaseline.values ),
    DoubleField(this, 'height' ),
    EnumField(this, 'leadingDistribution', choices : TextLeadingDistribution.values ),
    EnumField(this, 'decoration', choices: [TextDecoration.lineThrough, TextDecoration.overline, TextDecoration.underline], widgets: const [Text('lineThrough'), Text('overline'), Text('underline')]),
    ColorField(this, 'decorationColor' ),
    EnumField(this, 'decorationStyle', choices : TextDecorationStyle.values ),
    DoubleField(this, 'decorationThickness' ),
    StringField(this, 'debugLabel' ),
    StringField(this, 'fontFamily' ),
    StringField(this, 'package' ),
    EnumField(this, 'overflow', choices : TextOverflow.values ),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = TextStyle(
      inherit : fields[0].value,
      color : fields[1].value,
      backgroundColor : fields[2].value,
      fontSize : fields[3].value,
      fontWeight : fields[4].value,
      fontStyle : fields[5].value,
      letterSpacing : fields[6].value,
      wordSpacing : fields[7].value,
      textBaseline : fields[8].value,
      height : fields[9].value,
      leadingDistribution : fields[10].value,
      decoration: fields[11].value,
      decorationColor : fields[12].value,
      decorationStyle : fields[13].value,
      decorationThickness : fields[14].value,
      debugLabel : fields[15].value,
      fontFamily : fields[16].value,
      package : fields[17].value,
      overflow : fields[18].value,
    );
  }

}

class TextHeightBehaviorField extends CompositeField<TextHeightBehavior>{

  TextHeightBehaviorField(super.parent, super.name,{super.defaultValue, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    BoolField(this, 'applyHeightToFirstAscent' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'applyHeightToLastDescent' , defaultValue : true, isDefault : true, isNullable : false),
    EnumField(this, 'leadingDistribution', choices : TextLeadingDistribution.values , defaultValue : TextLeadingDistribution.proportional, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = TextHeightBehavior(
      applyHeightToFirstAscent : fields[0].value,
      applyHeightToLastDescent : fields[1].value,
      leadingDistribution : fields[2].value,
    );
  }

  @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "TextHeightBehavior(\n${fieldsText(prefix : prefix)}\n)";
  }
}

class EdgeInsetsField extends CompositeField<EdgeInsets>{

  EdgeInsetsField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    DoubleField(this, 'left' , isNullable : false, defaultValue: 0, isNamed: false),
    DoubleField(this, 'top' , isNullable : false, defaultValue: 0, isNamed: false),
    DoubleField(this, 'right' , isNullable : false, defaultValue: 0, isNamed: false),
    DoubleField(this, 'bottom' , isNullable : false, defaultValue: 0, isNamed: false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = EdgeInsets.fromLTRB(
      fields[0].value,
      fields[1].value,
      fields[2].value,
      fields[3].value,
    );
  }

  @override
  String get constructor => "EdgeInsets.fromLTRB";
}

class BorderSideField extends CompositeField<BorderSide>{

  BorderSideField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    ColorField(this, 'color' , defaultValue : Colors.white, isDefault : true, isNullable : false),
    DoubleField(this, 'width' , defaultValue : 1.0, isDefault : true, isNullable : false),
    EnumField(this, 'style', choices : BorderStyle.values , defaultValue : BorderStyle.solid, isDefault : true, isNullable : false),
    EnumField(this, 'strokeAlign' ,choices: StrokeAlign.values, defaultValue : StrokeAlign.inside, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = BorderSide(
      color : fields[0].value,
      width : fields[1].value,
      style : fields[2].value,
      strokeAlign : fields[3].value,
    );
  }
}

class  BorderRadiusGeometryField extends Field<BorderRadiusGeometry> implements FieldListenable{
  BorderRadiusGeometryField(super.parent, super.name,{super.defaultValue,super.isDefault, super.isNamed, super.isNullable, super.isEditable, super.constrain});

  late DoubleField radius = DoubleField(this, name);

  @override
  Widget get view => radius.view;

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!radius.hasChanged){
      value = null;
      return;
    }
    value = BorderRadius.circular(radius.value!);
  }

  @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "BorderRadius.circular(${radius.value})";
  }

}

class ContinuousRectangleBorderField extends CompositeField<ContinuousRectangleBorder>{

  ContinuousRectangleBorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    BorderSideField(this, 'side' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderRadiusGeometryField(this, 'borderRadius', defaultValue : BorderRadius.zero, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = ContinuousRectangleBorder(
      side : fields[0].value,
      borderRadius : fields[1].value,
    );
  }
}

class CircleBorderField extends CompositeField<CircleBorder>{

  CircleBorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    BorderSideField(this, 'side' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = CircleBorder(
      side : fields[0].value,
    );
  }

}

class RoundedRectangleBorderField extends CompositeField<RoundedRectangleBorder>{

  RoundedRectangleBorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    BorderSideField(this, 'side' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderRadiusGeometryField(this, 'borderRadius', defaultValue : BorderRadius.zero, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = RoundedRectangleBorder(
      side : fields[0].value,
      borderRadius : fields[1].value,
    );
  }
}

class BeveledRectangleBorderField extends CompositeField<BeveledRectangleBorder>{

  BeveledRectangleBorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = <Field>[
    BorderSideField(this, 'side' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderRadiusGeometryField(this, 'borderRadius', defaultValue : BorderRadius.zero, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = BeveledRectangleBorder(
      side : fields[0].value,
      borderRadius : fields[1].value,
    );
  }
}

class ShapeBorderField extends MultiTypeField<ShapeBorder>{
  ShapeBorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable});

  @override
  late var fields = [
    ContinuousRectangleBorderField(this, name),
    RoundedRectangleBorderField(this, name),
    CircleBorderField(this, name),
    BeveledRectangleBorderField(this, name)
  ];

  @override
  var types = [
    ContinuousRectangleBorder,
    RoundedRectangleBorder,
    CircleBorder,
    BeveledRectangleBorder
  ];
}

class ClosureField<T> extends Field<T>{
  ClosureField(super.parent, super.name,{super.defaultValue, super.defaultString, super.isDefault, super.isNamed, super.isRequired, super.isNullable,}): super(isEditable : false);

  @override
  String toString({String prefix = ''}) {
    return defaultString ?? 'ToDo';
  }
  @override
  Widget get view => throw UnimplementedError();

}

class BoxConstraintsField extends CompositeField<BoxConstraints>{

  BoxConstraintsField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    DoubleField(this, 'minWidth' , defaultValue : 0.0, isDefault : true, isNullable : false),
    DoubleField(this, 'maxWidth' , defaultValue : double.infinity, isDefault : true, isNullable : false),
    DoubleField(this, 'minHeight' , defaultValue : 0.0, isDefault : true, isNullable : false),
    DoubleField(this, 'maxHeight' , defaultValue : double.infinity, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = BoxConstraints(
      minWidth : fields[0].value,
      maxWidth : fields[1].value,
      minHeight : fields[2].value,
      maxHeight : fields[3].value,
    );
  }
}

class BorderField extends CompositeField<Border>{

  BorderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    BorderSideField(this, 'top' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderSideField(this, 'right' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderSideField(this, 'bottom' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
    BorderSideField(this, 'left' , defaultValue : BorderSide.none, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = Border(
      top : fields[0].value,
      right : fields[1].value,
      bottom : fields[2].value,
      left : fields[3].value,
    );
  }
}

class OffsetField extends CompositeField<Offset>{

  OffsetField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    DoubleField(this, 'dx' , isNullable : false, defaultValue: 0),
    DoubleField(this, 'dy' , isNullable : false, defaultValue: 0),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = Offset(
      fields[0].value,
      fields[1].value,
    );
  }
}

class BoxShadowField extends CompositeField<BoxShadow>{

  BoxShadowField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    ColorField(this, 'color' , defaultValue : Colors.black, isDefault : true, isNullable : false),
    OffsetField(this, 'offset', defaultValue : Offset.zero, isDefault : true, isNullable : false),
    DoubleField(this, 'blurRadius' , defaultValue : 0.0, isDefault : true, isNullable : false),
    DoubleField(this, 'spreadRadius' , defaultValue : 0.0, isDefault : true, isNullable : false),
    EnumField(this, 'blurStyle', choices : BlurStyle.values , defaultValue : BlurStyle.normal, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = BoxShadow(
      color : fields[0].value,
      offset : fields[1].value,
      blurRadius : fields[2].value,
      spreadRadius : fields[3].value,
      blurStyle : fields[4].value,
    );
  }
}

class BoxDecorationField extends CompositeField<BoxDecoration>{

  BoxDecorationField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    ColorField(this, 'color' ),
    BorderField(this, 'border' ),
    BorderRadiusGeometryField(this, 'borderRadius', constrain: (v) => fields[1].value == null || (fields[1].value as Border).isUniform),
    ListBoxShadowField(this, 'boxShadow' ),
    GradientField(this, 'gradient' ),
    EnumField(this, 'backgroundBlendMode', choices : BlendMode.values ),
    EnumField(this, 'shape', choices : BoxShape.values , defaultValue : BoxShape.rectangle, isDefault : true, isNullable : false),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = BoxDecoration(
      color : fields[0].value,
      border : fields[1].value,
      borderRadius : fields[2].value,
      boxShadow : fields[3].value,
      gradient : fields[4].value,
      backgroundBlendMode : fields[5].value,
      shape : fields[6].value,
    );
  }
}

class ListDoubleField extends ListField<double>{
  ListDoubleField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  Field<double> createField() {
    return DoubleField(this, 'item', isNamed: false, defaultValue : 0, isNullable : false);
  }

}

class ListColorField extends ListField<Color>{

  ListColorField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain, super.minLength});

  @override
  Field<Color> createField() {
    return ColorField(this, 'item'  , isNamed : false, defaultValue : Colors.black, isNullable : false);
  }

}

class ListBoxShadowField extends ListField<BoxShadow>{

  ListBoxShadowField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  Field<BoxShadow> createField() {
    return BoxShadowField(this, 'item'  , isNamed : false, defaultValue : const BoxShadow(), isNullable : false);
  }

}

class LinearGradientField extends CompositeField<LinearGradient>{

  LinearGradientField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    AlignmentField(this, 'begin' , defaultValue : Alignment.centerLeft, isDefault : true, isNullable : false),
    AlignmentField(this, 'end' , defaultValue : Alignment.centerRight, isDefault : true, isNullable : false),
    ListColorField(this, 'colors' , isNullable : false, defaultValue : [Colors.white, Colors.black], isRequired : () => true, minLength: 2),
    ListDoubleField(this, 'stops' , constrain: (v) => value == null || (fields[2].value as List).length == v!.length),
    EnumField(this, 'tileMode', choices : TileMode.values , defaultValue : TileMode.clamp, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = LinearGradient(
      begin : fields[0].value,
      end : fields[1].value,
      colors : fields[2].value,
      stops : fields[3].value,
      tileMode : fields[4].value,
    );
  }
}

class RadialGradientField extends CompositeField<RadialGradient>{

  RadialGradientField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    AlignmentField(this, 'center' , defaultValue : Alignment.center, isDefault : true, isNullable : false),
    DoubleField(this, 'radius' , defaultValue : 0.5, isDefault : true, isNullable : false),
    ListColorField(this, 'colors' , isNullable : false, defaultValue : [Colors.white, Colors.black], isRequired : () => true, minLength: 2),
    ListDoubleField(this, 'stops' , constrain: (v) => value == null || (fields[2].value as List).length == v!.length),
    EnumField(this, 'tileMode', choices : TileMode.values , defaultValue : TileMode.clamp, isDefault : true, isNullable : false),
    AlignmentField(this, 'focal' ),
    DoubleField(this, 'focalRadius' , defaultValue : 0.0, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = RadialGradient(
      center : fields[0].value,
      radius : fields[1].value,
      colors : fields[2].value,
      stops : fields[3].value,
      tileMode : fields[4].value,
      focal : fields[5].value,
      focalRadius : fields[6].value,
    );
  }
}

class GradientField extends MultiTypeField<Gradient>{
  GradientField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isNullable, super.isEditable, super.constrain, super.isRequired});

  @override
  late var fields = [
    LinearGradientField(this, name),
    RadialGradientField(this, name),
  ];

  @override
  var types = [
    LinearGradient,
    RadialGradient
  ];
}

class CurveField extends EnumField<Curve>{
  static const curves = [Curves.linear, Curves.easeIn, Curves.easeOut,];

  static var string = const [Text('Linear'), Text('Ease In'),Text('Ease Out')];
  CurveField(super.parent, super.name,{super.defaultValue, super.isNamed,super.isDefault , super.isNullable, super.isEditable}) :
        super(
          choices: curves,
          widgets: string
      );

  @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "Curves.${string[curves.indexOf(value!)].data}";
  }
}

class DurationField extends CompositeField<Duration>{

  DurationField(super.parent, super.name,{super.defaultValue, super.defaultString, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    IntField(this, 'days' , defaultValue : 0, isDefault : true, isNullable : false),
    IntField(this, 'hours' , defaultValue : 0, isDefault : true, isNullable : false),
    IntField(this, 'minutes' , defaultValue : 0, isDefault : true, isNullable : false),
    IntField(this, 'seconds' , defaultValue : 0, isDefault : true, isNullable : false),
    IntField(this, 'milliseconds' , defaultValue : 0, isDefault : true, isNullable : false),
    IntField(this, 'microseconds' , defaultValue : 0, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = Duration(
      days : fields[0].value,
      hours : fields[1].value,
      minutes : fields[2].value,
      seconds : fields[3].value,
      milliseconds : fields[4].value,
      microseconds : fields[5].value,
    );
  }
}

class DragTargetBuilderField extends Field<DragTargetBuilder> implements FieldListenable{

  DragTargetBuilderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.constrain}) : super(isEditable : false){
    _value = _savedValue = (context, canData, rejectData) => widget.value!;
  }

  late var widget = WidgetField(parent, 'widget' ,);

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!widget.hasChanged){
      value = null;
      return;
    }
    value = (context, canData, rejectData) => widget.value!;
  }

  @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "(context, canData, rejectData) => ${widget.text(prefix: prefix)}";
  }

  @override
  Widget get view => throw UnimplementedError();

}

class MouseCursorField extends EnumField<SystemMouseCursor>{
  static const values = [SystemMouseCursors.alias, SystemMouseCursors.allScroll,SystemMouseCursors.basic,
    SystemMouseCursors.cell, SystemMouseCursors.click,SystemMouseCursors.forbidden,
    SystemMouseCursors.grabbing,SystemMouseCursors.grab,SystemMouseCursors.help,
    SystemMouseCursors.move, SystemMouseCursors.none,SystemMouseCursors.noDrop,
    SystemMouseCursors.precise, SystemMouseCursors.progress,SystemMouseCursors.resizeColumn,
    SystemMouseCursors.resizeDown,SystemMouseCursors.resizeDownLeft,SystemMouseCursors.resizeDownRight,
    SystemMouseCursors.resizeLeft, SystemMouseCursors.resizeLeftRight,SystemMouseCursors.resizeRight,
    SystemMouseCursors.resizeRow, SystemMouseCursors.resizeUp,SystemMouseCursors.resizeUpDown,
    SystemMouseCursors.resizeUpLeft,SystemMouseCursors.resizeUpLeftDownRight,SystemMouseCursors.resizeUpRight,
    SystemMouseCursors.resizeUpRightDownLeft, SystemMouseCursors.text,SystemMouseCursors.verticalText,SystemMouseCursors.wait,
    SystemMouseCursors.zoomIn,SystemMouseCursors.zoomOut];

  static var string = ['alias', 'allScroll', 'basic', 'cell', 'click', 'forbidden', 'grabbing', 'grab', 'help', 'move',
    'none', 'noDrop', 'precise', 'progress', 'resizeColumn', 'resizeDown', 'resizeDownLeft', 'resizeDownRight',
    'resizeLeft', 'resizeLeftRight', 'resizeRight', 'resizeRow', 'resizeUp', 'resizeUpDown', 'resizeUpLeft',
    'resizeUpLeftDownRight', 'resizeUpRight', 'resizeUpRightDownLeft', 'text', 'verticalText', 'wait', 'zoomIn', 'zoomOut'].map((e) => Text(e)).toList();

  MouseCursorField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain}) :
        super(
          choices: values,
          widgets: string
      );

  @override
  String toString({String prefix = ''}) {
    return _value == null ? '$defaultValue' : "SystemMouseCursors.${string[values.indexOf(value!)].data}";
  }
}

class IconDataField extends CompositeField<IconData>{

  IconDataField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    IntField(this, 'codePoint' , isNullable : false, defaultValue : 0, isNamed: false),
    StringField(this, 'fontFamily', defaultValue: 'MaterialIcons' ),
    StringField(this, 'fontPackage' ),
    BoolField(this, 'matchTextDirection' , defaultValue : false, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = IconData(
      fields[0].value,
      fontFamily : fields[1].value,
      fontPackage : fields[2].value,
      matchTextDirection : fields[3].value,
    );
  }
}

class VisualDensityField extends CompositeField<VisualDensity>{

  VisualDensityField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    DoubleField(this, 'horizontal' , defaultValue : 0.0, isDefault : true, isNullable : false),
    DoubleField(this, 'vertical' , defaultValue : 0.0, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = VisualDensity(
      horizontal : fields[0].value,
      vertical : fields[1].value,
    );
  }
}

class FocusNodeField extends CompositeField<FocusNode>{

  FocusNodeField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    StringField(this, 'debugLabel' ),
    BoolField(this, 'skipTraversal' , defaultValue : false, isDefault : true, isNullable : false),
    BoolField(this, 'canRequestFocus' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'descendantsAreFocusable' , defaultValue : true, isDefault : true, isNullable : false),
    BoolField(this, 'descendantsAreTraversable' , defaultValue : true, isDefault : true, isNullable : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = FocusNode(
      debugLabel : fields[0].value,
      skipTraversal : fields[1].value,
      canRequestFocus : fields[2].value,
      descendantsAreFocusable : fields[3].value,
      descendantsAreTraversable : fields[4].value,
    );
  }
}

class SystemUiOverlayStyleField extends CompositeField<SystemUiOverlayStyle>{

  SystemUiOverlayStyleField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    ColorField(this, 'systemNavigationBarColor' ),
    ColorField(this, 'systemNavigationBarDividerColor' ),
    EnumField(this, 'systemNavigationBarIconBrightness', choices : Brightness.values ),
    BoolField(this, 'systemNavigationBarContrastEnforced' ),
    ColorField(this, 'statusBarColor' ),
    EnumField(this, 'statusBarBrightness', choices : Brightness.values ),
    EnumField(this, 'statusBarIconBrightness', choices : Brightness.values ),
    BoolField(this, 'systemStatusBarContrastEnforced' )
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = SystemUiOverlayStyle(
      systemNavigationBarColor : fields[0].value,
      systemNavigationBarDividerColor : fields[1].value,
      systemNavigationBarIconBrightness : fields[2].value,
      systemNavigationBarContrastEnforced : fields[3].value,
      statusBarColor : fields[4].value,
      statusBarBrightness : fields[5].value,
      statusBarIconBrightness : fields[6].value,
      systemStatusBarContrastEnforced : fields[7].value,
    );
  }
}

class SizeField extends CompositeField<Size>{

  SizeField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    DoubleField(this, 'width' , isNullable : false, defaultValue : 100, isNamed: false),
    DoubleField(this, 'height' , isNullable : false, defaultValue : 100, isNamed : false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = Size(
      fields[0].value,
      fields[1].value,
    );
  }
}

class PreferredSizeField extends Field<PreferredSize> implements FieldListenable{

  PreferredSizeField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  late var size = SizeField(this, 'preferredSize' , isNullable : false, defaultValue : const Size(100,100), isRequired : () => true);
  late var widget = WidgetField(parent, 'child' , isRequired : () => true);

  @override
  PreferredSize get value => PreferredSize(
    preferredSize : size.value!,
    child : widget.value!,
  );

  @override
  bool get hasChanged => widget.hasChanged || size.hasChanged;

  @override
  void applyChange(void Function() fun) {
    parent.applyChange(fun);
  }

  @override
  Widget get view => size.view;

  @override
  String toString({String prefix = ''}) {
    // TODO: implement toString
    return 'PreferredSize( preferredSize : ${size.value!},\n$prefix child : ${widget.text(prefix: prefix)}, )';
  }
}

class IconThemeDataField extends CompositeField<IconThemeData>{

  IconThemeDataField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    DoubleField(this, 'size' ),
    ColorField(this, 'color' ),
    DoubleField(this, 'opacity' ),
    ListBoxShadowField(this, 'shadows' ),
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = IconThemeData(
      size : fields[0].value,
      color : fields[1].value,
      opacity : fields[2].value,
      shadows : fields[3].value,
    );
  }
}

class WidgetBuilderField extends Field<WidgetBuilder> implements FieldListenable{

  WidgetBuilderField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.constrain}) : super(isEditable : false);

  late var widget = WidgetField(parent, 'child' , isRequired : () => true, isNamed: false);

  @override
  WidgetBuilder get value => (context) => widget.value!;

  @override
  bool get hasChanged => widget.hasChanged;

  @override
  void applyChange(void Function() fun) {
    parent.applyChange(fun);
  }

  @override
  String text({String prefix = ''}) {
    return '$prefix$name : (context) => ${widget.text(prefix: prefix)}';
  }

  @override
  Widget get view => throw UnimplementedError();
}

class BottomNavigationBarItemField extends CompositeField<BottomNavigationBarItem>{

  BottomNavigationBarItemField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    WidgetField(parent, 'icon' , isRequired : () => true),
    StringField(this, 'label', defaultValue: name, isNullable: false ),
    WidgetField(parent, 'activeIcon' ),
    ColorField(this, 'backgroundColor' ),
    StringField(this, 'tooltip' )
  ];

  @override
  BottomNavigationBarItem? get value => BottomNavigationBarItem(
    icon : fields[0].value,
    label : fields[1].value,
    activeIcon : fields[2].value,
    backgroundColor : fields[3].value,
    tooltip : fields[4].value,
  );

  @override
  void applyChange(void Function() fun) {
    parent.applyChange(fun);

  }

  @override
  String toString({String prefix = ''}) {
    return "$constructor(\n${fieldsText(prefix: prefix)}\n$prefix)";
  }

}

class ListBottomNavigationBarItemField extends ListField<BottomNavigationBarItem>{

  ListBottomNavigationBarItemField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain, super.minLength});

  @override
  Field<BottomNavigationBarItem> createField() {
    return BottomNavigationBarItemField(parent, 'item${fields.length+1}' ,isNamed : false);
  }

}

class DateTimeField extends CompositeField<DateTime>{

  DateTimeField(super.parent, super.name,{super.defaultValue, super.isDefault, super.isNamed, super.isRequired, super.isNullable, super.isEditable, super.constrain});

  @override
  late var fields = <Field>[
    IntField(this, 'year' , isNullable : false, defaultValue : 2000, isNamed: false),
    IntField(this, 'month' , defaultValue : 1, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'day' , defaultValue : 1, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'hour' , defaultValue : 0, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'minute' , defaultValue : 0, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'second' , defaultValue : 0, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'millisecond' , defaultValue : 0, isDefault : true, isNullable : false, isNamed: false),
    IntField(this, 'microsecond' , defaultValue : 0, isDefault : true, isNullable : false, isNamed: false)
  ];

  @override
  void applyChange(void Function() fun) {
    fun();
    if(!fields.any((f) => f.hasChanged)){
      value = null;
      return;
    }
    value = DateTime(
      fields[0].value,
      fields[1].value,
      fields[2].value,
      fields[3].value,
      fields[4].value,
      fields[5].value,
      fields[6].value,
      fields[7].value,
    );
  }
}