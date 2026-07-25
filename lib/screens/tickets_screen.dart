import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = const [
      _Ticket(
          title: 'Metropolitan Museum',
          date: 'Aug 15, 2026',
          time: '10:00 AM',
          type: 'General Admission',
          code: 'MET-2026-8A3F',
          status: 'Confirmed'),
      _Ticket(
          title: 'National Gallery',
          date: 'Aug 22, 2026',
          time: '7:00 PM',
          type: 'Evening Pass',
          code: 'NAT-2026-9B2D',
          status: 'Confirmed'),
    ];

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16, color: AppColors.green),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('My Tickets',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text('+ New',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)),
                  ),
                ],
              ),
            ),

            // Tickets list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: tickets.length,
                itemBuilder: (_, i) => _ticketCard(tickets[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketCard(_Ticket ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: AppColors.green.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        children: [
          // Top
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticket.type,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xFF4ADE80),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(ticket.status,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppColors.green)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(ticket.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text('${ticket.date} · ${ticket.time}',
                    style: const TextStyle(fontSize: 13, color: Colors.white70)),
              ],
            ),
          ),

          // Dashed line
          CustomPaint(
            size: Size(double.infinity, 1),
            painter: _DashedPainter(),
          ),

          // Bottom - QR code placeholder
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Fake QR
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.sand),
                      borderRadius: BorderRadius.circular(12)),
                  child: GridView.count(
                    crossAxisCount: 6,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: List.generate(36, (i) {
                      final show = (i * 7 + i * 13) % 3 != 0;
                      return show
                          ? Container(
                              decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(1)))
                          : const SizedBox();
                    }),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ticket Code',
                          style: TextStyle(
                              fontSize: 10,
                              color: AppColors.green.withOpacity(0.44))),
                      const SizedBox(height: 2),
                      Text(ticket.code,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: AppColors.green)),
                    ],
                  ),
                ),
                Icon(Icons.qr_code_2_rounded,
                    size: 28, color: AppColors.gold.withOpacity(0.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Ticket {
  final String title;
  final String date;
  final String time;
  final String type;
  final String code;
  final String status;
  const _Ticket(
      {required this.title,
      required this.date,
      required this.time,
      required this.type,
      required this.code,
      required this.status});
}

class _DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.sand
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
