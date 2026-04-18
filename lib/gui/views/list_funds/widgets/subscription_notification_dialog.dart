import 'package:flutter/material.dart';
import 'package:fondos_app/data/models/fund_model.dart';

/// Diálogo para elegir email o SMS al suscribirse a un fondo.
Future<SubscriptionNotificationMethod?> showSubscriptionNotificationDialog(
  BuildContext context,
  FundModel fund,
) {
  return showDialog<SubscriptionNotificationMethod>(
    context: context,
    builder: (context) => _SubscriptionNotificationDialog(fund: fund),
  );
}

class _SubscriptionNotificationDialog extends StatefulWidget {
  const _SubscriptionNotificationDialog({required this.fund});

  final FundModel fund;

  @override
  State<_SubscriptionNotificationDialog> createState() =>
      _SubscriptionNotificationDialogState();
}

class _SubscriptionNotificationDialogState
    extends State<_SubscriptionNotificationDialog> {
  SubscriptionNotificationMethod _method = SubscriptionNotificationMethod.email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Suscripción al fondo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fund.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Monto mínimo: COP \$${widget.fund.minimum.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
            const SizedBox(height: 16),
            const Text('¿Cómo deseas recibir las notificaciones?'),
            const SizedBox(height: 8),
            RadioListTile<SubscriptionNotificationMethod>(
              title: const Text('Correo electrónico'),
              subtitle: const Text('Alertas al email de tu cuenta'),
              value: SubscriptionNotificationMethod.email,
              groupValue: _method,
              onChanged: (v) {
                if (v != null) {
                  setState(() => _method = v);
                }
              },
            ),
            RadioListTile<SubscriptionNotificationMethod>(
              title: const Text('SMS'),
              subtitle: const Text('Mensajes de texto al teléfono registrado'),
              value: SubscriptionNotificationMethod.sms,
              groupValue: _method,
              onChanged: (v) {
                if (v != null) {
                  setState(() => _method = v);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_method),
          child: const Text('Confirmar suscripción'),
        ),
      ],
    );
  }
}
