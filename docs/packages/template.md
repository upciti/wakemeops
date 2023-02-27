{%- set package = repository.packages.get(title) -%}
{%- set site_url = config.site_url -%}

__{{ package.summary[0]|upper}}{{package.summary[1:] }}__

{{ package.description|replace("\n.\n", "\n\n") }}

:material-format-section: [`{{ package.component }}`](/packages/#{{ package.component }})

:material-home: [{{ package.homepage }}]({{ package.homepage }})

:material-chip: {% for arch in package.versions[package.latest_version] %}<span class="badge arch">{{ arch }}</span> {% endfor %}

## Installation

1\. Add WakeMeOps repository

```shell
curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash
```

2\. Install {{ package.name }}

```shell
sudo apt install {{ package.name }}
```

{% if package.component != "desktop" -%}
## Snippets

=== "Dockerfile"

    ```docker
    FROM wakemeops/minideb:bullseye

    RUN install_packages \
        {{ package.name }}={{ package.latest_version }}*

    USER 1001
    ```

=== "Github Action"

    ```yaml
    - name: Install dependencies
      uses: upciti/wakemeops-action@v1
      with:
        packages: |
          {{ package.name }}={{ package.latest_version }}*
    ```
{% endif -%}

## Download

{% for arch, files in package.files.items() %}
=== "{{arch}}"
    | Version | SHA256 | Size (KB) |
    | ------- | ------ | ---- |
    {% for file in files[:10] -%}
    | [{{file.version}}]({{file.url}}) | `{{file.sha256}}` | {{file.size}} |
    {% endfor %}
{% endfor %}

## Badge

[![WakeMeOps](/badges/{{ package.name }}.svg)](/packages/{{ package.name }})

=== "Markdown"
    ```markdown
    [![WakeMeOps]({{ site_url }}badges/{{ package.name }}.svg)]({{ site_url }}packages/{{ package.name }})
    ```

=== "HTML"
    ```html
    <a href="{{ site_url }}packages/{{ package.name }}">
      <img src="{{ site_url }}badges/{{ package.name }}.svg"/>
    </a>
    ```

=== "RST"
    ```rst
    .. image:: {{ site_url }}badges/{{ package.name }}.svg
    :target: {{ site_url }}packages/{{ package.name }}
    ```
