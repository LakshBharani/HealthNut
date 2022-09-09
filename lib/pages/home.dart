// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthnut/pages/edit_user_info.dart';
import 'package:healthnut/pages/login.dart';
import 'package:healthnut/services/auth_service.dart';
import 'package:healthnut/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool isOnHome = true;
  bool isOnReports = false;
  bool isOnProfile = false;
  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 36,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 34,
                            child: Icon(Icons.camera_alt_rounded),
                          ),
                        ),
                        Positioned(
                            bottom: 30,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.email_rounded,
                                  color: Colors.white,
                                ),
                                WidthBox(10),
                                Text(
                                  'laksh.bharani@gmail.com',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                        Positioned(
                            bottom: 5,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.phone_rounded,
                                  color: Colors.white,
                                ),
                                WidthBox(10),
                                Text(
                                  '9972644523',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                        Positioned(
                          right: 0,
                          child: IconButton(
                              splashColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnReports = false;
                                  isOnProfile = true;
                                });
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: isOnHome
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _scaffoldKey.currentState?.openDrawer(),
                                  icon: const Icon(Icons.menu_rounded)),
                              Container(
                                height: 50,
                                width: currentOrientation ==
                                        Orientation.portrait
                                    ? MediaQuery.of(context).size.width * 0.6
                                    : MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Search Medicine',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(50),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 46,
                                      width: 46,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child:
                                          const Icon(Icons.notifications_none),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: -3,
                                      child: Container(
                                        height: 19,
                                        width: 19,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 1.5,
                                              color: Colors.white,
                                            )),
                                        child: const Center(
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                                fontSize: 10,
                                                height: 1.4,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   height: 46,
                              //   width: 46,
                              //   decoration: const BoxDecoration(
                              //     color: Colors.red,
                              //     shape: BoxShape.circle,
                              //   ),
                              //   child: IconButton(
                              //     color: Colors.white,
                              //     onPressed: () {
                              //       AlertDialog alert = AlertDialog(
                              //         title: const Text(
                              //           "Sign Out",
                              //           style: TextStyle(
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //         content: const Text(
                              //             "Would you like to stay signed in?\nYou will have to login once again if you confirm."),
                              //         actions: [
                              //           ElevatedButton(
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //               child: const Text('Cancel')),
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(right: 5),
                              //             child: ElevatedButton(
                              //                 onPressed: () {
                              //                   Navigator.of(context).pop();
                              //                   setState(() {
                              //                     loading = true;
                              //                   });
                              //                   context
                              //                       .read<
                              //                           AuthenticationProvider>()
                              //                       .signOut()
                              //                       .then((value) {
                              //                     Navigator.push(
                              //                       context,
                              //                       MaterialPageRoute(
                              //                           builder: (context) =>
                              //                               const LoginPage()),
                              //                     ).then((value) {
                              //                       setState(() {
                              //                         loading = false;
                              //                       });
                              //                     });
                              //                   });
                              //                 },
                              //                 child: const Text('Confirm')),
                              //           )
                              //         ],
                              //       );
                              //       showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return alert;
                              //         },
                              //       );
                              //     },
                              //     splashRadius: 1,
                              //     splashColor: Colors.red,
                              //     icon: const Icon(Icons.logout),
                              //   ),
                              // ),
                            ],
                          )
                        : null,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: isOnHome
                            ? MediaQuery.of(context).size.height - 154
                            : MediaQuery.of(context).size.height - 104,
                        width: MediaQuery.of(context).size.width,
                        child: isOnHome
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Shortcuts',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const HeightBox(6),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 12, 20, 5),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors.orange[
                                                                          500]),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                            Icons.chat_rounded,
                                                            size: 30,
                                                          )),
                                                    ),
                                                    const HeightBox(5),
                                                    const Text(
                                                      'Ask a\nDoctor',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors.orange[
                                                                          500]),
                                                          onPressed: () {},
                                                          child: const Icon(
                                                            Icons
                                                                .calendar_month_rounded,
                                                            size: 30,
                                                          )),
                                                    ),
                                                    const HeightBox(5),
                                                    const Text(
                                                      'Book\nAppointment',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors.orange[
                                                                          500]),
                                                          onPressed: () {
                                                            setState(() {
                                                              isOnHome = false;
                                                              isOnReports =
                                                                  true;
                                                              isOnProfile =
                                                                  false;
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.book_rounded,
                                                            size: 30,
                                                          )),
                                                    ),
                                                    const HeightBox(5),
                                                    const Text(
                                                      'My\nReports',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 70,
                                                    width: 70,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.orange[
                                                                        500]),
                                                        onPressed: () {},
                                                        child: const Icon(
                                                          Icons.article_rounded,
                                                          size: 30,
                                                        )),
                                                  ),
                                                  const HeightBox(5),
                                                  const Text(
                                                    'My\nPrescriptions',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const HeightBox(20),
                                      const Text(
                                        'Scheduled',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const HeightBox(6),
                                      Container(
                                        height: 190,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  height: 70,
                                                  width: 70,
                                                  color: Colors.deepPurple,
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 80,
                                                top: 0,
                                                child: Text(
                                                  'Name',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Positioned(
                                                left: 80,
                                                top: 27.5,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              157,
                                                      maxHeight: 63),
                                                  child: const Text(
                                                    "Om Prakash Mishra Singh Bharani (Ph.D.)",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 0,
                                                top: 75,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 105,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              50,
                                                      maxHeight: 63),
                                                  child: const Text(
                                                    "Carry all prescriptions and file for height and weight",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                top: 75,
                                                child: const Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Positioned(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                top: 105,
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              280,
                                                      maxHeight: 63),
                                                  child: const Text(
                                                    "21st September\n10:30 am",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const HeightBox(20),
                                      const Text(
                                        'Analysis',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const HeightBox(6),
                                      const Text(
                                        'Blood Sugar Level',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const HeightBox(6),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 25, 3),
                                          child: LineChart(
                                            LineChartData(
                                              backgroundColor: Colors.white,
                                              minX: 1,
                                              maxX: 7,
                                              minY: 0,
                                              maxY: 400,
                                              titlesData: FlTitlesData(
                                                show: true,
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 30,
                                                    getTitlesWidget:
                                                        (value, meta) {
                                                      switch (value.toInt()) {
                                                        case 1:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Mon'),
                                                          );
                                                        case 2:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Tue'),
                                                          );
                                                        case 3:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Wed'),
                                                          );
                                                        case 4:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Thur'),
                                                          );
                                                        case 5:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Fri'),
                                                          );
                                                        case 6:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Sat'),
                                                          );
                                                        case 7:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Sun'),
                                                          );
                                                      }
                                                      return const Text('');
                                                    },
                                                  ),
                                                ),
                                              ),
                                              gridData: FlGridData(
                                                  drawVerticalLine: false),
                                              lineTouchData: LineTouchData(
                                                touchTooltipData:
                                                    LineTouchTooltipData(
                                                  tooltipRoundedRadius: 400,
                                                  tooltipBorder:
                                                      const BorderSide(
                                                          color: Colors.black),
                                                  tooltipBgColor: Colors.white,
                                                ),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  dotData:
                                                      FlDotData(show: true),
                                                  spots: [
                                                    const FlSpot(1, 163),
                                                    const FlSpot(2, 140),
                                                    const FlSpot(3, 200),
                                                    const FlSpot(4, 185),
                                                    const FlSpot(5, 150),
                                                    const FlSpot(6, 200),
                                                    const FlSpot(7, 197.5),
                                                  ],
                                                  isCurved: false,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 111, 8, 1),
                                                      Color.fromARGB(
                                                          255, 255, 0, 0)
                                                    ],
                                                  ),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            126, 111, 8, 1),
                                                        Color.fromARGB(
                                                            62, 255, 0, 0)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const HeightBox(10),
                                      const Text(
                                        'Oxygen (SpO2) Level',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const HeightBox(6),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 25, 3),
                                          child: LineChart(
                                            LineChartData(
                                              backgroundColor: Colors.white,
                                              minX: 1,
                                              maxX: 7,
                                              minY: 0,
                                              maxY: 400,
                                              titlesData: FlTitlesData(
                                                show: true,
                                                rightTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                topTitles: AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 30,
                                                    getTitlesWidget:
                                                        (value, meta) {
                                                      switch (value.toInt()) {
                                                        case 1:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Mon'),
                                                          );
                                                        case 2:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Tue'),
                                                          );
                                                        case 3:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Wed'),
                                                          );
                                                        case 4:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Thur'),
                                                          );
                                                        case 5:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Fri'),
                                                          );
                                                        case 6:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Sat'),
                                                          );
                                                        case 7:
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 8,
                                                            ),
                                                            child: Text('Sun'),
                                                          );
                                                      }
                                                      return const Text('');
                                                    },
                                                  ),
                                                ),
                                              ),
                                              gridData: FlGridData(
                                                  drawVerticalLine: false),
                                              lineTouchData: LineTouchData(
                                                touchTooltipData:
                                                    LineTouchTooltipData(
                                                  tooltipRoundedRadius: 400,
                                                  tooltipBorder:
                                                      const BorderSide(
                                                          color: Colors.black),
                                                  tooltipBgColor: Colors.white,
                                                ),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  dotData:
                                                      FlDotData(show: true),
                                                  spots: [
                                                    const FlSpot(1, 163),
                                                    const FlSpot(2, 140),
                                                    const FlSpot(3, 200),
                                                    const FlSpot(4, 185),
                                                    const FlSpot(5, 150),
                                                    const FlSpot(6, 200),
                                                    const FlSpot(7, 197.5),
                                                  ],
                                                  isCurved: false,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 0, 21, 116),
                                                      Color.fromARGB(
                                                          255, 0, 119, 224),
                                                    ],
                                                  ),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            125, 0, 21, 116),
                                                        Color.fromARGB(
                                                            61, 0, 119, 224),
                                                      ],
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
                                ),
                              )
                            : isOnReports
                                ? SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: const [
                                          Text('Records'),
                                        ],
                                      ),
                                    ),
                                  )
                                : isOnProfile
                                    ? SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 30),
                                                  child: Text(
                                                    'My Profile',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black,
                                                      radius: 60,
                                                      child: CircleAvatar(
                                                        radius: 58,
                                                        child: Icon(Icons
                                                            .camera_alt_rounded),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      top: -3,
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  width: 1.5,
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                        child: Center(
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const HeightBox(40),
                                              const Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text('Laksh Bharani'),
                                              const HeightBox(15),
                                              const Text(
                                                'Email ID',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text(
                                                  'laksh.bharani@gmail.com'),
                                              const HeightBox(15),
                                              const Text(
                                                'Phone No.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text('9972644523'),
                                              const HeightBox(15),
                                              const Text(
                                                'Gender',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text('Male'),
                                              const HeightBox(15),
                                              const Text(
                                                'Height',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text('189 cms'),
                                              const HeightBox(15),
                                              const Text(
                                                'Weight',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Text('72 Kgs'),
                                              const HeightBox(20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EditProfile()));
                                                },
                                                child:
                                                    const Text('Edit Details'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : null,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    isOnHome ? Colors.red : Colors.deepPurple,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnHome = true;
                                  isOnReports = false;
                                  isOnProfile = false;
                                });
                              },
                              child: const Icon(Icons.home_rounded),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: isOnReports
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnReports = true;
                                  isOnProfile = false;
                                });
                              },
                              child: const Icon(Icons.book_rounded),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: isOnProfile
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnReports = false;
                                  isOnProfile = true;
                                });
                              },
                              child: const Icon(Icons.person_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
