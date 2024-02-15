
import 'package:flutter/material.dart';
import 'base.dart';
import 'field.dart';

class BottomSheetControl extends Control{
  BottomSheetControl({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetControl();
}

class _BottomSheetControl extends ControlState<BottomSheetControl>{

  late var fields = <Field>[
    BoolField(this, 'enableDrag' , defaultValue : true, isDefault : true, isNullable : false),
    ColorField(this, 'backgroundColor' ),
    DoubleField(this, 'elevation' ),
    ShapeBorderField(this, 'shape' ),
    EnumField(this, 'clipBehavior', choices : Clip.values ),
    BoxConstraintsField(this, 'constraints' ),
    ClosureField<VoidCallback>(this, 'onClosing' , isNullable : false, defaultValue : (){},defaultString: '(){}', isRequired : () => true),
    WidgetBuilderField(this, 'builder' , isRequired : () => true),
  ];

  @override
  Type get type => BottomSheet;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  build(BuildContext context) {
    return BottomSheet(
      enableDrag : fields[0].value,
      backgroundColor : fields[1].value,
      elevation : fields[2].value,
      shape : fields[3].value,
      clipBehavior : fields[4].value,
      constraints : fields[5].value,
      onClosing : fields[6].value,
      builder : fields[7].value,
    );
  }
}

class BottomNavigationBarControl extends Control{
  BottomNavigationBarControl({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarControl();
}

class _BottomNavigationBarControl extends DraggableControlState<BottomNavigationBarControl>{

  late var fields = <Field>[
    ListBottomNavigationBarItemField(this, 'items' , isNullable : false,
        defaultValue : const [BottomNavigationBarItem(icon: Text('Item'), label: 'I1'),
            BottomNavigationBarItem(icon: Text('Item'), label: 'I1')], isRequired : () => true, minLength: 2),
    IntField(this, 'currentIndex' , defaultValue : 0, isDefault : true, isNullable : false, constrain : (i) => i == null || i < fields[0].value.length),
    DoubleField(this, 'elevation' ),
    EnumField(this, 'type', choices : BottomNavigationBarType.values ),
    ColorField(this, 'fixedColor' ),
    ColorField(this, 'backgroundColor' ),
    DoubleField(this, 'iconSize' , defaultValue : 24.0, isDefault : true, isNullable : false),
    ColorField(this, 'selectedItemColor' ),
    ColorField(this, 'unselectedItemColor' ),
    IconThemeDataField(this, 'selectedIconTheme' ),
    IconThemeDataField(this, 'unselectedIconTheme' ),
    DoubleField(this, 'selectedFontSize' , defaultValue : 14.0, isDefault : true, isNullable : false),
    DoubleField(this, 'unselectedFontSize' , defaultValue : 12.0, isDefault : true, isNullable : false),
    TextStyleField(this, 'selectedLabelStyle' ),
    TextStyleField(this, 'unselectedLabelStyle' ),
    BoolField(this, 'showSelectedLabels' ),
    BoolField(this, 'showUnselectedLabels' ),
    MouseCursorField(this, 'mouseCursor' ),
    BoolField(this, 'enableFeedback' ),
  ];

  @override
  Type get type => BottomNavigationBar;

  @override
  List<Field> get widgetFields => fields;

  @override
  set widgetFields(List<Field> fields) => setState((){this.fields = fields;});

  @override
  buildWidget(BuildContext context) {
    return BottomNavigationBar(
      items : fields[0].value,
      currentIndex : fields[1].value,
      elevation : fields[2].value,
      type : fields[3].value,
      fixedColor : fields[4].value,
      backgroundColor : fields[5].value,
      iconSize : fields[6].value,
      selectedItemColor : fields[7].value,
      unselectedItemColor : fields[8].value,
      selectedIconTheme : fields[9].value,
      unselectedIconTheme : fields[10].value,
      selectedFontSize : fields[11].value,
      unselectedFontSize : fields[12].value,
      selectedLabelStyle : fields[13].value,
      unselectedLabelStyle : fields[14].value,
      showSelectedLabels : fields[15].value,
      showUnselectedLabels : fields[16].value,
      mouseCursor : fields[17].value,
      enableFeedback : fields[18].value,
    );
  }
}