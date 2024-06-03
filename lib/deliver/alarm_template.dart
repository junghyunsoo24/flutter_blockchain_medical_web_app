const String alarmtTemplate = r'''
<toast launch="action=viewAlarm&amp;alarmId=3" scenario="alarm">
  <visual>
    <binding template="ToastGeneric">
      <text>userName 환자 추가 정보</text>
      <text>추가 증상: symptom</text> 
      <text>추가 의약품: medicine</text>
      <text>상세 내용: detail</text>
      <text>---------------------</text>
      <text>처방 내역:</text>
      <text>병의원(약국): resHospitalName</text>
      <text>처방 일자: resTreatDate</text>
      <text>의약품 명: resPrescribeDrugName</text>
      <text>처방약품 효능: resPrescribeDrugEffect</text>
      <text>투약일수: resPrescribeDays</text>
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