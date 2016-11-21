#!/bin/bash
docker exec -it kdockphp7_php_1 php -dxdebug.remote_enable=1 -dxdebug.remote_mode=req -dxdebug.remote_port=9000 -dxdebug.remote_host=172.17.0.1 -dxdebug.remote_connect_back=1 -dxdebug.remote_handler=dbgp -dxdebug.remote_autostart=1 -dxdebug.idekey=PHPSTORM /var/dispatch/bin/console worker:run -v
