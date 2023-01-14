import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChoiceWidgetCategories extends StatelessWidget {
  final dynamic notfier;
  // final List<ChoiceChipModel> choiceChipModelList;
  const ChoiceWidgetCategories({
    Key? key,
    required this.notfier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: notfier.choiceChipList().length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return ChoiceChip(
          label: "${notfier.choiceChipList()[index].label}".text.make().shimmer(
                primaryColor: Colors.purple,
                secondaryColor: Colors.blue,
                duration: 5.seconds,
              ),
          selected: notfier.choiceChipList()[index].selected,
          onSelected: notfier.choiceChipList()[index].onSelected,
        );
      },
    );
  }
}
