class GuestSession {
  final String guestSessionId;
  final String expiresAt;

  GuestSession({
    required this.guestSessionId,
    required this.expiresAt,
  });

  factory GuestSession.fromJson(Map<String, dynamic> json) => GuestSession(
        guestSessionId: json["guest_session_id"],
        expiresAt: json["expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "guest_session_id": guestSessionId,
        "expires_at": expiresAt,
      };
}
