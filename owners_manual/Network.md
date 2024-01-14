## Network
```mermaid
flowchart-elk

subgraph Router
	svHarmony24["svHarmony (2.4GHz)"]
	svHarmony["svHarmony (5GHz)"]
	Ethernet
end
WAN ---|PoE Port5| Router

subgraph Cerbo
	VictronUI
end
Ethernet ---|192.168.3.4| Cerbo


subgraph ha["odroid n2"]
	HomeAssistant
end
Ethernet ---|192.168.3.5| ha


subgraph MFD["Garmin"]
	svHARMONYINSTRUMENTS["svHARMONYINST (2.4GHz)"]
end
svHARMONYINSTRUMENTS --- ActiveCaptain

ha ---|zigbee| dimmers["Light Dimmers"]
svHarmony24 ---|192.168.3.x| lights["Light Controllers"]


```

## DHCP
| Device Name | Manuf | Device ID | IP | MAC | Location |
| ---- | ---- | ---- | ---- | ---- | ---- |
| router | Mikrotik |  | 192.168.3.1 |  | DIN |
| einstien (victron) | Victron |  | 192.168.3.4 | C0:61:9A:B1:12:C5 | Settee, Starboard Side |
| ha | ODroid |  | 192.168.3.5 | 00:1E:06:42:2D:E4 | DIN |
| Port Cabin Lights | Shelly | 285126 (2642214) | 192.168.3.11 | 48:3F:DA:28:51:26 | Settee, Port |
| Port Aft Lights | Shelly | D8BDD2 (14204370) | 192.168.3.12 | 58:BF:25:D8:BD:D2 | Port Engine Room |
| Starboard Cabin Lights | Shelly | 2CC680 (2934400) | 192.168.3.13 | 48:3F:DA:2C:C6:80 | Settee, Starboard Side |
| Starboard Aft Lights | Shelly | D9424F (14238287) | 192.168.3.14 | 58:BF:25:D9:42:4F | Aft Cabin |
| Salon Lights | Shelly | 16E69F (1500831) | 192.168.3.15 | 44:17:93:16:E6:9F | Salon Behind Radio |
| DHCP Pool |  |  | 192.168.3.20-254 |  |  |
## Software

```mermaid
flowchart-elk

subgraph cerbo
	subgraph venus["Venus OS"]
		vui["VictronUI"]
	end
end
venus --- vrm["Victron Cloud (VRM)"]

subgraph odroid["odroid n2"]
	subgraph haos["Home Assistant OS"]
		subgraph ha["Home Assistant"]
			haui["HomeAssistantUI"]
			subgraph integrations
				shelly
				zigbee
				ble
				LightBlueprint
			end
		end
	end
end

subgraph MFD["Garmin"]
	N2K
	WiFi
end


zigbee ---|zigbee| dimmers["Light Dimmers"]
shelly ---|wifi| lights

ble ---|BLE| Ruuvi
ble ---|BLE| Govee

subgraph mobile["Mobile Device"]
	browser --- haui
	browser --- vui

	ac["Active Captain"] --- WiFi
end

browser --- vrm

```