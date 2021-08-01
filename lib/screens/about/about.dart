import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smellsense/shared/widgets/app-bar.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/theme/colors.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String username = "smellsenseza@gmail.com"; //Your Email;
  String password = "SmellSense123"; //Your Email's password;

  var smtpServer;
  Message message;
  String bugTitle;
  String bugSteps;
  bool reportingBug = false;

  _AboutScreenState() {
    this.smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    this.message = Message()
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
    return Container(
      child: Column(
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
                style: TextStyle(color: Colors.black),
                children: [
                  if (required)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: AppColors.ERROR),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
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
      ),
    );
  }

  void _showReportBugDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          titlePadding: EdgeInsets.all(10),
          title: Column(
            children: [
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
            this.createTextInput('Title', true, (text) {
              setState(() {
                this.bugTitle = text;
              });
            }, 1),
            this.createTextInput(
              'Briefly describe the steps to reproduce the issue',
              true,
              (text) {
                setState(() {
                  this.bugSteps = text;
                });
              },
              5,
            ),
            Divider(),
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
                          this.bugTitle = null;
                          this.bugSteps = null;
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
                        if (this.bugTitle == null ||
                            this.bugTitle.trim() == "" ||
                            this.bugSteps == null ||
                            this.bugSteps.trim() == "") {
                          Fluttertoast.showToast(
                              msg: 'Please fill in the required fields.');
                        } else {
                          setState(() {
                            this.bugTitle = null;
                            this.bugSteps = null;
                          });

                          Navigator.of(context).pop();

                          this.message.text = this.bugSteps;
                          try {
                            await send(this.message, this.smtpServer);
                            Fluttertoast.showToast(
                              msg: "Bug reported successfully.",
                            );
                          } on MailerException catch (e) {
                            print(e);
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
                child: Container(
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
                      Text(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launch(
                                      'https://www.facebook.com/SmellSense-345235540113222/'),
                              ),
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Email: knysnaent@gmail.com',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
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
                            style: TextStyle(
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
                            style: TextStyle(
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
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Report a bug'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return AppColors.ERROR;
                        },
                      ),
                    ),
                    onPressed: () => this._showReportBugDialog(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
