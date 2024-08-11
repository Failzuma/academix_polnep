// import 'package:academix_polnep/views/sirekap/views/revisi/dosen.dart';
import 'package:academix_polnep/views/sirekap/views/revisi/dosen.dart';
import 'package:academix_polnep/views/sirekap/views/revisi/listrev.dart';
// import 'package:academix_polnep/views/sirekap/views/revisi/dosen1.dart';
import 'package:academix_polnep/views/sirekap/views/revisi/revisiNav.dart';
import 'package:academix_polnep/views/sirekap/views/revisi/Confirm.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageList()));
                      },
                      child: const Text(
                        'List Button',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PagesUpdated()));
                      },
                      child: const Text(
                        'Updated Button ',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Dosen()));
                      },
                      child: const Text(
                        'Updated Button ',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
