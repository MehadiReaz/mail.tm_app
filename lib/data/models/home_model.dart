import 'package:equatable/equatable.dart';

class HomeModel extends Equatable {
  final List<MessageModel> messages;

  const HomeModel({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      messages: (json['hydra:member'] as List)
          .map((message) => MessageModel.fromJson(message))
          .toList(),
    );
  }
}

class MessageModel extends Equatable {
  final String id;
  final String msgid;
  final SenderModel from;
  final List<RecipientModel> to;
  final String subject;
  final String intro;
  final bool seen;
  final bool isDeleted;
  final bool hasAttachments;
  final int size;
  final String downloadUrl;
  final String sourceUrl;
  final String createdAt;
  final String updatedAt;
  final String accountId;

  const MessageModel({
    required this.id,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.accountId,
  });

  @override
  List<Object?> get props => [
        id,
        msgid,
        from,
        to,
        subject,
        intro,
        seen,
        isDeleted,
        hasAttachments,
        size,
        downloadUrl,
        sourceUrl,
        createdAt,
        updatedAt,
        accountId,
      ];

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['@id'] ?? '',
      msgid: json['msgid'] ?? '',
      from: SenderModel.fromJson(json['from']),
      to: (json['to'] as List)
          .map((recipient) => RecipientModel.fromJson(recipient))
          .toList(),
      subject: json['subject'] ?? '',
      intro: json['intro'] ?? '',
      seen: json['seen'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      hasAttachments: json['hasAttachments'] ?? false,
      size: json['size'] ?? 0,
      downloadUrl: json['downloadUrl'] ?? '',
      sourceUrl: json['sourceUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      accountId: json['accountId'] ?? '',
    );
  }
}

class SenderModel extends Equatable {
  final String address;
  final String name;

  const SenderModel({
    required this.address,
    required this.name,
  });

  @override
  List<Object?> get props => [address, name];

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      address: json['address'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class RecipientModel extends Equatable {
  final String address;
  final String name;

  const RecipientModel({
    required this.address,
    required this.name,
  });

  @override
  List<Object?> get props => [address, name];

  factory RecipientModel.fromJson(Map<String, dynamic> json) {
    return RecipientModel(
      address: json['address'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
