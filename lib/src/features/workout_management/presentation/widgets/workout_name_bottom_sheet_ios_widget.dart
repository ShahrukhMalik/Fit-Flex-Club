import 'package:flutter/cupertino.dart';

class CupertinoWorkoutBottomSheet extends StatelessWidget {
  final TextEditingController controller;

   const CupertinoWorkoutBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: CupertinoColors.systemGrey6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "New Workout Program",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Name the workout program : ",
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: controller,
                placeholder: "Workout Program Name",
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: () {
                  // print("Workout Name: ${controller.text}");
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
