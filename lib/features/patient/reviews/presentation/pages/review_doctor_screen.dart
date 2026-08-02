import 'package:flutter/material.dart';

class ReviewDokterPage extends StatefulWidget {
  const ReviewDokterPage({super.key});

  @override
  State<ReviewDokterPage> createState() => _ReviewDokterPageState();
}

class _ReviewDokterPageState extends State<ReviewDokterPage> {
  final List<bool> _selectedOptions = [false, false, false, false, false];
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF84BCEA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF2158A1),
              size: 16,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kembali',
          style: TextStyle(
            color: Color(0xFF2158A1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Istok Web',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Penilaian',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2158A1),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black87, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFF84BCEA),
                          child: const Icon(Icons.person, size: 30, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'dr. Bagas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2158A1),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(height: 1, color: Colors.black87),
                    const SizedBox(height: 20),
                    
                    // Checklist Options
                    const Text(
                      'Dokter ini telah :',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Instrument Sans',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildCheckbox(
                      0,
                      'Memberikan Respons yang Baik',
                    ),
                    _buildCheckbox(
                      1,
                      'Memberikan Pelayanan yang Memuaskan',
                    ),
                    _buildCheckbox(
                      2,
                      'Memberikan Diagnosis',
                    ),
                    _buildCheckbox(
                      3,
                      'Bersikap Ramah',
                    ),
                    _buildCheckbox(
                      4,
                      'Berpenilaku Sopan dan Profesional',
                    ),
                    const SizedBox(height: 24),
                    
                    // Rating
                    const Text(
                      'Berikan Penilaian anda :',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Instrument Sans',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.star,
                              size: 36,
                              color: index < _rating
                                  ? const Color(0xFFFCC628)
                                  : Colors.black,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    
                    // Review Text Field
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: '(Opsional) Tuliskan Ulasan...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Instrument Sans',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2158A1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Kirim Ulasan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: _selectedOptions[index],
              onChanged: (value) {
                setState(() {
                  _selectedOptions[index] = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(color: Colors.grey.shade600, width: 1.5),
              activeColor: const Color(0xFF2158A1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontFamily: 'Instrument Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}