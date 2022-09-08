// ignore_for_file: prefer_final_fields

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
  bool loading = false;
  bool isOnHome = true;
  bool isOnRecords = false;
  bool isOnProfile = false;
  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: currentOrientation == Orientation.portrait
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
                                hintText: 'Search Medecine',
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
                                child: const Icon(Icons.notifications_none),
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
                        Container(
                          height: 46,
                          width: 46,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              AlertDialog alert = AlertDialog(
                                title: const Text(
                                  "Sign Out",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                    "Would you like to stay signed in?\nYou will have to login once again if you confirm."),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          loading = true;
                                        });
                                        context
                                            .read<AuthenticationProvider>()
                                            .signOut()
                                            .then((value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()),
                                          ).then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                          });
                                        });
                                      },
                                      child: const Text('Confirm'))
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            splashRadius: 1,
                            splashColor: Colors.red,
                            icon: const Icon(Icons.logout),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 154,
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
                                                          onPressed: () {},
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
                                              3, 3, 3, 3),
                                          child: LineChart(
                                            LineChartData(
                                              minX: 0,
                                              maxX: 11,
                                              minY: 0,
                                              maxY: 6,
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    const FlSpot(0, 3),
                                                    const FlSpot(2.6, 2),
                                                    const FlSpot(4.9, 5),
                                                    const FlSpot(6.8, 2.5),
                                                    const FlSpot(8, 4),
                                                    const FlSpot(9.5, 3),
                                                    const FlSpot(11, 4),
                                                  ],
                                                  isCurved: true,
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
                                              3, 3, 3, 3),
                                          child: LineChart(
                                            LineChartData(
                                              minX: 0,
                                              maxX: 11,
                                              minY: 0,
                                              maxY: 6,
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: [
                                                    const FlSpot(0, 3),
                                                    const FlSpot(2.6, 2),
                                                    const FlSpot(4.9, 5),
                                                    const FlSpot(6.8, 2.5),
                                                    const FlSpot(8, 4),
                                                    const FlSpot(9.5, 3),
                                                    const FlSpot(11, 4),
                                                  ],
                                                  isCurved: true,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 0, 62, 116),
                                                      Color.fromARGB(
                                                          255, 0, 150, 224),
                                                    ],
                                                  ),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            126, 0, 62, 116),
                                                        Color.fromARGB(
                                                            62, 0, 149, 224),
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
                            : isOnRecords
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
                                  isOnRecords = false;
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
                                backgroundColor: isOnRecords
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                              onPressed: () {
                                setState(() {
                                  isOnHome = false;
                                  isOnRecords = true;
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
                                  isOnRecords = false;
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
