import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String msgid;
  final Map<String, dynamic> from;
  final List<Map<String, dynamic>> to;
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

  MessageModel({
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
      id: json['id'] ?? '',
      msgid: json['msgid'] ?? '',
      from: Map<String, dynamic>.from(json['from'] ?? {}),
      to: List<Map<String, dynamic>>.from(json['to'] ?? []),
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
