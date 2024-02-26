import 'package:equatable/equatable.dart';

class DomainModel extends Equatable {
  final String id;
  final String domain;
  final bool isActive;
  final bool isPrivate;
  final String createdAt;
  final String updatedAt;

  DomainModel({
    required this.id,
    required this.domain,
    required this.isActive,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, domain, isActive, isPrivate, createdAt, updatedAt];

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      id: json['id'] ?? '',
      domain: json['domain'] ?? '',
      isActive: json['isActive'] ?? false,
      isPrivate: json['isPrivate'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
