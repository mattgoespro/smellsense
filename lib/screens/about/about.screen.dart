import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';
import 'package:smellsense/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  Widget createTextInput(
    String text,
    bool required,
    Function onChanged,
    int maxLines,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 3,
            left: 15,
            right: 15,
          ),
          child: RichText(
            text: TextSpan(
              text: text,
              style: const TextStyle(color: Colors.black),
              children: [
                if (required)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: maxLines,
            onChanged: onChanged as void Function(String)?,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmellSenseAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize:
                              Theme.of(context).textTheme.headlineSmall!.fontSize,
                        ),
                      ),
                    ),
                    const Text(
                      'SmellSense is a private initiative\nstarted by E.N.T specialist\nDr. Martin Young.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(
                        'Contacts',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize:
                              Theme.of(context).textTheme.headlineSmall!.fontSize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Facebook: ',
                          children: [
                            TextSpan(
                              text: 'SmellSense',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchUrl(
                                    Uri(path: 'https://www.facebook.com/SmellSense-345235540113222/')),
                            ),
                          ],
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Email: knysnaent@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'App and development enquiries: smellsenseza@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(
                        'Resources',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize:
                              Theme.of(context).textTheme.headlineSmall!.fontSize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Fifth Sense',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => launchUrl(Uri(path: 'https://www.fifthsense.org.uk/')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Abscent',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(Uri(path: 'https://abscent.org/')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
