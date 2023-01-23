class dataClass {
  String? id;
  String? language;
  List<int>? category;
  String? author;
  String? title;
  String? description;
  String? mediaslug;
  String? readMoreUrl;
  String? source;
  Null? sponsored;
  Null? sponsoredby;
  String? createdAt;
  Null? categories;
  String? type;

  dataClass(
      {this.id,
      this.language,
      this.category,
      this.author,
      this.title,
      this.description,
      this.mediaslug,
      this.readMoreUrl,
      this.source,
      this.sponsored,
      this.sponsoredby,
      this.createdAt,
      this.categories,
      this.type});

  dataClass.fromJson(dynamic json) {
    id = json['id'];
    language = json['language'];
    category = json['category'].cast<int>();
    author = json['author'];
    title = json['title'];
    description = json['description'];
    mediaslug = json['mediaslug'];
    readMoreUrl = json['readMoreUrl'];
    source = json['source'];
    sponsored = json['sponsored'];
    sponsoredby = json['sponsoredby'];
    createdAt = json['createdAt'];
    categories = json['categories'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['category'] = this.category;
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['mediaslug'] = this.mediaslug;
    data['readMoreUrl'] = this.readMoreUrl;
    data['source'] = this.source;
    data['sponsored'] = this.sponsored;
    data['sponsoredby'] = this.sponsoredby;
    data['createdAt'] = this.createdAt;
    data['categories'] = this.categories;
    data['type'] = this.type;
    return data;
  }
}
