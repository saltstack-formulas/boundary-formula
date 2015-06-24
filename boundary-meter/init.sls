# This state file will download and install the Boundary.com boundary-meter and
# connect it to your account.

{% set ent = salt['pillar.get']('boundary-meter:enterprise_api_token', '') %}
{% set prem = salt['pillar.get']('boundary-meter:premium_api_token', '') %}
{% if ent and prem %}
  {% set tokens = ent + ',' + prem %}
{% elif ent %}
  {% set tokens = ent %}
{% elif prem %}
  {% set tokens = prem %}
{% endif %}

get_meter_src:
  cmd.run:
    - name: >-
      curl -fsS \
      -d '{"token":"{{ salt['pillar.get']('boundary-meter:premium_api_token', '') }}"}' \
      -H 'Content-Type: application/json' \
      https://meter.boundary.com/setup_meter > setup_meter.sh
    - cwd: /tmp
    - unless: test -e /tmp/setup_meter.sh

set_perms:
  cmd.run:
    - name: chmod +x /tmp/setup_meter.sh
    - cwd: /tmp
    - unless: test -x /tmp/setup_meter.sh
    - require:
      - cmd: get_meter_src

setup_meter:
  cmd.run:
    - name: /tmp/setup_meter.sh -d -i {{ tokens }}
    - cwd: /tmp
    - require:
      - cmd: set_perms
    - unless: which boundary-meter
