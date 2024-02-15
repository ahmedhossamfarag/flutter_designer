extension<T> on List<T>{
  bool all(bool Function(T) f){
    return !any((element) => !f(element));
  }
}

extension on String{
  int? lastIndexOfOrNull(Pattern pattern){
    var i = lastIndexOf(pattern);
    return i == -1? null : i;
  }

  String shorten(){
    return substring((lastIndexOfOrNull('.') ?? -1) + 1);
  }
}

String shortStr(String s) => s.shorten();




