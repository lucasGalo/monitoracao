## Docker 
## Container create example:
1. **Create work directories:**
    ```bash
    mkdir -p /opt/traccar/logs
    ```

1. **Get default traccar.xml:**
    ```bash
    docker run \
    --rm \
    --entrypoint cat \
    traccar/traccar:latest \
    /opt/traccar/conf/traccar.xml > /opt/traccar/traccar.xml
    ```

1. **Edit traccar.xml:** <https://www.traccar.org/configuration-file/>

1. **Create container:**
    ```bash
    docker run \
    --name traccar \
    --hostname traccar \
    --detach --restart unless-stopped \
    --publish 80:8082 \
    --publish 5000-5150:5000-5150 \
    --publish 5000-5150:5000-5150/udp \
    --volume /opt/traccar/logs:/opt/traccar/logs:rw \
    --volume /opt/traccar/traccar.xml:/opt/traccar/conf/traccar.xml:ro \
    traccar/traccar:latest
    ```


# [Traccar](https://www.traccar.org)

## Overview

Traccar is an open source GPS tracking system. This repository contains Java-based back-end service. It supports more than 200 GPS protocols and more than 2000 models of GPS tracking devices. Traccar can be used with any major SQL database system. It also provides easy to use [REST API](https://www.traccar.org/traccar-api/).

Other parts of Traccar solution include:

- [Traccar web app](https://github.com/traccar/traccar-web)
- [Traccar Manager Android app](https://github.com/traccar/traccar-manager-android)
- [Traccar Manager iOS app](https://github.com/traccar/traccar-manager-ios)

There is also a set of mobile apps that you can use for tracking mobile devices:

- [Traccar Client Android app](https://github.com/traccar/traccar-client-android)
- [Traccar Client iOS app](https://github.com/traccar/traccar-client-ios)

## Features

Some of the available features include:

- Real-time GPS tracking
- Driver behaviour monitoring
- Detailed and summary reports
- Geofencing functionality
- Alarms and notifications
- Account and device management
- Email and SMS support

## Build

Please read [build from source documentation](https://www.traccar.org/build/) on the official website.

## Team

- Anton Tananaev ([anton@traccar.org](mailto:anton@traccar.org))
- Andrey Kunitsyn ([andrey@traccar.org](mailto:andrey@traccar.org))

## License

    Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
