#!/bin/bash

# run `pacmd list-sinks  | grep '\(name:\|alias\)'` and fill with value from alias of your bluetooth device
BLUETOOTH_DEVICE="Major Tom"
PROFILE_A2DP="a2dp_sink"
PROFILE_HEADSET_UNIT="handsfree_head_unit"

####  Restart Bluetooth
if [ "${1}" == "reset" ] ; then
  sudo rfkill block bluetooth && sleep 0.1 && sudo rfkill unblock bluetooth;
  exit;
fi;

sink_name() {
    pacmd list-sinks  | grep '\(name:\|alias\)' | grep -B1 "${1}"  | head -1 | sed -rn 's/\s*name: <(.*?)>/\1/p'
}

card_name() {
    pacmd list-cards | grep 'name:' | grep "bluez" | sed -rn 's/\s*name: <(.*?)>/\1/p'
}

#### Toggle listen/speak
if [ "${1}" == "" -o "${1}" == "toggle" ] ; then
  SINK_NAME=$(sink_name "${BLUETOOTH_DEVICE}")
 
  if [ "${SINK_NAME}" == "" ] ; then echo "${BLUETOOTH_DEVICE} headset not found."; ${0} reset; sleep 2; exit; fi

  if $(echo "${SINK_NAME}" | grep "${PROFILE_A2DP}" &> /dev/null) ; then
    echo "Detected quality sound output, that means we can't speak; switch that."
    ${0} speak;
  else
    echo "Quality sound not found, switch to the good sound."
    ${0} listen;
  fi
fi

#### Change the output to F5A
if [ "${1}" == "listen" ] ; then
  SINK_NAME=$(sink_name "${BLUETOOTH_DEVICE}")
  if [ "${SINK_NAME}" == "" ] ; then echo "${BLUETOOTH_DEVICE} headset not found."; ${0} reset; sleep 2; exit; fi
  
  ## Switch the output to that.
  echo "Switching audio output to ${SINK_NAME}";
  pacmd set-default-sink "${SINK_NAME}"

  #### Change profile to quality output + no mic.:
  CARD=$(card_name)
  echo "Switching audio profile to ${PROFILE_A2DP}";
  pacmd set-card-profile "${CARD}" "${PROFILE_A2DP}"
  exit;
fi;

#### Input
if [ "${1}" == "speak" ] ; then
  ## Change profile to crappy output + mic.:
  CARD=$(card_name)
  pacmd set-card-profile "${CARD}" "${PROFILE_HEADSET_UNIT}"

  SOURCE_NAME=$(sink_name "${BLUETOOTH_DEVICE}")
  if [ "${SOURCE_NAME}" == "" ] ; then echo "${BLUETOOTH_DEVICE} mic not found."; ${0} reset; sleep 2; exit; fi
  echo "Switching audio input to ${SOURCE_NAME}";
  pacmd set-default-source "${SOURCE_NAME}.monitor" || echo 'Try `pacmd list-sources`.';
fi;
