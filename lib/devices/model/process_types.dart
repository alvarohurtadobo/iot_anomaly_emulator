enum ProcessType { hoursOperated, oilAnalysis, vibrations }

Map<ProcessType, String> map = {
  ProcessType.hoursOperated: 'Hours Operated',
  ProcessType.oilAnalysis: 'Oil Analysis',
  ProcessType.vibrations: 'Vibrations',
};
String processTypeToString(ProcessType type) {
  return map[type] ?? '';
}
