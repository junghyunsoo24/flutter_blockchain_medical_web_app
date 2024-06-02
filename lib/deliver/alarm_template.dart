const String alarmtTemplate = r'''
<toast launch="action=viewAlarm&amp;alarmId=3" scenario="alarm">
  <visual>
    <binding template="ToastGeneric">
      <text>userName 환자 추가 정보</text>
      <text>추가 증상: symptom</text> 
      <text>추가 의약품: medicine</text>
      <text>상세 내용: detail</text>
    </binding>
  </visual>
  <actions>
    <action
      activationType="forground"
      arguments="dismiss"
      content="확인"
    />
  </actions>
</toast>
''';