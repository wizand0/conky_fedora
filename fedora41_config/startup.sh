#!/bin/bash

# Функция, которая проверяет состояние дисплея (например, используя xrandr)
function wait_for_displays() {
  # Здесь можно добавить логику, чтобы удостовериться, что xrandr вернул корректный список подключённых мониторов
  while true; do
    if xrandr | grep " connected" | grep -q "HDMI"; then
      break
    fi
    sleep 1
  done
}

wait_for_displays

#sleep 7

# Kill all running Conky instances
killall -q conky

# Wait until all processes have been shut down
while pgrep -x conky >/dev/null; do sleep 3; done

# Start new Conky instances
conky -c /home/andrey/.conky/fedora41_config/conky.conf &
conky -c /home/andrey/.conky/fedora41_config/sys-tray.conf &
conky -c /home/andrey/.conky/fedora41_config/weather.conf &
conky -c /home/andrey/.conky/fedora41_config/network.conf &

# Print success message
echo "✅ Conky started successfully!"
