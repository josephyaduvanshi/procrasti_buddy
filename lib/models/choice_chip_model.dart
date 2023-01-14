class ChoiceChipModel {
  final String label;
  final bool selected;
  final Function(bool) onSelected;
  ChoiceChipModel(
      {required this.label, required this.selected, required this.onSelected});
}
