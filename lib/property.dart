
/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'display.dart';

abstract class Property<T> extends StatelessWidget{
  final String label;
  final T initial;
  final void Function(T value) onchange;
  const Property(this.label, this.initial, this.onchange, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 45,
            alignment: Alignment.centerLeft,
            child: Text(label),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: displayField(),
          )
        ],
      ),
    );
  }

  Widget displayField();
}

abstract class TextProperty<T> extends Property<T>{
  final List<TextInputFormatter> formatter;
  const TextProperty(super.label, super.initial, super.onchange, this.formatter, {super.key});

  @override
  Widget displayField(){
  return TextFormField(
    initialValue: initial?.toString(),
    inputFormatters: formatter,
    onChanged: change,
  );
  }

  void change(String? v);
}

class StringProperty extends TextProperty<String?>{
  StringProperty(String label, String? initial, void Function(String?) onchange, {super.key}) : super(label, initial, onchange, []);

  @override
  void change(String? v) =>  onchange(v);


}

class IntProperty extends TextProperty<int?>{
  IntProperty(String label, int? initial, void Function(int?) onchange, {super.key}) :
        super(label, initial, onchange, [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]);

  @override
  void change(String? v) =>  onchange(v != null ? int.tryParse(v) : null);
}

class DoubleProperty extends TextProperty<double?>{
  DoubleProperty(String label, double? initial, void Function(double?) onchange, {super.key}) :
        super(label, initial, onchange, [FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]?[0-9]*'))]);

  @override
  void change(String? v) =>  onchange(v != null ? double.tryParse(v) : null);
}

class BooleanProperty extends Property<bool?>{

  const BooleanProperty(super.label, super.initial, super.onchange, {super.key});

  @override
  Widget displayField() {
    return ChangeCheckBox(initial, onchange);
  }

}

class EnumProperty<T> extends Property<T?>{
  final List<T> choices;
  final List<Widget> ?widgets;
  const EnumProperty(super.label, super.initial, this.choices, super.onchange, {super.key, this.widgets});


  @override
  Widget displayField(){
    return  ChangeDropdownButton(initial, choices, onchange, widgets: widgets,);
  }

}

abstract class ExpandedProperty<T> extends Property<T>{
  const ExpandedProperty(super.label, super.initial, super.onchange, {super.key});

  @override
  Widget build(BuildContext context){
    return ChangeExpansionPanel(
      label,
      displayField(),
    );
  }
}

//

class AlignmentProperty extends EnumProperty<AlignmentGeometry?>{
  AlignmentProperty(String label, AlignmentGeometry? initial, void Function(AlignmentGeometry?) onchange, {super.key}): super(
    label, initial, [
      Alignment.topLeft, Alignment.topCenter, Alignment.topRight,
    Alignment.centerLeft, Alignment.center, Alignment.centerRight,
    Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight,
  ], onchange, widgets : [
    const Text('Top Left'),const Text('Top Center'),const Text('Top Right'),
    const Text('Center Left'),const Text('Center'),const Text('Center Right'),
    const Text('Bottom Left'),const Text('Bottom Center'),const Text('Bottom Right'),
  ]
  );

}

//

class BorderProperty extends ExpandedProperty<ShapeBorder?>{
  const BorderProperty(super.label, super.initial, super.onchange, {super.key});

  @override
  Widget displayField() => BorderPropertyWidget(this);

}

class BorderSideProperty extends ExpandedProperty<BorderSide>{
  final side = [const BorderSide()];
  BorderSideProperty(super.label, super.initial, super.onchange, {super.key}){
    side[0] = initial;
  }

  @override
  Widget displayField() {
    return Column(
      children:[
        ColorProperty('Color', side[0].color, (c){side[0] = side[0].copyWith(color: c); onchange(side[0]);}),
        DoubleProperty('Width', side[0].width, (c){side[0] = side[0].copyWith(width: c); onchange(side[0]);}),
        EnumProperty('Style', side[0].style,BorderStyle.values, (c){side[0] = side[0].copyWith(style: c); onchange(side[0]);}),
      ]
    );
  }

}
class BorderPropertyWidget extends StatefulWidget{
  final BorderProperty property;
  const BorderPropertyWidget(this.property,{super.key});

  @override
  State<StatefulWidget> createState() => _BorderPropertyWidget();

}
enum BorderType{
  border,
  roundedRectangleBorder,
  continuousRectangleBorder,
  beveledRectangleBorder,
  circleBorder,
  stadiumBorder,
}
class _BorderPropertyWidget extends State<BorderPropertyWidget>{
  BorderType? type;
  BorderSide side = BorderSide.none, top = BorderSide.none , left = BorderSide.none, bottom = BorderSide.none, right = BorderSide.none;
  List<double?> radius = List.filled(4, null);
  BorderStyle? style;

  @override
  void initState(){
    super.initState();
    if(widget.property.initial != null){
      var x = widget.property.initial;
      if(x is Border){
        type = BorderType.border; top = x.top; bottom = x.bottom; left = x.left; right = x.right;
      }else if(x is CircleBorder){
        type = BorderType.circleBorder; side = x.side;
      }else if(x is RoundedRectangleBorder){
        type = BorderType.roundedRectangleBorder; side = x.side;
        var r = x.borderRadius as BorderRadius;
        radius = [r.topLeft.x, r.topRight.x, r.bottomLeft.x, r.bottomRight.x];
      }else if (x is ContinuousRectangleBorder){
        type = BorderType.continuousRectangleBorder; side = x.side;
        var r = x.borderRadius as BorderRadius;
        radius = [r.topLeft.x, r.topRight.x, r.bottomLeft.x, r.bottomRight.x];
      }else if (x is BeveledRectangleBorder){
        type = BorderType.beveledRectangleBorder; side = x.side;
        var r = x.borderRadius as BorderRadius;
        radius = [r.topLeft.x, r.topRight.x, r.bottomLeft.x, r.bottomRight.x];
      }else if (x is StadiumBorder){
        type = BorderType.stadiumBorder; side = x.side;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          EnumProperty('Border Type', type, BorderType.values, (t){setState(() { type = t;  update();});}),
          Column(
            children: type == null ? [] :
                type == BorderType.border?
                  [
                  BorderSideProperty('Top', top, (value) { top = value; update(); }),
                  BorderSideProperty('Left', left, (value) { left = value; update(); }),
                  BorderSideProperty('Bottom', bottom, (value) { bottom = value; update(); }),
                  BorderSideProperty('Right', right, (value) { right = value; update(); }),
                  ] :
                type == BorderType.circleBorder || type == BorderType.stadiumBorder ?
                  [
                  BorderSideProperty('Side', top, (value) { side = value; update();}),
                  ] :
                  [
                  BorderSideProperty('Side', top, (value) { side = value; update();}),
                  DoubleProperty('TopLeft Radius', radius[0], (v) {radius[0] = v; update();} ),
                  DoubleProperty('TopRight Radius', radius[1], (v) {radius[1] = v; update();} ),
                  DoubleProperty('BottomLeft Radius', radius[2], (v) {radius[2] = v; update();} ),
                  DoubleProperty('BottomRight Radius', radius[3], (v) {radius[3] = v; update();} ),
                 ]
          )
        ],
      );
  }

  void update(){
    var r = BorderRadius.only(topLeft: Radius.circular(radius[0] ?? 0),topRight: Radius.circular(radius[1] ?? 0),bottomLeft: Radius.circular(radius[2] ?? 0),bottomRight: Radius.circular(radius[3] ?? 0));
    switch(type){
      case BorderType.border : widget.property.onchange(Border(top: top, bottom: bottom, right: right, left: left)); break;
      case BorderType.circleBorder : widget.property.onchange(CircleBorder(side: side)); break;
      case BorderType.stadiumBorder : widget.property.onchange(StadiumBorder(side: side)); break;
      case BorderType.roundedRectangleBorder : widget.property.onchange(RoundedRectangleBorder(side: side, borderRadius: r)); break;
      case BorderType.continuousRectangleBorder: widget.property.onchange(ContinuousRectangleBorder(side: side, borderRadius: r)); break;
      case BorderType.beveledRectangleBorder : widget.property.onchange(BeveledRectangleBorder(side: side,borderRadius: r)); break;
      case null: widget.property.onchange(null);
    }
  }
}

extension<T> on List<T>{
  bool all(bool Function(T) f){
    return !any((element) => !f(element));
  }

  bool allEqual(T value) => all((e) => e == value);
}

//

class ColorProperty extends ExpandedProperty<Color?>{
  final List<int?> color = List.filled(4, null);
  ColorProperty(super.label, super.initial, super.onchange, {super.key}){
    color[0] = initial?.alpha;
    color[1] = initial?.red;
    color[2] = initial?.green;
    color[3] = initial?.blue;
  }

  @override
  Widget displayField() {
    return Column(
      children: [
        IntProperty('Alpha', color[0], (p0) {  color[0] = p0; update();}),
        IntProperty('Red', color[1], (p0) { color[1] = p0; update(); }),
        IntProperty('Green', color[2], (p0) {  color[2] = p0; update();}),
        IntProperty('Blue', color[3], (p0) { color[3] = p0; update(); })
      ],
    );
  }

  void update(){
    if(color.allEqual(null)) {
      onchange(null);
    }
    else {
      onchange(Color.fromARGB(color[0]??0, color[1]??0, color[2]??0, color[3]??0));
    }
  }
}

//

class PaddingProperty extends ExpandedProperty<EdgeInsets?>{
  final List<double?> padding = List.filled(4, null);
 PaddingProperty(super.label, super.initial, super.onchange, {super.key}){
    padding[0] = initial?.left;
    padding[1] = initial?.top;
    padding[2] = initial?.right;
    padding[3] = initial?.bottom;
  }

  @override
  Widget displayField() {
    return Column(
      children: [
        DoubleProperty('Left', padding[0], (p0) {  padding[0] = p0; update(); }),
        DoubleProperty('Top', padding[1], (p0) { padding[1] = p0; update();  }),
        DoubleProperty('Right', padding[2], (p0) {  padding[2] = p0; update(); }),
        DoubleProperty('Bottom', padding[3], (p0) { padding[3] = p0;  update(); })
      ],
    );
  }

  void update(){
   if(padding.allEqual(null)){
       onchange(null);
   }
   else{
     onchange(EdgeInsets.fromLTRB(padding[0]??0, padding[1]??0, padding[2]??0, padding[3]??0));
   }
  }

}

//

class ConstraintsProperty extends ExpandedProperty<BoxConstraints?>{
  final List<double?> size = List.filled(4, null);
 ConstraintsProperty(super.label, super.initial, super.onchange, {super.key}){
    size[0] = initial?.minWidth;
    size[1] = initial?.maxWidth;
    size[2] = initial?.minHeight;
    size[3] = initial?.maxHeight;
  }

  @override
  Widget displayField() {
    return Column(
      children: [
        DoubleProperty('Min Width', size[0], (p0) {  size[0] = p0; update();  }),
        DoubleProperty('Max Width', size[1], (p0) { size[1] = p0; update();  }),
        DoubleProperty('Min Height', size[2], (p0) {  size[2] = p0; update(); }),
        DoubleProperty('Max Height', size[3], (p0) { size[3] = p0;  update(); })
      ],
    );
  }

  void update(){
   if(size.allEqual(null)){
       onchange(null);
   }
   else{
     onchange(BoxConstraints(minWidth: size[0] ?? 0, maxWidth: size[1] ?? double.infinity, minHeight: size[2] ?? 0, maxHeight: size[3] ?? double.infinity ));
   }
  }

}

//

class FontProperty extends ExpandedProperty<TextStyle?>{
  final font = [const TextStyle()];
  FontProperty(super.label, super.initial, super.onchange, {super.key}){
    font[0] = initial ?? const TextStyle();
  }

  @override
  Widget displayField() {

     return Column(
       children:[
         ColorProperty('Color', initial?.backgroundColor, (c) { font[0] = font[0].copyWith(color: c); onchange(font[0]); }),
         ColorProperty('Background Color', initial?.backgroundColor, (c) { font[0] = font[0].copyWith(backgroundColor: c); onchange(font[0]); }),
         DoubleProperty('Font Size', initial?.fontSize, (c) { font[0] = font[0].copyWith(fontSize: c); onchange(font[0]); }),
         EnumProperty<FontWeight?>('Font Weight', initial?.fontWeight, FontWeight.values, (c) { font[0] = font[0].copyWith(fontWeight: c); onchange(font[0]); }),
         EnumProperty<FontStyle?>('Font Style', initial?.fontStyle, FontStyle.values,  (c) { font[0] = font[0].copyWith(fontStyle: c); onchange(font[0]); }),
         DoubleProperty('Letter Spacing', initial?.letterSpacing, (c) { font[0] = font[0].copyWith(letterSpacing: c); onchange(font[0]); }),
         DoubleProperty('Word Spacing', initial?.wordSpacing, (c) { font[0] = font[0].copyWith(wordSpacing: c); onchange(font[0]); }),
         EnumProperty<TextBaseline?>('Text BaseLine', initial?.textBaseline, TextBaseline.values , (c) { font[0] = font[0].copyWith(textBaseline: c); onchange(font[0]); }),
         DoubleProperty('Height', initial?.height, (c) { font[0] = font[0].copyWith(height: c); onchange(font[0]); }),
         EnumProperty<TextLeadingDistribution?>('Leading Distribution', initial?.leadingDistribution, TextLeadingDistribution.values, (c) { font[0] = font[0].copyWith(leadingDistribution: c); onchange(font[0]); }),
         StringProperty('Font Family', initial?.fontFamily, (c) { font[0] = font[0].copyWith(fontFamily: c); onchange(font[0]); }),
         EnumProperty<TextDecorationStyle?>('Decoration Style', initial?.decorationStyle, TextDecorationStyle.values, (c) { font[0] = font[0].copyWith(decorationStyle: c); onchange(font[0]); }),
         ColorProperty('Decoration Color', initial?.backgroundColor, (c) { font[0] = font[0].copyWith(decorationColor: c); onchange(font[0]); }),
         DoubleProperty('Decoration Thickness', initial?.decorationThickness, (c) { font[0] = font[0].copyWith(decorationThickness: c); onchange(font[0]); }),
         EnumProperty<TextDecoration?>('Text Decoration', initial?.decoration,const [TextDecoration.lineThrough, TextDecoration.overline, TextDecoration.underline, TextDecoration.none] ,
                 (c) { font[0] = font[0].copyWith(decoration: c); onchange(font[0]); }, widgets: const [Text('Line Through'), Text('Over Line'), Text('Under Line'), Text('None')],),

       ]
     );
  }

}

//

class CurveProperty extends EnumProperty<Curve?>{
  CurveProperty(String label, Curve? initial, void Function(Curve?) onchange, {super.key}):
        super(label, initial, [Curves.linear, Curves.easeIn, Curves.easeOut,], onchange,
      widgets: const [Text('Linear'), Text('Ease In'),Text('Ease Out')]);

}

//

class MouseCursorProperty extends EnumProperty<MouseCursor?>{
  MouseCursorProperty(String label, MouseCursor? initial, void Function(MouseCursor?) onchange, {super.key}):
        super(label, initial, [SystemMouseCursors.alias, SystemMouseCursors.allScroll,
        SystemMouseCursors.basic,SystemMouseCursors.cell, SystemMouseCursors.click,
        SystemMouseCursors.forbidden, SystemMouseCursors.grabbing,SystemMouseCursors.grab,
        SystemMouseCursors.help, SystemMouseCursors.move, SystemMouseCursors.none,
        SystemMouseCursors.noDrop,SystemMouseCursors.precise, SystemMouseCursors.progress,
        SystemMouseCursors.resizeColumn, SystemMouseCursors.resizeDown,SystemMouseCursors.resizeDownLeft,
        SystemMouseCursors.resizeDownRight, SystemMouseCursors.resizeLeft, SystemMouseCursors.resizeLeftRight,
        SystemMouseCursors.resizeRight,SystemMouseCursors.resizeRow, SystemMouseCursors.resizeUp,
        SystemMouseCursors.resizeUpDown, SystemMouseCursors.resizeUpLeft,SystemMouseCursors.resizeUpLeftDownRight,
        SystemMouseCursors.resizeUpRight, SystemMouseCursors.resizeUpRightDownLeft, SystemMouseCursors.text,
        SystemMouseCursors.verticalText,SystemMouseCursors.wait, SystemMouseCursors.zoomIn,
        SystemMouseCursors.zoomOut], onchange,
      widgets: const [Text('Alias'), Text('AllScroll'), Text('Basic'), Text('Cell'),
        Text('Click'), Text('Forbidden'), Text('Grabbing'),
        Text('Grab'), Text('Help'), Text('Move'), Text('None'),
        Text('NoDrop'), Text('Precise'), Text('Progress'), Text('ResizeColumn'),
        Text('ResizeDown'), Text('ResizeDownLeft'), Text('ResizeDownRight'), Text('ResizeLeft'),
        Text('ResizeLeftRight'), Text('ResizeRight'), Text('ResizeRow'), Text('ResizeUp'),
        Text('ResizeUpDown'), Text('ResizeUpLeft'), Text('ResizeUpLeftDownRight'), Text('ResizeUpRight'),
        Text('ResizeUpRightDownLeft'), Text('Text'), Text('VerticalText'),
        Text('Wait'), Text('ZoomIn'), Text('ZoomOut')]);

}

//

class StrutStyleProperty extends ExpandedProperty<StrutStyle?>{
  final List<dynamic> data = List.filled(10, null);
  StrutStyleProperty(super.label, super.initial, super.onchange, {super.key}){
    data[0] = initial?.fontFamily;
    data[1] = initial?.fontFamilyFallback;
    data[2] = initial?.fontSize;
    data[3] = initial?.height;
    data[4] = initial?.leadingDistribution;
    data[5] = initial?.leading;
    data[6] = initial?.fontWeight;
    data[7] = initial?.fontStyle;
    data[8] = initial?.forceStrutHeight;
    data[9] = initial?.debugLabel;
  }

  @override
  Widget displayField() {
    return Column(
      children: [
        StringProperty('Font Family', data[0] == null ? null : data[0] as String, (value){data[0] = value; update();}),
        StringProperty('Font Family Fallback', '', (value){}),
        DoubleProperty('Font Size', data[2] == null ? null : data[2] as double, (value){data[2] = value; update();}),
        DoubleProperty('Height', data[3] == null ? null : data[3] as double, (value){data[3] = value; update();}),
        EnumProperty('Leading Distribution', data[4] == null ? null : data[4] as TextLeadingDistribution, TextLeadingDistribution.values, (value){data[4] = value; update();}),
        DoubleProperty('Leading', data[5] == null ? null : data[5] as double, (value){data[5] = value; update();}),
        EnumProperty('Font Weight', data[6] == null ? null : data[6] as FontWeight, FontWeight.values, (value){data[6] = value; update();}),
        EnumProperty('Font Style', data[7] == null ? null : data[7] as FontStyle, FontStyle.values, (value){data[7] = value; update();}),
        BooleanProperty('Force Strut Height', data[8] == null ? null : data[8] as bool, (value){data[8] = value; update();}),
        StringProperty('Debug Label', data[9] == null ? null : data[9] as String, (value){data[9] = value; update();}),
      ],
    );
  }

  void update(){
    if(data.allEqual(null)){
      onchange(null);
    }
    else{
      onchange(StrutStyle(
        fontFamily : data[0] == null ? null : data[0] as String,
        fontFamilyFallback : data[1] == null ? null : data[1] as List<String>,
        fontSize : data[2] == null ? null : data[2] as double,
        height : data[3] == null ? null : data[3] as double,
        leadingDistribution : data[4] == null ? null : data[4] as TextLeadingDistribution,
        leading : data[5] == null ? null : data[5] as double,
        fontWeight : data[6] == null ? null : data[6] as FontWeight,
        fontStyle : data[7] == null ? null : data[7] as FontStyle,
        forceStrutHeight : data[8] == null ? null : data[8] as bool,
        debugLabel : data[9] == null ? null : data[9] as String,
      ));
    }
  }

}

//

class IconThemeDataProperty extends ExpandedProperty<IconThemeData?>{
  final List<dynamic> data = List.filled(4, null);
  IconThemeDataProperty(super.label, super.initial, super.onchange, {super.key}){
    data[0] = initial?.color;
    data[1] = initial?.opacity;
    data[2] = initial?.size;
    data[3] = initial?.shadows;
  }

  @override
  Widget displayField() {
    return Column(
      children: [
        ColorProperty('Color', data[0] == null ? null : data[0] as Color, (value){data[0] = value; update();}),
        DoubleProperty('Opacity', data[1] == null ? null : data[1] as double, (value){data[1] = value; update();}),
        DoubleProperty('Size', data[2] == null ? null : data[2] as double, (value){data[2] = value; update();}),
        StringProperty('Shadows', '', (value){}),
      ],
    );
  }

  void update(){
    if(data.allEqual(null)){
      onchange(null);
    }
    else{
      onchange(IconThemeData(
        color : data[0] == null ? null : data[0] as Color,
        opacity : data[1] == null ? null : data[1] as double,
        size : data[2] == null ? null : data[2] as double,
      ));
    }
  }

}
*/