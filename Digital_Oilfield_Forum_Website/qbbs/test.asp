<html>
<body>

<script language='javascript'>

  var to = 'person@company.com';
  var cc = "another_person@company.com";
  var bcc = "yet_another_person@company.com";
  var subject = "����";
  var body = "��������"+escape("\n\t")+"��Ȩ"
  var doc = "mailto:" + to + "?cc=" + cc + "&bcc=" + bcc + "&subject=" + subject + "&body=" + body; 
  window.location = doc;
</script>

</body>
</html>