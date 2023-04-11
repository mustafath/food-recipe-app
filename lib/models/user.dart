abstract class UserBaseModel {
  final String id;
  final String name;
  String? imageUrl;
  String bio;
  List<String>? recipes;
  List<String>? followers;
  List<String>? following;

  UserBaseModel({
    required this.id,
    required this.name,
    this.imageUrl = "",
    this.bio = "",
    this.recipes = const [],
    this.followers = const [],
    this.following = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'bio': bio,
      'recipes': recipes,
      'followers': followers,
      'following': following,
    };
  }
}

class LoggedInUserModel extends UserBaseModel {
  final List<String> savedRecipes;

  LoggedInUserModel({
    required String id,
    required String name,
    String imageUrl = "",
    String bio = "",
    List<String> recipes = const [],
    List<String> followers = const [],
    List<String> following = const [],
    this.savedRecipes = const [],
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          bio: bio,
          recipes: recipes,
          followers: followers,
          following: following,
        );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['savedRecipes'] = savedRecipes;
    return map;
  }

  static LoggedInUserModel fromMap(Map<String, dynamic> map) {
    return LoggedInUserModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      bio: map['bio'],
      recipes: List<String>.from(map['recipes']),
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      savedRecipes: List<String>.from(map['savedRecipes']),
    );
  }
}

class UserDisplayModel extends UserBaseModel {
  UserDisplayModel({
    required String id,
    required String name,
    String imageUrl = "",
    String bio = "",
    List<String> recipes = const [],
    List<String> followers = const [],
    List<String> following = const [],
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          bio: bio,
          recipes: recipes,
          followers: followers,
          following: following,
        );

  static UserDisplayModel fromMap(Map<String, dynamic> map) {
    return UserDisplayModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      bio: map['bio'],
      recipes: List<String>.from(map['recipes']),
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
    );
  }
}
