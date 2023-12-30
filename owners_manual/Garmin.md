## Garmin
```mermaid

flowchart-elk TB

classDef N2K fill:black
classDef Power stroke:yellow,fill:none

subgraph Mast
    Antenna["VHF/AIS Antenna"]
    Radar["Fantom 24 Radar"]:::Garmin
    Windvane
end

MFD["GPSMAP 8417 MFD"]:::Garmin
MFD ---|ETH| Radar

CockpitN2K[<font color=white>Helm N2K]:::N2K
Power[/N2K Power/]:::Power ---|10A| CockpitN2K
CockpitN2K --- MFD
CockpitN2K --- GMI201["GMI20"]
CockpitN2K --- GMI202["GMI20"]
CockpitN2K --- GHC20["GHC20 (Autopilot)"]
CockpitN2K --- GPS["GPS 24xd"]
CockpitN2K --- CardReader
CockpitN2K --- Radio --- AMFMAntenna["Antenna"]
CockpitN2K --- VHF
VHF --- VHFRemote["GHS11 VHF Remote"]
VHF ---|LMR400UF| AIS["AIS900"] ---|LMR400UF| Antenna


SalonN2K[<font color=white>Settee N2K]:::N2K
SalonN2K --- AIS["AIS900"]
AIS --- GPSAntenna
SalonN2K --- GND10:::Garmin ---|Nexus| Windvane
SalonN2K --- CCU
CCU ---|CCU Cable| ECU
ECU ---|Drive| Octopus
ECU ---|Feedback| RudderSensor

StarboardN2K[<font color=white>Aft Cabin N2K]:::N2K
StarboardN2K --- DST810

T1["Terminator"] === SalonN2K ===|Backbone| CockpitN2K ===|Backbone| StarboardN2K === T2["Terminator"]


```