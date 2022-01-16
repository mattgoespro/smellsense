import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/theme/colors.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String username = "smellsenseza@gmail.com"; //Your Email;
  String password = "SmellSense123"; //Your Email's password;

  SmtpServer smtpServer;
  Message message;
  String bugTitle;
  String bugSteps;
  bool reportingBug = false;

  _AboutScreenState() {
    smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    message = Message()
      ..from = Address(username)
      ..recipients.add("smellsenseza@gmail.com") //recipent email
      ..subject = "Bug Report"; //subject of the email
  }

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
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _showReportBugDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          titlePadding: const EdgeInsets.all(10),
          title: Column(
            children: const [
              Center(
                child: Text(
                  'Report a bug',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
          children: [
            createTextInput('Title', true, (text) {
              setState(() {
                bugTitle = text;
              });
            }, 1),
            createTextInput(
              'Briefly describe the steps to reproduce the issue',
              true,
              (text) {
                setState(() {
                  bugSteps = text;
                });
              },
              5,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Button.secondary(
                      text: 'Cancel',
                      onPressed: () {
                        setState(() {
                          bugTitle = null;
                          bugSteps = null;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Button.primary(
                      text: 'Submit',
                      onPressed: () async {
                        if (bugTitle == null ||
                            bugTitle.trim() == "" ||
                            bugSteps == null ||
                            bugSteps.trim() == "") {
                          Fluttertoast.showToast(
                              msg: 'Please fill in the required fields.');
                        } else {
                          setState(() {
                            bugTitle = null;
                            bugSteps = null;
                          });

                          Navigator.of(context).pop();

                          message.text = bugSteps;
                          try {
                            await send(message, smtpServer);
                            Fluttertoast.showToast(
                              msg: "Bug reported successfully.",
                            );
                          } on MailerException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                            Fluttertoast.showToast(
                              msg: "Failed to report bug. Reason: ${e.message}",
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                              Theme.of(context).textTheme.headline5.fontSize,
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
                              Theme.of(context).textTheme.headline5.fontSize,
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
                                ..onTap = () => launch(
                                    'https://www.facebook.com/SmellSense-345235540113222/'),
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
                              Theme.of(context).textTheme.headline5.fontSize,
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
                            ..onTap = () =>
                                launch('https://www.fifthsense.org.uk/'),
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
                            ..onTap = () => launch('https://abscent.org/'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Report a bug'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return AppColors.error;
                      },
                    ),
                  ),
                  onPressed: () => _showReportBugDialog(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
