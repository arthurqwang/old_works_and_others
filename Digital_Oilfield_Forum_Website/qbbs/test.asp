<html>
<body>

<script language='javascript'>

  var to = 'person@company.com';
  var cc = "another_person@company.com";
  var bcc = "yet_another_person@company.com";
  var subject = "大庆";
  var body = "大庆油田"+escape("\n\t")+"王权"
  var doc = "mailto:" + to + "?cc=" + cc + "&bcc=" + bcc + "&subject=" + subject + "&body=" + body; 
  window.location = doc;
</script>

</body>
</html>