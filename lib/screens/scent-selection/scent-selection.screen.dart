import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/shared/widgets/app-bar.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/storage/storage.dart';

class ScentSelectionScreen extends StatefulWidget {
  final List<Scent> _scentSelections;
  final Function _onScentsSelected;

  ScentSelectionScreen(this._scentSelections, this._onScentsSelected);

  @override
  _ScentSelectionScreenState createState() => _ScentSelectionScreenState();
}

class _ScentSelectionScreenState extends State<ScentSelectionScreen> {
  List<String> _selectedScents = [];

  @override
  initState() {
    super.initState();

    if (widget._scentSelections != null) {
      this._selectedScents =
          widget._scentSelections.map((e) => e.name).toList();
    } else {
      this._selectedScents = ['Lemon', 'Rose', 'Eucalyptus', 'Clove'];
    }
  }

  Future<void> _onWriteScentSelections() async {
    SmellSenseStorage storage = GetIt.instance<SmellSenseStorage>();
    return storage.updateScentSelections(this._selectedScents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Center(
              child: Text(
                'Select 4 smell training \nscents',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                  fontSize: Theme.of(context).textTheme.headline5.fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (Scent scent in Scent.scents)
                  CheckboxListTile(
                    title: Text(
                      scent.name,
                      style: TextStyle(
                        color: scent.color,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value && this._selectedScents.length < 4) {
                          this._selectedScents.add(scent.name);
                        } else {
                          this._selectedScents.remove(scent.name);
                        }
                      });
                    },
                    value: this._selectedScents.contains(scent.name),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
              ],
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            indent: 30,
            endIndent: 30,
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: SizedBox(
                child: Button.primary(
                  text: '(${this._selectedScents.length}/4) Done',
                  onPressed: this._selectedScents.length == 4
                      ? () async {
                          await this._onWriteScentSelections();
                          this.widget._onScentsSelected(this
                              ._selectedScents
                              .map((scent) => Scent.scents
                                  .firstWhere((s) => s.name == scent))
                              .toList());
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
