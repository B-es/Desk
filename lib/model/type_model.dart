enum TypeEnum { building, programming, repeating, plumbing }

class TypeModel {
  final String imagePath;
  final String title;
  final TypeEnum type;

  const TypeModel({
    required this.imagePath,
    required this.title,
    required this.type,
  });

  @override
  String toString() {
    return title;
  }
}
