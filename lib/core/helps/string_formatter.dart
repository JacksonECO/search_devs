mixin StringFormatter {
  String numSuffix(int value) {
    if (value < 1000) return value.toString();
    if (value < 1000000) return '${(value / 1000).toStringAsFixed(1)}k';
    return '${(value / 1000000).toStringAsFixed(1)}m';
  }

  String lastTimer(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inDays > 0) return '${diff.inDays} dia${diff.inDays > 0 ? 's' : ''}';
    if (diff.inHours > 0) return '${diff.inHours} hora${diff.inHours > 0 ? 's' : ''}';
    if (diff.inMinutes > 0) return '${diff.inMinutes} minuto${diff.inMinutes > 0 ? 's' : ''}';
    return '${diff.inSeconds} segundo${diff.inSeconds > 0 ? 's' : ''}';
  }
}
