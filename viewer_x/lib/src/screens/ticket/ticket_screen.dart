import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:viewer_x/src/screens/ticket/components/ticket_widget.dart';

@RoutePage()
class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 0), () => _showTicket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,

      body: Center(child: TicketWidget()),
    );
  }
}
