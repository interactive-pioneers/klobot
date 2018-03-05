---
layout: page
title: Der Klobot
permalink: /about/
---

## Eine smarte Lösung um unnötige Gänge zum besetzten Klo zu vermeiden. 

Der Klobot löst ein lästiges Problem im Büro: Man muss dringend sein Geschäft erledigen, macht sich auf den Weg und muss feststellen, dass die Toilette besetzt ist. Erst nach mehreren Versuchen erwischt man einen freien Slot.

![notify me]({{ "/assets/klobot_mac_notifyme.jpg" | absolute_url }})

![notification]({{ "/assets/klobot_mac_notification.jpg" | absolute_url }})

Ein Raspberry Zero für 10,- Euro und ein Lichtsensor für 5,- dienen als Hardware. Darauf wird der Klobot installiert, der den Frei/Besetzt Status im internen Netzwerk über eine API bereitstellt.

![sensor]({{ "/assets/klobot_sensor.jpg" | absolute_url }})

Der Status (frei/besetzt) wird mittels [Arduino auf einem LED Band](https://github.com/amblicity/neopixel-nodejs) (WS2812B) visualisiert und im firmeneigenen Intranet dargestellt oder mittels Slack-Bot Integration abgerufen. Zusätzlich gibt es einen Mac-Client auf [Coca](http://kindred.one/coca/) Basis, inkl. Meldung in die Mitteilungszentrale wenn die Toilette frei wird.

Dank OpenSource und vorhandener API kann die Anwendung beliebig erweitert werden.

![development]({{ "/assets/klobot_development.jpg" | absolute_url }})

Geplante Features:

- Verknüpfung mit Smart-Keylocks
- Mehrere Toiletten überwachen
- FirstCome-FirstServe Queue bei mehreren Wartenden
- Anzeige der Warteliste im Toilettenraum
- Alarm bei zu langer Toilettennutzung
- Sensor zur Analyse der Atemluft
