class Message {
   String message;
   String id;
  Message(this.message,this.id,);

  factory Message.fromJson(jsonData) {
    return Message(jsonData['message'],jsonData['id']);
  }
}
