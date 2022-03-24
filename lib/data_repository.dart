class DataModel {
  String? name;
  Owner? owner;
  String? description;
  int? stargazersCount;
  String? language;
  int? forksCount;

  DataModel({
    this.name,
    this.owner,
    this.description,
    this.stargazersCount,
    this.language,
    this.forksCount,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    description = json['description'];
    stargazersCount = json['stargazers_count'];
    language = json['language'];
    forksCount = json['forks_count'];
  }
}

class Owner {
  String? login;
  Owner({
    this.login,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
  }
}
