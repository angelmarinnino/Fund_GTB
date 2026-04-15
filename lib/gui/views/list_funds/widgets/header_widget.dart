import 'package:flutter/material.dart';

class HeaderPageWidget extends StatelessWidget {
  final String saldoDisponible;

  const HeaderPageWidget({super.key, required this.saldoDisponible});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Fondos Disponibles',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Selecciona un fondo para ver más detalles y realizar tu inversión.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          constraints: const BoxConstraints(minWidth: 250),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saldo Disponible',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Text(
                saldoDisponible,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Saldo actualizado en tiempo real',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
