# This state file will install the Bouncary.com bprobe
# client and register it to your account

get_bprobe_src:
  cmd.run:
    - name: curl -3 -s https://app.boundary.com/assets/downloads/setup_meter.sh > /tmp/setup_meter.sh
    - cwd: /tmp
    - unless: test -e /tmp/setup_meter.sh

set_perms:
  cmd.run:
    - name: chmod +x /tmp/setup_meter.sh
    - cwd: /tmp
    - unless: test -x /tmp/setup_meter.sh
    - require:
      - cmd: get_bprobe_src

setup_bprobe:
  cmd.run:
    - name: /tmp/setup_meter.sh -d -i {{ salt['pillar.get']('bprobe.creds', '') }}
    - cwd: /tmp
    - require:
      - cmd: set_perms
    - unless: which bprobe
