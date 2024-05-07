class CapitalizeString {  
  String capitalizeString(String value) {  
    if (value.isEmpty) {
      return value;
    }
    return value.substring(0, 1).toUpperCase() + value.substring(1);
  }
}
