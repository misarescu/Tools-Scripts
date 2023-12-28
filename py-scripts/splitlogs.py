# Requires pyyaml

import os
import yaml

run = os.system
new_window = lambda cmd: run('tmux new-window -n "logs" "{}"'.format(cmd))
split_window = lambda cmd: run('tmux split-window "{}"'.format(cmd))
tile_panes = lambda: run('tmux select-layout tiled')

if __name__ == '__main__':
    try:
        config_text = open('docker-compose.yaml').read()
    except IOError:
        config_text = open('docker-compose.yml').read()

    config = yaml.load(config_text, Loader=yaml.SafeLoader)

    services = list(config['services'].keys())
    new_window('docker compose logs -f {}'.format(services[0]))

    for service in services[1:]:
        split_window('docker compose logs -f {}'.format(service))

    tile_panes()