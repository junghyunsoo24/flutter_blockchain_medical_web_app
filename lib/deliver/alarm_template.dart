const String alarmtTemplate = r'''
<toast launch="action=viewAlarm&amp;alarmId=3" scenario="alarm">
  <visual>
    <binding template="ToastGeneric">
      <text>새로운 환자 정보</text>
      <text>추가 증상: %(추가 증상)</text>
      <text>추가 의약품: %(추가 의약품)</text>
      <text>상세 내용: %(상세 내용)</text>
    </binding>
  </visual>
  <actions>
    <action
      activationType="background"
      arguments="dismiss"
      content="확인"
    />
  </actions>
</toast>
''';