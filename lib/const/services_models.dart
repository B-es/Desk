import 'package:desk/model/service_model.dart';
import 'package:desk/model/type_model.dart';

final List<ServiceModel> serviceModels = [
  ServiceModel(
    null,
    name: "Разработка сайта",
    description: "Разработаю любой сайт и любой сложности",
    cost: 15000,
    type: TypeEnum.programming,
    ownerId: "user1",
    id: "1",
  ),
  ServiceModel(
    "user1",
    name: "Постройка бетонного забора",
    description: "Ставлю заборы, недорого",
    cost: 30000,
    type: TypeEnum.building,
    ownerId: "user2",
    id: "2",
  ),
  ServiceModel(
    null,
    name: "Репетитор по профильной математика",
    description:
        "Научимся решать квадратные уравнения, D и D1 тоже будут, но без Виета",
    cost: 5000,
    type: TypeEnum.repeating,
    ownerId: "user3",
    id: "3",
  ),
  ServiceModel(
    null,
    name: "Заменю сифон, пока играет граммофон",
    description: "И так умею",
    cost: 10000,
    type: TypeEnum.plumbing,
    ownerId: "user4",
    id: "4",
  ),
];
