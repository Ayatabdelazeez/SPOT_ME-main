class AdminStats {
  final int totalPlayers;
  final int totalScouts;
  final int activeSubscriptions;
  final int pendingReports;

  const AdminStats({
    required this.totalPlayers,
    required this.totalScouts,
    required this.activeSubscriptions,
    required this.pendingReports,
  });

  static const AdminStats demo = AdminStats(
    totalPlayers: 128,
    totalScouts: 34,
    activeSubscriptions: 52,
    pendingReports: 3,
  );
}