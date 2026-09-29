import 'package:desk/const/services_models.dart';
import 'package:desk/model/service_model.dart';
import 'package:desk/model/type_model.dart';

class ServicesRepos {
  late final List<ServiceModel> _models;

  ServicesRepos() {
    _models = serviceModels;
  }

  setOrder(final String id, final String userId) {
    _models.firstWhere((element) => element.id == id).orderedBy = userId;
  }

  add(
    final String name,
    final String description,
    final int cost,
    final TypeEnum type,
    final String ownerId,
  ) {
    final String id = (_models.length + 1).toString();
    final newService = ServiceModel(
      null,
      name: name,
      description: description,
      type: type,
      cost: cost,
      id: id,
      ownerId: ownerId,
    );
    _models.add(newService);
  }

  List<ServiceModel> get models => _models;
}
