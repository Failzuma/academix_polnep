import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:academix_polnep/views/sihadir/presensi/pengajuan_izin.dart'; // Import the PengajuanIzin class
import 'package:intl/intl.dart'; // For formatting date and time

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
    '111222': {
      'className': 'Pemrograman Web',
      'dosenName': 'Dr. John Smith',
      'timedate': '2024-08-13 10:00 AM',
      'roomId': 'Room 103',
    },
    '222111': {
      'className': 'Sistem Operasi',
      'dosenName': 'Dr. Jane Smith',
      'timedate': '2024-08-13 01:00 PM',
      'roomId': 'Room 104',
    },
    '333444': {
      'className': 'Jaringan Komputer',
      'dosenName': 'Dr. John Johnson',
      'timedate': '2024-08-14 10:00 AM',
      'roomId': 'Room 105',
    },
    '444333': {
      'className': 'Basis Data',
      'dosenName': 'Dr. Jane Johnson',
      'timedate': '2024-08-14 01:00 PM',
      'roomId': 'Room 106',
    },
    '555666': {
      'className': 'Algoritma dan Struktur Data',
      'dosenName': 'Dr. John Brown',
      'timedate': '2024-08-15 10:00 AM',
      'roomId': 'Room 107',
    },
    // Add more tokens if needed
  };

  final TextEditingController _tokenController = TextEditingController();
  bool _isTokenValid = false;
  List<DataRow> _dataRows = []; // Store the rows of the DataTable

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

  void _addDataToTable() {
    final enteredToken = _tokenController.text.trim();
    final tokenInfo = tokenData[enteredToken];

    if (_isTokenValid) {
      // Check if the token is already used
      final isTokenAlreadyUsed = _dataRows.any(
        (row) {
          final cell = row.cells[1].child as Text;
          return cell.data == tokenInfo!['className'];
        },
      );

      if (isTokenAlreadyUsed) {
        // Token already used
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan', style: GoogleFonts.manrope()),
              content: Text('Data sudah ada!', style: GoogleFonts.manrope()),
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
        return;
      }

      // Check if the number of rows is less than 6
      if (_dataRows.length < 6) {
        final currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        setState(() {
          _dataRows.add(
            DataRow(
              cells: [
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green, // Assuming 'Hadir' for new entries
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Hadir',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    tokenInfo!['className']!,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF424242),
                    ),
                  ),
                ),
              ],
              onSelectChanged: (selected) {
                if (selected == true) {
                  _showDetailsDialog(tokenInfo, currentTime);
                }
              },
            ),
          );
        });
      } else {
        // Maximum number of rows reached
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Peringatan', style: GoogleFonts.manrope()),
              content: Text('Jumlah data sudah mencapai batas maksimum!', style: GoogleFonts.manrope()),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan', style: GoogleFonts.manrope()),
            content: Text('Token tidak valid!', style: GoogleFonts.manrope()),
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
  }

  void _showDetailsDialog(Map<String, String> tokenInfo, String currentTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Presensi', style: GoogleFonts.manrope()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mata Kuliah\t: ${tokenInfo['className']}', style: GoogleFonts.manrope(fontSize: 16)),
              Text('Dosen Name\t: ${tokenInfo['dosenName']}', style: GoogleFonts.manrope(fontSize: 14)),
              Text('Waktu Presensi\t: $currentTime', style: GoogleFonts.manrope(fontSize: 14)),
              Text('Ruangan\t\t: ${tokenInfo['roomId']}', style: GoogleFonts.manrope(fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close', style: GoogleFonts.manrope()),
            ),
          ],
        );
      },
    );
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
              "Tabel Presensi Mingguan Anda", EdgeInsets.zero),
          _buildAbsensiTable(),
        ],
      ),
    );
  }

Widget _buildShadowedContainer(double screenWidth, double screenHeight) {
  final enteredToken = _tokenController.text.trim();
  final tokenInfo = tokenData[enteredToken];

  // Check if the token is already used
  final isTokenAlreadyUsed = _dataRows.any(
    (row) {
      final cell = row.cells[1].child as Text;
      return tokenInfo != null && cell.data == tokenInfo['className'];
    },
  );

  return Container(
    margin: EdgeInsets.fromLTRB(screenWidth * 0.03, 0, screenWidth * 0.05, screenHeight * 0.04),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color(0x40000000),
          offset: const Offset(0, 4),
          blurRadius: 4,
        ),
      ],
      borderRadius: BorderRadius.circular(12),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: screenWidth * 0.8, // Reduced width
        height: screenHeight * 0.2, // Reduced height
        color: const Color.fromARGB(255, 246, 246, 246),
        child: _isTokenValid
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Class Name: ${tokenInfo!['className']}',
                      style: GoogleFonts.manrope(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('Dosen Name: ${tokenInfo['dosenName']}',
                      style: GoogleFonts.manrope(fontSize: 13)),
                  Text('Time and Date: ${tokenInfo['timedate']}',
                      style: GoogleFonts.manrope(fontSize: 13)),
                  Text('Room ID: ${tokenInfo['roomId']}',
                      style: GoogleFonts.manrope(fontSize: 13)),
                  SizedBox(height: 16), // Reduced space between text and button
                  ElevatedButton(
                    onPressed: isTokenAlreadyUsed
                        ? null // Disable the button if the token is already used
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PengajuanIzin()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: isTokenAlreadyUsed
                            ? const LinearGradient(
                                colors: [Colors.grey, Colors.grey],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : const LinearGradient(
                                colors: [Color(0xFF158AD4), Color(0xFF39EADD)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minWidth: 80,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          isTokenAlreadyUsed ? 'Data presensi sudah terdaftar!' : 'Ajukan Izin',
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
                child: Text('Kelas tidak ditemukan!',
                    style: GoogleFonts.manrope(fontSize: 18))),
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
        _addDataToTable(); // Add data to table when pressed
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
                showCheckboxColumn: false, // Hide the checkbox column
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
                rows: _dataRows, // Use dynamic rows
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
                dataRowHeight: 60, // Adjust height to fit content
              ),
            ),
          ),
        ],
      ),
    );
  }
}
