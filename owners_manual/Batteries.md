## Batteries

Harmony has 2 power buses each with different battery chemistry.

```mermaid

flowchart-elk
  
Victron --- OrionDCDC
OrionDCDC ---|30A| AGM
  
subgraph house["House Batteries (LiFePO4)"]
  Battery1 ---|500A| Victron
  Battery2 ---|500A| Victron
  Battery1 --- Battery2
  Wakespeed --- Alternator ---|150A| Victron
end
Battery2 ---|VE.BUS| Victron

subgraph engine["Engine Start Batteries (AGM)"]
  AGM --- Starter --- Engine
end
Engine --- Relay --- Wakespeed

```
  
### House Batteries
The main house batteries are 2x 6kWh LiFEPO4 packs connected in parallel.  They were manufactured by BlueNova. Each pack has an internal BMS, high current disconnect, and a 500A fuse. Each pack has 8x Winston LiFeYPO4 cells wired in 2P4S. They use active top balancing to monitor and maintain internal cells. Pack health can be monitored on the Victron Touch display or in more detail on a small display in the back of each pack. Next to the small display is a BMS on/off switch and a push button to toggle display functions.

Each pack can operate independently but will coordinate via CAN if connected. When two packs are connected, one acts as the primary BMS. The BMS connects to the Victron system via VE.BUS CAN bus using the RV-C protocol. Vicron will see both batteries as a single large pack. The BMS controls charge voltage and currents. Victron is configured to use the BMS as a DVCC source.

| Specifications |   |
|---|---|
| Manufacturer | Blue Nova ^[https://www.bluenova.co.za/contact-us/]   |
| Model | BN13V-160-6K | 
| Voltage | 12V |
| Size | 6kWh |
| Qty | 2 |
| Fuse | 500A |
| Network | CAN 250kbps |
| Purchased | 8/1/2017 |

### Engine Start Batteries
The engines each have a separate 100Ah AGM (LA) battery. Victron Orion DCDC chargers charge the engine start batteries. 

| Specifications |  |
| ---- | ---- |
| Brand | Duracell |
| Model | SL34MAGM |
| V | 12VDC |
| Ah | 55 |
| Size | Group 34 |
| CCA | 750 |
| MCA | 860 |

The alternators charge the LiFePO4 batteries directly and are isolated from the engine  batteries (common ground, isolated V+). A relay powers the charge regulator from the LiFePO4 batteries when the engine is on. The 2 buses must be kept separate.
