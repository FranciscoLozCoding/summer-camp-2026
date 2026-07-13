# Weather Station System Setup

## Overview

This guide explains how to set up a weather station using an industrial Raspberry Pi and supporting hardware to access weather data from ANL — including atmospheric temperature, pressure, humidity, wind speed, wind direction, and precipitation.

> **Note:** <!-- TODO: Fill in any prerequisites or important notes here before publishing (e.g., "Ensure you have SSH access to the Sage Thor node before starting.") -->

---

## Hardware Required

- IND 90W BT PoE Splitter (POE-SP02BTV)
- Industrial Raspberry Pi CM4 (ED-IPC2400)
- GbE 90W PoE++ Injector (POE-IN9001U)
- 2.5MM DC Plug to Free End 1000MM cable
- Access to a Sage Thor node
- ES-642 Remote Dust Monitor — measures: Particulate Concentration, Sample Relative Humidity, Ambient Barometric Pressure, Sample Temperature, Volumetric Flow Rate, and System Status Flags
- Lever wire connectors (optional but recommended)

---

## System Architecture

<img width="1920" height="1500" alt="System Architecture Diagram" src="https://github.com/user-attachments/assets/6c17cc54-9f8c-43af-a884-2938d233a5d2" />

---

## Part 1 — Connecting the RPi to the Weather Sensor

This section covers how to physically connect and wire all devices so they can communicate with each other before connecting to the Sage blades.

### Step 0 — Connect All Devices

Follow the system architecture diagram above for reference throughout this section.

**0.1.** Plug an ethernet cable from the Blade (Thor Rack) into the **Data In** port of the PoE Injector (POE-IN9001U).

**0.2.** Plug a CAT6 or higher ethernet cable from the PoE Injector's **Data Out** port into the **BT PoE Input** port of the PoE++ Splitter (POE-SP02BTV).

**0.3.** Connect the PoE++ Splitter's **Data Output** port to the ethernet port on the Industrial RPi (ED-IPC2400) using an RJ45 ethernet cable.

**0.4.** To power the Industrial RPi (ED-IPC2400):
   - Use the 2.5MM DC Plug to Free End cable.
   - Wire the **positive** and **negative** leads to the **Dual DC Outputs** — specifically the **3–36V DC Output** side.
   - Use the adjustment screw to the right of the output to set the voltage to **24V**.
   - Plug the DC connector end into the **DC In** port on the Industrial RPi.

**0.5.** To connect the RPi to the ES-642 weather sensor, locate the external cable (part number 80959) and strip the following wires:
   - **Red** — Power Input, 11–40 VDC (Pin 1)
   - **Black** — Ground (Pin 2)
   - **White** — RS-485 TX+/RX+ (Pin 3)
   - **Green** — RS-485 TX−/RX− (Pin 4)
   - **Orange** — Ground (Pin 5)
   - **Blue** — Ground (Pin 6)

<!-- QUESTION: How much should participants strip from each wire? A length (e.g., ~5mm) would help avoid under/over-stripping. -->

**0.6.** Using the RPi's Phoenix connector ports:
   - Connect the **White** wire to port **A4**.
   - Connect the **Green** wire to port **B4**.

**0.7.** Bundle the **Black**, **Orange**, and **Blue** wires together into a lever wire connector. Run a single black wire out of the connector and into the **24V DC Out Negative** port on the PoE++ Splitter.

**0.8.** Run a blue wire out of the lever wire connector into the **GND port** (located below B4) on the RPi using the Phoenix connector ports.

**0.9.** Connect the **Red** wire from the external cable (part number 80959) into the **24V DC Out Positive** port on the PoE++ Splitter.

Completed wiring should look like this:

<img width="2268" height="4032" alt="Wiring photo" src="https://github.com/user-attachments/assets/6164b190-ce08-4358-95df-1a681d5bef08" />

---

## Part 2 — Flashing and Configuring the Industrial RPi

### Step 1 — Flash the Industrial RPi (ED-IPC2400)

**1.1.** Flash the eMMC by following **Section 6.2 — Flashing to eMMC** in the ED-IPC2400 User Manual (page 27):

[ED-IPC2400 User Manual (PDF)](https://edatec.cn/docs/assets/ipc2400/ED-IPC2400-usermanual-en.pdf)

<img width="783" height="497" alt="Section 6.2 screenshot" src="https://github.com/user-attachments/assets/75809145-e651-4d7c-8903-8d127c73df7e" />

**1.2.** Install the firmware package by following **Section 6.3 — Installing Firmware Package** in the same manual (page 30):

<img width="789" height="420" alt="Section 6.3 screenshot" src="https://github.com/user-attachments/assets/55996ecd-69e0-4f8a-a8bf-0287285abc11" />

**1.3.** Install `picocom` to enable serial communication between the RPi and the weather sensor:

```bash
sudo apt-get install picocom
```

**1.4.** Test the serial connection by running:

```bash
picocom -b 9600 /dev/com4
```

<!-- FLAG: `/dev/com4` is unusual on Linux — serial ports are typically `/dev/ttyS0`, `/dev/ttyUSB0`, or `/dev/ttyAMA0`. This may be correct for the ED-IPC2400's specific port naming, but worth double-checking before participants run into errors. -->

A successful connection should look like this:

<img width="994" height="580" alt="Picocom connection screenshot" src="https://github.com/user-attachments/assets/6362a947-da1e-4e9c-b1fa-5a2f0e723ead" />

---

## Part 3 — Communicating Between the RPi and the Sage Blade

This section covers configuring the RPi to expose the weather sensor's serial data over the network so the Sage blade can read it.

### Step 2 — Configure ser2net on the RPi

**2.1.** Install `ser2net` on the RPi:

```bash
sudo apt update
sudo apt install ser2net
```

**2.2.** Open the `ser2net` configuration file:

```bash
sudo nano /etc/ser2net.yaml
```

**2.3.** Add the following connection profile to the bottom of the file. This defines the network accepter (the TCP port other devices connect to) and the serial connector (the physical port the sensor is on):

```yaml
connection: &met_one_sensor
    accepter: tcp,4000
    connector: serialdev,/dev/com4,9600N81,local
    options:
        kickolduser: true
```

> **Note:** Make sure port `4000` is not already in use on the RPi before adding this. You can use a different port number if needed.

**2.4.** Save and exit the file (`Ctrl+X`, then `Y`, then `Enter`), then restart the `ser2net` service to apply the changes:

```bash
sudo systemctl restart ser2net
```

**2.5.** Confirm the port is open and listening:

```bash
sudo ss -ltpn | grep 4000
```

<!-- QUESTION: What should the output of this command look like when it's working correctly? Adding an example output here (similar to the picocom screenshot) would help participants know whether their setup succeeded. -->

---

*More steps coming — work in progress.*
