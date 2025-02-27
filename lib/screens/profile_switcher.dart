import 'package:flutter/material.dart';
/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedProfile = 0; // 0 for Profile 1, 1 for Profile 2
  final List<String> profileNames = ['Profile 1', 'Profile 2'];
  List<ScheduleModel> schedules = [];

  void _switchProfile(int index) {
    if (selectedProfile != index) {
      setState(() {
        selectedProfile = index;
        schedules = profileSchedules[selectedProfile] ?? [];
      });
    }
    Navigator.pop(context);
  }

  /*@override
  void initState() {
    super.initState();
    schedules = HiveService.getSchedules(); // Directly fetch schedules
  }*/
  Map<int, List<ScheduleModel>> profileSchedules = {
    0: [
      ScheduleModel(
        date: "2025-02-24",
        totalHours: '7',
        workHours: '5',
        breakHours: '3',
      ),
      ScheduleModel(
        date: "2025-02-25",
        totalHours: '8',
        workHours: '5',
        breakHours: '3',
      ),
    ],
    1: [
      ScheduleModel(
        date: "2025-02-26",
        totalHours: '6.5',
        workHours: '5',
        breakHours: '3',
      ),
      ScheduleModel(
        date: "2025-02-27",
        totalHours: ' 9',
        workHours: '5',
        breakHours: '3',
      ),
    ],
  };

  // Then update your list dynamically based on the selected profile:
  @override
  void initState() {
    super.initState();
    schedules = profileSchedules[selectedProfile] ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Time Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Select Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...List.generate(2, (index) => _buildProfileTile(index)),
          ],
        ),
      ),
      body:
          schedules.isEmpty
              ? Center(child: Text("No schedules available."))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return ListTile(
                          title: Text(schedule.date),
                          subtitle: Text("Total Hours: ${schedule.totalHours}"),
                        );
                      },
                    ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf),
        onPressed: () async {
          final file = await PdfService.generatePdf("Work Schedule", [
            {'date': '2025-02-24', 'work': '8h', 'break': '1h', 'total': '7h'},
            {'date': '2025-02-25', 'work': '9h', 'break': '1h', 'total': '8h'},
          ]);
          await PdfService.openPdf(file);
        },
      ),
    );
  }

  Widget _buildProfileTile(int index) {
    bool isSelected = selectedProfile == index;
    return ListTile(
      title: Text(
        profileNames[index],
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Icon(Icons.edit),
      tileColor: isSelected ? Colors.grey.shade300 : null,
      onTap: () => _switchProfile(index),
    );
  }
}
*/

