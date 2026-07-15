enum ChatMessageType {
  text,
  image,
  file;

  String get value => name;

  static ChatMessageType fromValue(String? value) {
    return ChatMessageType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ChatMessageType.text,
    );
  }
}
