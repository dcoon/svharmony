## Power Distribution

  ```mermaid
  
  flowchart-elk TB
  
  subgraph HouseBank
  
  Battery1["LiFePO4 1"] ---|500A| LynxPower
  
  Battery2["LiFePO4 2"] ---|500A| LynxPower
  
  end
  
  subgraph Distro1["Lynx Distro 1"]
  
  Fuse1-1[120A] --- Windlass
  
  Fuse1-2[40A] --- Cerbo
  
  Fuse1-3[120A] --- Winch
  
  Fuse1-4[300A] --- ChargerFuse
  
  end
  
  subgraph Distro2["Lynx Distro 2"]
  
  Fuse2-1[40A] --- MPPT2
  
  Fuse2-2[40A] --- MPPT1
  
  Fuse2-3[40A] --- Watermaker
  
  Fuse2-4[400A] --- Distro3Fuse
  
  end
  
  subgraph ShorePower
  
  AC-IN --- Quattro
  
  end
  
  ChargerFuse --- Quattro
  
  subgraph DistroNavDesk["Lynx Distro 3 (Under NavDesk)"]
  
  FuseND-2[250A]
  
  FuseND-1[250A]
  
  FuseND-3[120A]
  
  end
  
  Distro3Fuse --- DistroNavDesk
  
  subgraph PortEngine
  
  PortPowerBus ---|40A| OrionDCDC --- PortStartBattery["AGM Start Battery"]
  
  PortPowerBus ---|40A| EngineOnRelay ---|5A| WS500
  
  WS500 ---|5A| Alternator((Alternator)) --- FuseAlt[150A] --- PortPowerBus
  
  end
  
  subgraph StarboardEngine
  
  StarboardPowerBus[/Same As Port/]
  
  end
  
  subgraph DIN
  
  HouseMain[120A TB] --- BreakerPanel[Distribution Panel]
  
  end
  
  LynxPower --- LynxShunt ---|500A| Distro1 --- Distro2
  
  FuseND-2 --- StarboardPowerBus
  
  FuseND-1 --- PortPowerBus
  
  FuseND-3 --- DIN
  ```
  
### Primary Fusing
  The LiFePO4 batteries each have integrated BMS, contactor switch, and 500A class T fuses. The batteries are software limited to 400A each. The LynxPower combines both batteries to the primary house bus. The LynxShunt contains an additional 500A class T fuse. 
  
  Each LynxDistro (3 total) contains 4x Mega fuses feeding high current branch circuits. Spare fuses are located in the starboard lounge locker. A blown Mega fuse will be indicated by an alarm on the Victron touch display and a red (vs green) led on the affected Distro unit.
### Secondary Fusing
  Each high current branch circuit may be further branched into lower current circuits. Those circuits are fed from either a breaker in the distribution panel or a fuse block with ATC fuses protecting each circuit. The locations and amperages of the ATC fuse blocks are documented below.
### Bonding
  Sintered bronze bonding plates are located on the outer side of each hull. The plates are connected to the negative busbar in each engine room. The busbar, engine, shaft, and prop are electrically bonded. There are 30mm id shaft zincs on each shaft.
### DIN Rail
  High current appliances (Quattro, Windlass, Winch, Watermaker) are terminated directly to the Lynx Distro units. Lower current devices are terminated to a 35mm DIN rail located just forward of the navigation desk. DC power is fed from Distro 3 with a 150A Mega fuse, followed by a 120A thermal breaker on the DIN rail, then to a BEP millennium distribution panel. Breakers in the distribution panel then feed back to circuits on the DIN rail.  A key for the DIN rail is in the appendices.
### Breaker Panel
  The distribution panel has 44 breakers. Breakers are arranged in 3 columns, roughly left to right are Port, Salon, and Starboard devices with a few exceptions. A key to breaker numbering and amperage ratings is in the appendices.