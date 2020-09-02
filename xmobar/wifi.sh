#!/bin/sh

iwconfig wlan0 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}
RX=`iw dev wlp2s0 link | grep -o "RX: \S*" | cut -d ' ' -f 2`
TX=`iw dev wlp2s0 link | grep -o "TX: \S*" | cut -d ' ' -f 2`

sleep 0.5

rrX=`iw dev wlp2s0 link | grep -o "RX: \S*" | cut -d ' ' -f 2`
ttX=`iw dev wlp2s0 link | grep -o "TX: \S*" | cut -d ' ' -f 2`

essid=`iw dev | grep -o "ssid \S*" | cut -d ' ' -f 2`
stngth=`iwconfig wlp2s0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
bars=`expr $stngth / 10`
inputTraffic=`echo "scale=2;$(( $RX )) / 1024 / 1024" | bc`
outTraffic=`echo "scale=2;$(( $TX )) / 1024 / 1024" | bc`

case $bars in
  0)  bar='----------' ;;
  1)  bar='/---------' ;;
  2)  bar='//--------' ;;
  3)  bar='///-------' ;;
  4)  bar='////------' ;;
  5)  bar='/////-----' ;;
  6)  bar='//////----' ;;
  7)  bar='///////---' ;;
  8)  bar='////////--' ;;
  9)  bar='/////////-' ;;
  10) bar='//////////' ;;
  *)  bar='----!!----' ;;
esac

printf "$essid: $bar"

exit 0
