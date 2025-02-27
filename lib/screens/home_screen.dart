import 'package:flutter/material.dart';
import '../services/hive_service.dart';
import '../models/schedule_model.dart';
import '../services/pdf_service.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Start on "Add" page
  final TextEditingController _startShiftController = TextEditingController();
  final TextEditingController _endShiftController = TextEditingController();
  List<TextEditingController> _breakStartControllers = [];
  List<TextEditingController> _breakEndControllers = [];
  int _breakCount = 0;
  bool _submitted = false;
  String? _errorTextStart;
  String? _errorTextEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Manager"),
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Overview"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Progress"),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _overviewPage();
      case 1:
        return _addPage();
      case 2:
        return _progressPage();
      default:
        return _addPage();
    }
  }

  Widget _overviewPage() => Center(child: CircularProgressIndicator());
  Widget _progressPage() => Center(child: CircularProgressIndicator());

  Widget _addPage() {
    return Column(
      children: [
        Text(DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now())),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: _submitted
                  ? Text("All set up for today!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _startShiftController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: "Start Shift (HH:mm)", errorText: _errorTextStart),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _endShiftController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: "End Shift (HH:mm)", errorText: _errorTextEnd),
                          ),
                          SizedBox(height: 20),
                          Text("Breaks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(icon: Icon(Icons.remove), onPressed: _removeBreak),
                              Text("$_breakCount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              IconButton(icon: Icon(Icons.add), onPressed: _addBreak),
                            ],
                          ),
                          ..._buildBreakFields(),
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: _validateAndSubmit, child: Text("Submit")),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _addBreak() {
    setState(() {
      _breakStartControllers.add(TextEditingController());
      _breakEndControllers.add(TextEditingController());
      _breakCount++;
    });
  }

  void _removeBreak() {
    if (_breakCount > 0) {
      setState(() {
        _breakStartControllers.removeLast();
        _breakEndControllers.removeLast();
        _breakCount--;
      });
    }
  }

  List<Widget> _buildBreakFields() {
    List<Widget> fields = [];
    for (int i = 0; i < _breakCount; i++) {
      fields.add(
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _breakStartControllers[i],
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: "Break ${i + 1} Start (HH:mm)"),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _breakEndControllers[i],
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: "Break ${i + 1} End (HH:mm)"),
              ),
            ),
          ],
        ),
      );
    }
    return fields;
  }

  void _validateAndSubmit() {
    String start = _startShiftController.text.trim();
    String end = _endShiftController.text.trim();
    RegExp timeRegex = RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$');

    setState(() {
      _errorTextStart = timeRegex.hasMatch(start) ? null : "Enter a valid time (HH:mm)";
      _errorTextEnd = timeRegex.hasMatch(end) ? null : "Enter a valid time (HH:mm)";
    });

    if (_errorTextStart == null && _errorTextEnd == null) {
      Duration shiftDuration = _calculateDuration(start, end);
      Duration breakDuration = _calculateTotalBreaks();
      Duration netWorkDuration = shiftDuration - breakDuration;
      print("Start Shift: $start, End Shift: $end");
      print("Break Time: ${breakDuration.inHours}h ${breakDuration.inMinutes.remainder(60)}m");
      print("Net Work Duration: ${netWorkDuration.inHours}h ${netWorkDuration.inMinutes.remainder(60)}m");
      setState(() => _submitted = true);
    }
  }

  Duration _calculateDuration(String start, String end) {
    DateFormat format = DateFormat("HH:mm");
    DateTime startTime = format.parse(start);
    DateTime endTime = format.parse(end);
    if (endTime.isBefore(startTime)) endTime = endTime.add(Duration(days: 1));
    return endTime.difference(startTime);
  }

  Duration _calculateTotalBreaks() {
    Duration totalBreakTime = Duration.zero;
    DateFormat format = DateFormat("HH:mm");
    for (int i = 0; i < _breakCount; i++) {
      if (_breakStartControllers[i].text.isNotEmpty && _breakEndControllers[i].text.isNotEmpty) {
        DateTime start = format.parse(_breakStartControllers[i].text);
        DateTime end = format.parse(_breakEndControllers[i].text);
        if (end.isBefore(start)) end = end.add(Duration(days: 1));
        totalBreakTime += end.difference(start);
      }
    }
    return totalBreakTime;
  }
}



