# STMF - Stomach Fullness Monitoring Device 🩺  
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)  
![MATLAB](https://img.shields.io/badge/MATLAB-2023b-orange)  
![STM32](https://img.shields.io/badge/STM32-H743VGT6-green)  

A low-cost, non-invasive device using **Electric Impedance Tomography (EIT)** to monitor stomach fullness in real time. Developed for the MIE491Y Capstone Design at the University of Toronto.  

## 📚 Overview  
This project addresses overeating by providing real-time gastric volume feedback. The system combines a **16-electrode array**, an STM32 microcontroller, and MATLAB-based software to reconstruct impedance images and estimate stomach fullness.  
![image](https://github.com/user-attachments/assets/c82036b6-210f-451b-b72d-6ec92d7d3aef)

Key Specifications:  
- **Safety**: <50V, <10mA, ≤44°C  
- **Response Time**: <5 minutes  
- **Cost**: <$1000 CAD  

## ✨ Key Features  
- Real-time impedance imaging  
- MATLAB GUI for visualization  
- Phantom tank validation  
- Custom PCB with STM32H743  
- EIDORS-based reconstruction  

## 🔌 Hardware Setup  
### Components  
- STM32H743VGT6 Microcontroller  
- 3x ADG1206YRUZ multiplexers  
- 16 copper electrodes  
- ±7.5V DC power supply
![image](https://github.com/user-attachments/assets/6b0cb6f9-ac30-4e3e-ab7d-3b5fcb600f6e)


### Wiring  
1. Connect electrodes to PCB (J1-J16)  
2. Power the PCB:  
   - VCC A → +7.5V  
   - VEE A → -7.5V  
   - GND → Power supply ground  

## 💻 Software Installation  
![image](https://github.com/user-attachments/assets/33e15ceb-0202-4ae9-a82e-ecd665834c18)

1. Install:  
   - MATLAB 2023b  
   - [EIDORS Toolbox](https://eidors3d.sourceforge.net)  
   - [STM32 VCP Driver](https://www.st.com/en/development-tools/stsw-stm32102.html)  
2. Run GUI:  
   ```matlab
   cd Software/EIT_GUI
   open EIT.mlapp
   ```
   ![image](https://github.com/user-attachments/assets/1b15a36a-30bb-4d8f-9830-440b9d3840e2)


## 🚀 Usage  
1. Calibrate with `Acquire Uniform Field`  
2. Capture data with `Acquire Once`  
3. Reconstruct images using:  
   - `phantom_test.m` (phantom tank)
   ![image](https://github.com/user-attachments/assets/0548a2c2-5455-41bc-b6ca-53a3e16b4298)

   - `stomach_eit.m` (human trials)
   ![image](https://github.com/user-attachments/assets/f7cd66e0-945a-4b41-a2c9-b3f6da3cb526)


## 📊 Results  
| Fullness (%) | Conductivity (μS/m) |
|--------------|----------------------|
| 0            | 1.19E-05            |
| 50           | 1.22E-05            |
| 100          | 1.26E-05            |


## 🐜 License  
MIT License

