extension StringExtension on String {
  String firstToUpperCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
