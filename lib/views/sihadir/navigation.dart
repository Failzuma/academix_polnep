import 'package:academix_polnep/views/helper/styleHelper.dart';
import 'package:academix_polnep/views/sihadir/dashboard/dashboard.dart';
import 'package:academix_polnep/views/sihadir/kelas/kelas_admin.dart';
import 'package:academix_polnep/views/sihadir/kelas/kelas_dosen.dart';
import 'package:academix_polnep/views/sihadir/kelas/kelas_mahasiswa.dart';
import 'package:academix_polnep/views/sihadir/presensi/pengajuan_izin.dart';
import 'package:academix_polnep/views/sihadir/presensi/presensi.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedNavbar = 0;
  final _pages = [
    // contoh
    const Dashboard(), // home
    Presensi(), // presensi
    const Text("Kalender Akademik"), // kalender
    KelasDosen(), // kelas
    const Text("Laporan"), // laporan
  ];

  void changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: _pages.elementAt(_selectedNavbar),
        )),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          color: const Color(0xFF25B4D8),
          activeColor: const Color(0xFF25B4D8),
          style: TabStyle.react,
          items: const [
            TabItem(icon: Icons.home_outlined, title: "Home"),
            TabItem(icon: Icons.calendar_today, title: "Presensi"),
            TabItem(icon: Icons.assessment, title: "Kalender"),
            TabItem(icon: Icons.assessment, title: "Kelas"),
            TabItem(icon: Icons.assessment, title: "Laporan"),
          ],
          initialActiveIndex: 0,
          onTap: changeSelectedNavBar,
        ),
      ),
    );
  }
}
