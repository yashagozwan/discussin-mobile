class TopicResponse {
  String message;

  Iterable<Topic> data;

  TopicResponse({
    required this.message,
    required this.data,
  });

  factory TopicResponse.fromMap(Map<String, dynamic> data) {
    Iterable<Topic> topics = [];

    if (data['data_topic'] != null) {
      final mapTopics = data['data_topic'] as List;
      if (mapTopics.isNotEmpty) {
        topics = mapTopics.map((topic) => Topic.fromMap(topic));
      }
    }

    return TopicResponse(
      message: data['message'],
      data: topics,
    );
  }

  @override
  String toString() {
    return 'TopicResponse(message:$message, data:$data)';
  }
}

class Topic {
  int? id;
  String name;
  String description;

  Topic({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> data) {
    return Topic(
      id: data['ID'],
      name: data['name'],
      description: data['description'],
    );
  }

  @override
  String toString() {
    return 'Topic(id:$id, name:$name, description:$description)';
  }
}
