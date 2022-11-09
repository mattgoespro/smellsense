import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smellsense/model/scent.dart';
import 'package:smellsense/shared/widgets/app_bar.widget.dart';
import 'package:smellsense/shared/widgets/button.widget.dart';
import 'package:smellsense/storage/storage.dart';

class ScentSelectionScreen extends StatefulWidget {
  final List<Scent>? _scentSelections;
  final Function _onScentsSelected;

  const ScentSelectionScreen(
      Key key, this._scentSelections, this._onScentsSelected)
      : super(key: key);

  @override
  ScentSelectionScreenState createState() => ScentSelectionScreenState();
}

class ScentSelectionScreenState extends State<ScentSelectionScreen> {
  List<String?> _selectedScents = [];

  @override
  initState() {
    super.initState();

    if (widget._scentSelections != null) {
      _selectedScents = widget._scentSelections!.map((e) => e.name).toList();
    } else {
      _selectedScents = ['Lemon', 'Rose', 'Eucalyptus', 'Clove'];
    }
  }

  Future<void> _onWriteScentSelections() async {
    SmellSenseStorage storage = GetIt.instance<SmellSenseStorage>();
    return storage.updateScentSelections(_selectedScents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmellSenseAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Center(
              child: Text(
                'Select 4 smell training \nscents',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
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
                        if (value! && _selectedScents.length < 4) {
                          _selectedScents.add(scent.name);
                        } else {
                          _selectedScents.remove(scent.name);
                        }
                      });
                    },
                    value: _selectedScents.contains(scent.name),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
              ],
            ),
          ),
          const Divider(
            color: Colors.blueGrey,
            indent: 30,
            endIndent: 30,
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: SizedBox(
                child: Button.primary(
                  text: '(${_selectedScents.length}/4) Done',
                  onPressed: _selectedScents.length == 4
                      ? () {
                          _onWriteScentSelections();
                          widget._onScentsSelected(_selectedScents
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
