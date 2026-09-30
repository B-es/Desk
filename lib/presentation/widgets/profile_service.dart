import 'package:desk/presentation/widgets/service.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart' hide Image;

class ProfileService extends Service {
  const ProfileService({super.key, required super.model});

  @override
  onTap(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (BuildContext context) {
        return GiffyBottomSheet.image(
          Image.asset(
            "assets/images/succes.gif",
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          title: Text(
            'Заказанная вами услуга',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .displayMedium
                ?.copyWith(fontSize: 24),
          ),
          content: Text(
            'Цена: ${model.cost} руб.',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
