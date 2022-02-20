---
template: package_index.html
---

# {{ repository.package_count }} packages

{% for component in repository.components.values() %}
## {{ component.name | capitalize }}

{{ component.package_count }} packages.


| Name | Summary | Version |
| ---- | ------- | ------- |
{% for package in component.packages -%}
| [{{ package.name }}](/packages/{{ package.name }}) | {{ package.summary }} | {{ package.latest_version | truncate(10) }} |
{% endfor %}

{% endfor %}
