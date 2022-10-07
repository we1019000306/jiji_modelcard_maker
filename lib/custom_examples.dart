import 'package:flutter/material.dart';

import 'widgets/custom_1.dart';
import 'widgets/inline_examples.dart';
class CustomExamples extends StatelessWidget {
  const CustomExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Custom Examples:',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Custom1()));
                print(Theme.of(context).colorScheme.brightness == Brightness.light);

          },
          child: Text('Custom 1'),
          style: ButtonStyle(
            //foregroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor : MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                  }
                  return Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white; // Use the component's default.
                }
            ),
          ),

        ),
      ],
    );
  }
}
