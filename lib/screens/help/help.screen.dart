import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:smellsense/shared/widgets/app-bar.dart';

class HelpScreen extends StatelessWidget {
  final String _helpInfo = """
  <h1>What is smell training?</h1>
  <p>
    Smell training uses the ability of the brain known as <i>neuroplasticity</i> - the capacity to reassign brain cells to relearn
    lost functions, in this case the loss of sense of smell. One can look at smell training as being similar to occupational therapy
    or physiotherapy for the brain to help recover a lost, weak or altered sense of smell.
  </p>
  <h1>How is it done?</h1>
  <p>
    A set of four familiar smells - typically rose, clove, lemon and eucalyptus - is smelt in turn for a period of twenty to thirty 
    seconds twice a day, while visualising and remembering how each substance smelt, for a period of several months.
  </p>
  <h1>How long do I need to train?</h1>
  <p>
    Like the recovery process from any neurological injury, smell training takes time, and persistent effort sees results. Research
    suggests that the minimum period should be a session of twenty to thirty seconds of smell training dedicated to each smell twice a
    day for a minimum of three months. When added up, the total time and effort spent may be as little as 6 hours.
  </p>
  <h1>I don't have the official <i>SmellSense</i> kit, so how can I train?</h1>
  <p>
    Yes. You can make up your own set of scents on which to smell train. Any consistently strong set of recognisable smells will suffice.
    The selection we have chosen is that on which most research to date has been based, using a representative from each of the ‘notes’
    of smell: floral = rose, fruity = lemon, spicy = clove, aromatic = eucalyptus. But any set of smells will do if they remain consistently
    strong over the period of training.

    The SmellSense kit in particular has been designed to minimize the amount of time spent looking for and reaching for separate smell
    containers - it is a purely practical application to make it easier for people to train consistently.
  </p>
  <h1>How long will it take for my sense of smell to recover?</h1>
  <p>
    There is no uniform answer to this question unfortunately. Much depends on the underlying cause of your loss of smell, the severity thereof,
    and the amount of effort put into smell training, using the associative modalities provided in this app.

    Most people will become aware of positive changes within three months of starting smell training. Initially the sense of smell might recover
    as being the ‘incorrect’ smell for a substance, but this is a positive sign that recovery is under way, and that one should ‘push through’
    with the training.
  </p>
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Html(
              data: this._helpInfo,
              style: {
                "h1": Style(
                  fontWeight: FontWeight.w100,
                ),
                "p": Style(
                  margin: EdgeInsets.only(left: 10),
                  fontWeight: FontWeight.w100,
                  color: Colors.black,
                )
              },
            ),
          ),
        ),
      ),
    );
  }
}
