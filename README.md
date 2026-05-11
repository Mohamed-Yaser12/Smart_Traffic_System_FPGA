# Smart_Traffic_System_FPGA



## 🧠 Project Overview
This project is a Smart Traffic Management System developed using VHDL and implemented on a Basys 3 FPGA board. It simulates a 4-way traffic intersection with intelligent control over vehicle and pedestrian signals to optimize traffic flow and enhance safety. The system detects red-light violations, monitors environmental conditions, and manages high-voltage traffic lights via relays.

<img width="1245" height="661" alt="Screen1" src="https://github.com/user-attachments/assets/a8e90c83-6960-4d90-8c16-f9ba6fd8ea71" />

## 🔧 System Features

### 🚦 Traffic Light Control
* The system controls four main vehicular traffic lights (Red, Yellow, Green) and four pedestrian-specific lights.
* Traffic signals are designed following the German Traffic System.
* All signals are synchronized to avoid car-pedestrian conflict, with timed logic ensuring safe transitions (e.g., 10s green, 3s yellow).

### 📏 Violation Detection (Ultrasonic & Buzzer)
* Four ultrasonic sensors (HC-SR04) are positioned at the intersection to detect vehicle presence and movement.
* If a vehicle is detected crossing during a red light, an alarm buzzer is triggered to alert of the traffic violation.

### 🌡️ Environmental Monitoring
* A DHT11 temperature sensor is integrated to monitor ambient environmental conditions.
* Real-time temperature readings are displayed on the FPGA's 7-segment display, while an LCD display provides additional feedback on system status.

### ⚡ Hardware & 220V Light Control
* A 220V LED system is used to simulate real-world traffic light conditions.
* The FPGA handles the low-voltage control logic, which safely interfaces with the 220V vehicle and pedestrian lights via a 2-channel 4x relay module.

## 🔌 Hardware Components Required
* BASYS3 FPGA board
* 4x Ultrasonic sensors (HC-SR04)
* DHT11 temperature sensor
* 220V red/yellow/green LEDs (8 each)
* 2-channel 4x relay module
* Buzzer for violations
* LCD Display
* Breadboard, MM/MF jumper wires, and power supply

## 🛠️ VHDL Modules
The project architecture is divided into modular VHDL components:
* `Main.vhd`: Top-level module integrating all subsystems.
* `LEDs_Control.vhd`: Controls the traffic light timing and synchronization.
* `Ultrasonic_Sensor.vhd`: Manages distance measurement and triggers alarms on violations.
* `Temp_Sensor.vhd`: Interfaces with the DHT11 sensor to extract temperature data.
* `Segment_Control.vhd`: Displays the temperature on a 4-digit 7-segment display.
* `MainTB.vhd`: Testbench for simulating the full system.

## 🏁 Future Scope
* Integration of IoT for remote traffic management and monitoring.
* Implementation of AI-based predictive models to improve traffic efficiency.
* Adding dynamic traffic light durations based on traffic density and integrating pedestrian push buttons.
* Implementing real-time logging via a serial interface and expanding to 3-lane support.
