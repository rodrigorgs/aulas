{% capture source_file_path %}mobile/problems/flutter_aulas/draft/{{ include.filename }}__draft.dart{% endcapture %}
{% capture source_file %}{% include {{ source_file_path }} %}{% endcapture %}

## {{ include.filename }}

<img src="goldens/{{ include.filename }}01.png" width="300" style="border: 1px solid; margin-bottom: 10px;" onerror="this.style='display: none;'">
<img src="goldens/{{ include.filename }}02.png" width="300" style="border: 1px solid; margin-bottom: 10px;" onerror="this.style='display: none;'">
<img src="goldens/{{ include.filename }}03.png" width="300" style="border: 1px solid; margin-bottom: 10px;" onerror="this.style='display: none;'">

<textarea class="code lang-flutter" data-filename="flutter_aulas/lib/{{ include.filename }}.dart">{{ source_file | escape }}
</textarea>

<div class="testcode">
{% capture test_file_path %}mobile/problems/flutter_aulas/test/{{ include.filename }}_test.dart{% endcapture %}
{% capture included_content %}
  {% include {{ test_file_path}} %}
{% endcapture %}
{{ included_content | escape }}
</div>