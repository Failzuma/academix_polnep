import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:academix_polnep/views/sihadir/presensi/pengajuan_izin.dart';

class Presensi extends StatefulWidget {
  const Presensi({super.key});

  @override
  State<Presensi> createState() => _PresensiState();
}

class _PresensiState extends State<Presensi> {
  final String hardcodedToken = '123456'; // Example token
  final Map<String, Map<String, String>> tokenData = {
    '123456': {
      'className': 'Pemrograman Mobile',
      'dosenName': 'Dr. John Doe',
      'timedate': '2024-08-12 10:00 AM',
      'roomId': 'Room 101',
    },
    '654321': {
      'className': 'Grafika Komputer',
      'dosenName': 'Dr. Jane Doe',
      'timedate': '2024-08-12 01:00 PM',
      'roomId': 'Room 102',
    },
    // Add more tokens if needed
  };

  final TextEditingController _tokenController = TextEditingController();
  bool _isTokenValid = false;

  void _validateToken() {
    final enteredToken = _tokenController.text.trim();
    if (tokenData.containsKey(enteredToken)) {
      setState(() {
        _isTokenValid = true;
      });
    } else {
      setState(() {
        _isTokenValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildShadowedContainer(screenWidth, screenHeight),
          _buildTokenInputWithLabel(),
          SizedBox(height: screenHeight * 0.02),
          _buildAbsenButton(),
          SizedBox(height: screenHeight * 0.02),
          _buildTextWithPadding(
              "Tabel Presensi Mingguan Kamu", EdgeInsets.zero),
          _buildAbsensiTable(),
        ],
      ),
    );
  }

  Widget _buildShadowedContainer(double screenWidth, double screenHeight) {
    final enteredToken = _tokenController.text.trim();
    final tokenInfo = tokenData[enteredToken];

    return Container(
      margin: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.05,
          screenHeight * 0.04), // Increased bottom margin
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 4, // Increased blur radius for better shadow effect
          ),
        ],
        borderRadius: BorderRadius.circular(
            12), // Increased border radius for a smoother look
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Match border radius
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.25, // Increased height for more space
          color: const Color.fromARGB(255, 246, 246, 246),
          child: _isTokenValid
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Class Name: ${tokenInfo!['className']}',
                        style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold)), // Increased font size
                    Text('Dosen Name: ${tokenInfo['dosenName']}',
                        style: GoogleFonts.manrope(
                            fontSize: 14)), // Increased font size
                    Text('Time and Date: ${tokenInfo['timedate']}',
                        style: GoogleFonts.manrope(
                            fontSize: 14)), // Increased font size
                    Text('Room ID: ${tokenInfo['roomId']}',
                        style: GoogleFonts.manrope(
                            fontSize: 14)), // Increased font size
                    SizedBox(
                        height: 24), // Increased space between text and button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PengajuanIzin()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Increased padding
                        backgroundColor: Colors
                            .transparent, // Set to transparent for gradient effect
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF158AD4), Color(0xFF39EADD)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minWidth: 80, // Adjust minimum width
                            minHeight: 36, // Adjust minimum height
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // Increased padding
                          child: Text(
                            'Ajukan Izin',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text('Token tidak valid!',
                      style: GoogleFonts.manrope(
                          fontSize: 18))), // Increased font size
        ),
      ),
    );
  }

  Widget _buildTextWithPadding(String text, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTokenInputWithLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, bottom: 5),
          child: Text(
            'Token Kelas',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFE2DEDE),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 45,
          child: Center(
            child: TextField(
              controller: _tokenController,
              maxLength: 6,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Masukkan Token Kelas',
                hintStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white,
                ),
                counterText: '', // Hide the counter text
              ),
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
              keyboardType: TextInputType.text,
              onChanged: (text) {
                _validateToken(); // Validate token whenever the text changes
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbsenButton() {
    return ElevatedButton(
      onPressed: () {
        if (_isTokenValid) {
          // Token is valid, proceed with the action
          setState(() {}); // Rebuild to update the container
        } else {
          // Token is not valid, show a popup notification
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Peringatan', style: GoogleFonts.manrope()),
                content:
                    Text('Token tidak valid!', style: GoogleFonts.manrope()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('OK', style: GoogleFonts.manrope()),
                  ),
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF158AD4), Color(0xFF39EADD)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minWidth: 80,
            minHeight: 36,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Absen',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAbsensiTable() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF158AD4), Color(0xFF39EADD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.transparent),
                headingTextStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Mata Kuliah')),
                ],
                rows: [
                  _buildDataRow('Hadir', 'Pemrograman Mobile'),
                  _buildDataRow('Izin', 'Pemrograman Mobile'),
                  _buildDataRow('Hadir', 'Pemrograman Mobile'),
                  _buildDataRow('Kosong', 'Pemrograman Mobile'),
                  _buildDataRow('Alpa', 'Grafika Komputer'),
                ],
                dataRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(
                          0xFFE8EAF6); // Lighter indigo for selected rows
                    }
                    return const Color(0xFFFFFFFF); // White for unselected rows
                  },
                ),
                dataTextStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFF424242),
                ),
                dividerThickness: 1.5,
                columnSpacing: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

DataRow _buildDataRow(String status, String mataKuliah) {
  return DataRow(
    cells: [
      DataCell(
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          width: 80, // Set a fixed width for the color box
          height: 30, // Adjust the height to be lower
          decoration: BoxDecoration(
            color: status == 'Hadir'
                ? Colors.green
                : status == 'Alpa'
                    ? Colors.red
                    : status == 'Izin'
                        ? Colors.blue
                        : Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center, // Center align the text
          child: Text(
            status,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center, // Ensure text is centered
          ),
        ),
      ),
      DataCell(
        Text(
          mataKuliah,
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(0xFF424242),
          ),
        ),
      ),
    ],
  );
}



}
