import 'package:desk/model/type_model.dart';

class ServiceModel {
  final String name;
  final String description;
  final int cost;
  String? orderedBy;
  final TypeEnum type;
  final String ownerId;
  final String id;

  ServiceModel(
    this.orderedBy, {
    required this.name,
    required this.description,
    required this.cost,
    required this.type,
    required this.ownerId,
    required this.id,
  });
}
