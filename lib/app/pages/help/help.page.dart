import 'package:flutter/material.dart';
import 'package:smellsense/app/shared/theme/theme.dart';

class HelpScreenPage extends StatelessWidget {
  const HelpScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            spacing: 16,
            children: [
              HelpParagraphWidget('What is smell training?',
                  body:
                      'Smell training engages an innate function of the brain known as Neuroplasticity, \'the brain\'s ability to form and reorganize synaptic connections, especially in response to learning, experiencing, or following injury.\' - Google Dictionary.'),
              HelpParagraphWidget(
                  'I\'m ready to begin my training. What do I do?',
                  body:
                      'In a smell training session, a set of four familiar scents (typically Rose, Clove, Lemon, and Eucalyptus) are smelled, in turn, for a period of 20-30 seconds, whilst mindfully visualizing and remembering how each substance would have smelled prior to the smell loss. Repeating the training multiple times daily often produces better results.'),
              HelpParagraphWidget(
                  'Over how long a period do I need to smell train in order for my sense of smell to fully recover/return to normal?',
                  body:
                      'Recovery periods naturally differ from person to person, but research suggests that the average treatment would last for ~3 months. Much depends on the underlying cause of your loss of smell and the severity thereof. Most people will become aware of positive changes within 3 months of starting smell training. Occasionally, it is possible that you may regain the smell of a desired scent, but it does not feel \'correct\'. Do not be concerned - this is a positive sign that recovery is underway and that you should continue your training regimen as per usual.'),
              HelpParagraphWidget(
                  'I don\'t have the official SmellSense kit. Am I still able to use the SmellSense mobile application to train?',
                  body:
                      'Yes! The official SmellSense kit is built simply for your convenience, and the scents supplied are those that are known to be most effective for smell training according to the most  up-to-date research. You can simply make up your own set of scents on which to smell train. Be sure to use a set of recognizable smells that remain consistently strong over the period of training. Typically, studies use a representative substance from each of the \'notes\' of smell: Floral - eg. Rose, Fruity - eg. Lemon, Spicy - eg. Clove, Aromatic - eg. Eucalyptus. We wish you all the best with your recovery! For more information and resources, refer to the About screen from the main menu.'),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpParagraphWidget extends StatelessWidget {
  final String title;
  final String body;

  const HelpParagraphWidget(
    this.title, {
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineMedium,
        ),
        Text(
          body,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
