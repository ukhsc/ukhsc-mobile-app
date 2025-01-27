import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_status.freezed.dart';
part 'server_status.g.dart';

@freezed
abstract class ServerStatus with _$ServerStatus {
  const factory ServerStatus({required ServiceStatus status}) = _ServerStatus;

  factory ServerStatus.fromJson(Map<String, dynamic> json) =>
      _$ServerStatusFromJson(json);
}

enum ServiceStatus {
  @JsonValue('Normal')
  normal,
  @JsonValue('Maintenance')
  maintenance;
}
