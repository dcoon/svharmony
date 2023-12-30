## Victron
The Batteries and Victron components are controlled by the Cerbo GX and Blue Nova BMS. The Cerbo uses DVCC to allow the BMS to control (dis)charge voltage and current. Battery measurements (SoC, SoH, V, I, Temp, etc) are provided by the BMS. 

The LynxPower has no monitoring circutry and only serves to combine the high current cables of both batteries. The LynxShunt connects to the Cerbo via VE.CAN. It reports it's measurements but is otherwise disable. The first 2 LynxDistro units connect to the Cerbo via RJ11 serial cable. More information is provided in the DC Power Distribution section.

The Quattro charge  profile is controlled by DVCC. It is configured in AES energy saving mode. If inverter load is very light, it will turn on and off every few seconds. The AC breaker panel leds will blink. 

The isolation transformer is configured to auto sense incoming voltage and convert to 230VAC. It does not convert frequence. All current AC equipment works with 60Hz. In practice, incoming shorepower is increased slightly to account for voltage loss in shore power cabling. When connected to 50A 240VAC service, incoming voltage may be as high as 250VAC. Make sure any new equipment is safe at that voltage.

The Cerbo is configured to publish its info to an MQTT server for integration with SignalK and Home Assistant. More details are under [Network](Network.md). It has a wired ethernet connection to the router for VRM and update access.  

The Wakespeed WS500s report information on the VE.CAN bus but do not follow DVCC. They are configured with independent voltage and current sensors and use a conservative LiFePO4 charge profile. They will slave to each other when both engines are on.

The Orion DCDC chargers do not integrate with the Cerbo.  Use Victron Connect via Bluetooth to monitor and configure. There is a physical jumper in the bottom of each unit. Pull out the jumper to temporarily disable the Orion.

```mermaid

flowchart-elk TB

classDef Victron stroke:blue

subgraph Distro["Lynx Distro"]
	LynxPower:::Victron --- LynxShunt:::Victron ---|500A| LynxDistro1:::Victron --- LynxDistro2:::Victron ---|X| LynxDistro3:::Victron
	VECANT1{{"Term"}} ---|VE.CAN| LynxShunt
end
Battery1 ---|500A| LynxPower
Battery2 ---|500A| LynxPower

Battery1 ---|VE.BMS| Battery2 ---|VE.BMS| Cerbo:::Victron

LynxDistro1 ---|RJ11| LynxDistro2 ---|RJ11| Cerbo
Touch50:::Victron ---|HDMI| Cerbo
Touch50:::Victron ---|USB| Cerbo
Cerbo ---|VE.Bus| Quattro:::Victron ---|230VAC| IsolationTransformer:::Victron --- ShorePower
Cerbo ---|VE.Direct| MPPT1:::Victron --- SolarPT
Cerbo ---|VE.Direct| MPPT2:::Victron --- SolarSB
LynxShunt ---|VE.CAN| Cerbo ---|VE.CAN| WS500SB ---|WS.CAN| WS500PT ---|WS.CAN| VECANT2{{"Term"}}
Cerbo ---|Ethernet| Router
Cerbo ---|USB| GXTank:::Victron
GXTank --- Water["Water PT/SB"]
GXTank --- Fuel["Fuel PT/SB"]

subgraph engines
    LynxDistro3 --- OrionDCDC["Orion DCDC
    Bluetooth Only"]
end

```
 
