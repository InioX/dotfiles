import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property var data: ({
        uv: 0,
        humidity: 0,
        sunrise: 0,
        sunset: 0,
        windDir: 0,
        wCode: 0,
        city: 0,
        wind: 0,
        precip: 0,
        visib: 0,
        press: 0,
        temp: 0,
        tempFeelsLike: 0,
        lastRefresh: 0,
        wCode: "113"
    })

    property string city: "Ostrava"
    property int fetchInterval: 60 * 60 * 1000

    property var icon: weatherMap[data.wCode]
    readonly property var weatherMap: {
        "0": {
            "icon": "\uf0599",
            "label": "Clear"
        },
        "1": {
            "icon": "\uf0595",
            "label": "Mostly Clear"
        },
        "2": {
            "icon": "\uf0595",
            "label": "Partly Cloudy"
        },
        "3": {
            "icon": "\uf0591",
            "label": "Overcast"
        },
        "45": {
            "icon": "\uf0214",
            "label": "Foggy"
        },
        "48": {
            "icon": "\uf0214",
            "label": "Rime Fog"
        },
        "51": {
            "icon": "\uf0596",
            "label": "Light Drizzle"
        },
        "61": {
            "icon": "\uf059a",
            "label": "Rain"
        },
        "71": {
            "icon": "\uf059b",
            "label": "Snow"
        },
        "80": {
            "icon": "\uf0598",
            "label": "Rain Showers"
        },
        "95": {
            "icon": "\uf0597",
            "label": "Thunderstorm"
        }
    }

    function refineData(data) {
        let temp = {};
        temp.uv = data?.current?.uvIndex || 0;
        temp.humidity = (data?.current?.humidity || 0) + "%";
        temp.sunrise = data?.astronomy?.sunrise || "0.0";
        temp.sunset = data?.astronomy?.sunset || "0.0";
        temp.windDir = data?.current?.winddir16Point || "N";
        temp.wCode = data?.current?.weatherCode || "113";
        temp.city = data?.location?.areaName[0]?.value || "City";
        temp.temp = "";
        temp.tempFeelsLike = "";
        temp.wind = (data?.current?.windspeedKmph || 0) + " km/h";
        temp.precip = (data?.current?.precipMM || 0) + " mm";
        temp.visib = (data?.current?.visibility || 0) + " km";
        temp.press = (data?.current?.pressure || 0) + " hPa";
        temp.temp += (data?.current?.temp_C || 0);
        temp.tempFeelsLike += (data?.current?.FeelsLikeC || 0);
        temp.temp += "°C";
        temp.tempFeelsLike += "°C";
        // temp.lastRefresh = DateTime.time + " • " + DateTime.date;
        root.data = temp;
    }

    function getData() {
        let command = "curl -s wttr.in";

        command += `/${root.city}`;

        // format as json
        command += "?format=j1";
        command += " | ";
        // only take the current weather, location, asytronmy data
        command += "jq '{current: .current_condition[0], location: .nearest_area[0], astronomy: .weather[0].astronomy[0]}'";
        fetcher.command[2] = command;
        fetcher.running = true;
    }

    Process {
        // console.info(`[ data: ${JSON.stringify(parsedData)}`);

        id: fetcher

        command: ["bash", "-c", ""]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                if (text.length === 0)
                    return ;

                try {
                    const parsedData = JSON.parse(text);
                    root.refineData(parsedData);
                } catch (e) {
                    console.error(`[WeatherService] ${e.message}`);
                }
            }
        }

    }

    Timer {
        running: true
        repeat: true
        interval: root.fetchInterval
        triggeredOnStart: true
        onTriggered: root.getData()
    }

}
