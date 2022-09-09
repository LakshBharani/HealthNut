// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  int _index = 0;
  Stream<QuerySnapshot> getUpcomingAppointments(
      BuildContext context, String uid) async* {
    yield* FirebaseFirestore.instance
        .collection('user_basic_data')
        .doc(uid)
        .collection('upcoming_appointments')
        .snapshots();
  }

  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    final uid = FirebaseAuth.instance.currentUser?.uid;

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
                            child: Icon(
                              Icons.person_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                        const Positioned(
                            bottom: 30,
                            child: Text(
                              'Laksh Bharani',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        const Positioned(
                            bottom: 5,
                            child: Text(
                              'laksh.bharani@gmail.com',
                              style: TextStyle(color: Colors.white),
                            )),
                        Positioned(
                          right: 0,
                          top: 0,
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
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
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
                            ],
                          )
                        : Container(),
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                            0, 12, 0, 5),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100,
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
                                              SizedBox(
                                                width: 100,
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
                                              SizedBox(
                                                width: 100,
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
                                                      'My\nDocs',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100,
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
                                                            Icons.call_rounded,
                                                            size: 30,
                                                          )),
                                                    ),
                                                    const HeightBox(5),
                                                    const Text(
                                                      'Emergency\nContacts',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const HeightBox(20),
                                      const Text(
                                        'Upcoming',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const HeightBox(8),
                                      Center(
                                        child: SizedBox(
                                          height: 185,
                                          child: StreamBuilder(
                                            stream: getUpcomingAppointments(
                                                context, uid!),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Text("Loading...");
                                              }
                                              return PageView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                controller: PageController(
                                                    viewportFraction: 0.75),
                                                onPageChanged: (int index) =>
                                                    setState(
                                                        () => _index = index),
                                                itemBuilder: (_, i) {
                                                  return Transform.scale(
                                                    scale:
                                                        i == _index ? 1 : 0.9,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Stack(
                                                          children: [
                                                            const Positioned(
                                                              left: 0,
                                                              top: 0,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 35,
                                                                child: Icon(
                                                                  Icons
                                                                      .person_rounded,
                                                                  size: 40,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              // Container(
                                                              //   height: 70,
                                                              //   width: 70,
                                                              //   color: Colors
                                                              //       .deepPurple,
                                                              //   child:
                                                              //       const Icon(
                                                              //     Icons
                                                              //         .person_rounded,
                                                              //     size: 40,
                                                              //     color: Colors
                                                              //         .white,
                                                              //   ),
                                                              // ),
                                                            ),
                                                            const Positioned(
                                                              left: 80,
                                                              top: 0,
                                                              child: Text(
                                                                'Name',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 80,
                                                              top: 20,
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints: BoxConstraints(
                                                                    maxWidth: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        250,
                                                                    maxHeight:
                                                                        63),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .docs[i][
                                                                          'name']
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                            const Positioned(
                                                              left: 0,
                                                              top: 75,
                                                              child: Text(
                                                                'Date',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 0,
                                                              top: 95,
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints: BoxConstraints(
                                                                    maxWidth:
                                                                        MediaQuery.of(context).size.width /
                                                                                2 -
                                                                            100,
                                                                    maxHeight:
                                                                        63),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .docs[i][
                                                                          'date_appointment']
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                            const Positioned(
                                                              right: 0,
                                                              top: 75,
                                                              child: Text(
                                                                'Time',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              top: 95,
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints: BoxConstraints(
                                                                    maxWidth: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        280,
                                                                    maxHeight:
                                                                        63),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .docs[i][
                                                                          'time']
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
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
                                                  padding: EdgeInsets.only(
                                                      bottom: 30),
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
                                                        child: Icon(
                                                          Icons.person_rounded,
                                                          size: 80,
                                                        ),
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
                                              Text('Laksh Bharani'),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const EditProfile()));
                                                    },
                                                    child: const Text(
                                                        'Edit Details'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: const Text(
                                                          "Sign Out",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        content: const Text(
                                                            "Would you like to stay signed in?\nYou will have to login once again if you confirm."),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  'Cancel')),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      setState(
                                                                          () {
                                                                        loading =
                                                                            true;
                                                                      });
                                                                      context
                                                                          .read<
                                                                              AuthenticationProvider>()
                                                                          .signOut()
                                                                          .then(
                                                                              (value) {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const LoginPage()),
                                                                        ).then(
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            loading =
                                                                                false;
                                                                          });
                                                                        });
                                                                      });
                                                                    },
                                                                    child: const Text(
                                                                        'Confirm')),
                                                          )
                                                        ],
                                                      );
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    },
                                                    child:
                                                        const Text('Signout'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOnHome = true;
                                  isOnReports = false;
                                  isOnProfile = false;
                                });
                              },
                              child: Container(
                                height: 43,
                                width: 65,
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.home_rounded,
                                      color: isOnHome
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                    isOnHome
                                        ? const Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 5,
                                              color: Colors.deepPurple,
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                          )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnReports = true;
                                  isOnProfile = false;
                                });
                              },
                              child: Container(
                                height: 43,
                                width: 65,
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.book_rounded,
                                      color: isOnReports
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                    isOnReports
                                        ? const Padding(
                                            padding: EdgeInsets.only(top: 1),
                                            child: Icon(
                                              Icons.circle,
                                              size: 5,
                                              color: Colors.deepPurple,
                                            ),
                                          )
                                        : Container(
                                            height: 0,
                                          )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnReports = false;
                                  isOnProfile = true;
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                height: 43,
                                width: 65,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_rounded,
                                      color: isOnProfile
                                          ? Colors.deepPurple
                                          : Colors.black,
                                    ),
                                    isOnProfile
                                        ? const Icon(
                                            Icons.circle,
                                            size: 5,
                                            color: Colors.deepPurple,
                                          )
                                        : Container(
                                            height: 0,
                                          )
                                  ],
                                ),
                              ),
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
