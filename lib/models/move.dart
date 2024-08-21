class Move {
  final String name;
  final String muscleGroup;
  final int springLoad;
  final String imageUrl;

  Move({
    required this.name,
    required this.muscleGroup,
    required this.springLoad,
    required this.imageUrl,
  });

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'muscleGroup': muscleGroup,
      'springLoad': springLoad,
      'imageUrl': imageUrl,
    };
  }

  // fromjson
  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      name: json['name'],
      muscleGroup: json['muscleGroup'],
      springLoad: json['springLoad'],
      imageUrl: json['imageUrl'],
    );
  }
}
