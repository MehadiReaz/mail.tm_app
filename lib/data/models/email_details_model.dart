class EmailDetails {
  final String id;
  final String msgid;
  final Map<String, dynamic> from;
  final List<Map<String, dynamic>> to;
  final List<Map<String, dynamic>> cc;
  final List<Map<String, dynamic>> bcc;
  final String subject;
  final String intro;
  final bool seen;
  final bool flagged;
  final bool isDeleted;
  final Map<String, dynamic> verifications;
  final bool retention;
  final String retentionDate;
  final String text;
  final List<String> html;
  final bool hasAttachments;
  final List<Attachment> attachments; // Updated type to List<Attachment>
  final int size;
  final String downloadUrl;
  final String sourceUrl;
  final String createdAt;
  final String updatedAt;
  final String accountId;

  EmailDetails({
    required this.id,
    required this.msgid,
    required this.from,
    required this.to,
    required this.cc,
    required this.bcc,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.flagged,
    required this.isDeleted,
    required this.verifications,
    required this.retention,
    required this.retentionDate,
    required this.text,
    required this.html,
    required this.hasAttachments,
    required this.attachments,
    required this.size,
    required this.downloadUrl,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.accountId,
  });

  factory EmailDetails.fromJson(Map<String, dynamic> json) {
    return EmailDetails(
      id: json['id'] ?? '',
      msgid: json['msgid'] ?? '',
      from: Map<String, dynamic>.from(json['from'] ?? {}),
      to: List<Map<String, dynamic>>.from(json['to'] ?? []),
      cc: List<Map<String, dynamic>>.from(json['cc'] ?? []),
      bcc: List<Map<String, dynamic>>.from(json['bcc'] ?? []),
      subject: json['subject'] ?? '',
      intro: json['intro'] ?? '',
      seen: json['seen'] ?? false,
      flagged: json['flagged'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      verifications: Map<String, dynamic>.from(json['verifications'] ?? {}),
      retention: json['retention'] ?? false,
      retentionDate: json['retentionDate'] ?? '',
      text: json['text'] ?? '',
      html: List<String>.from(json['html'] ?? []),
      hasAttachments: json['hasAttachments'] ?? false,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((attachmentJson) => Attachment.fromJson(attachmentJson))
              .toList() ??
          [],
      size: json['size'] ?? 0,
      downloadUrl: json['downloadUrl'] ?? '',
      sourceUrl: json['sourceUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      accountId: json['accountId'] ?? '',
    );
  }
}

class Attachment {
  final String id;
  final String filename;
  final String contentType;
  final String disposition;
  final String transferEncoding;
  final bool related;
  final int size;
  final String downloadUrl;

  Attachment({
    required this.id,
    required this.filename,
    required this.contentType,
    required this.disposition,
    required this.transferEncoding,
    required this.related,
    required this.size,
    required this.downloadUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] ?? '',
      filename: json['filename'] ?? '',
      contentType: json['contentType'] ?? '',
      disposition: json['disposition'] ?? '',
      transferEncoding: json['transferEncoding'] ?? '',
      related: json['related'] ?? false,
      size: json['size'] ?? 0,
      downloadUrl: json['downloadUrl'] ?? '',
    );
  }
}
