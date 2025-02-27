# RC_Car_Project 개발 환경 및 설정 (WSL 기반)

## 개요
RC_Car_Project는 STM32F407G-DISC1과 ESP32를 활용하여 CAN 기반으로 동작하는 RC카 시스템입니다. 이 문서는 WSL 기반의 개발 환경 설정과 프로젝트 폴더 구조를 포함하여 정리합니다.

---

## 1. 개발 환경 설정
### 1.1 필수 도구 설치
RC_Car_Project 개발을 위한 필수적인 소프트웨어를 설치해야 합니다.

- **WSL2 (Ubuntu 24.04.02 LTS)**
- **VSCode (1.97.2)**: 코드 편집 및 디버깅 도구
- **GCC ARM Toolchain (STM32 및 ESP32 개별 사용)**: Bare-metal 환경에서 직접 빌드
- **OpenOCD**: 디버깅을 위한 오픈소스 도구

### 1.2 WSL2 기반 GCC Toolchain 설치
1. WSL2 Ubuntu 환경에서 [ARM GNU Toolchain](https://developer.arm.com/downloads/-/gnu-rm) 최신 버전을 다운로드합니다.
2. 환경 변수 설정:
   ```sh
   echo 'export PATH=$PATH:/opt/gcc-arm-none-eabi/bin' >> ~/.bashrc
   source ~/.bashrc
   ```
3. `arm-none-eabi-gcc --version`을 실행하여 정상 설치 여부를 확인합니다.

### 1.3 OpenOCD 설치 및 설정
1. WSL2에서 OpenOCD를 설치합니다.
   ```sh
   sudo apt install openocd
   ```
2. 보드와 PC를 USB로 연결한 후, WSL2가 USB 장치를 인식하도록 설정합니다.
   ```sh
   usbipd wsl attach --busid <BUSID>
   ```
3. `openocd -f interface/stlink.cfg -f target/stm32f4x.cfg` 명령으로 연결을 확인합니다.

---

## 2. 프로젝트 디렉토리 구조
```bash
📂 RC_Car_Project/
│── 📂 STM32F4_DISCOVERY/     → STM32 관련 코드
│   │── 📂 Core/               → 메인 코드 및 공통 유틸리티
│   │   │── main.c             → 메인 코드 (RTOS 스케줄러 실행)
│   │   │── startup_stm32.s    → 스타트업 코드 (어셈블리)
│   │   │── system_stm32f4xx.c → 시스템 초기화 코드
│   │
│   │── 📂 Drivers/            → 레지스터 기반 드라이버 코드
│   │   │── gpio_driver.c      → GPIO 드라이버 (모터 방향 제어)
│   │   │── pwm_driver.c       → PWM 드라이버 (DC 모터, 서보모터)
│   │   │── uart_driver.c      → UART 드라이버 (디버깅, BLE)
│   │   │── can_driver.c       → CAN 드라이버 (STM32 ↔ ESP32 통신)
│   │
│   │── 📂 RTOS/               → 직접 구현한 RTOS 코드
│   │   │── rtos.c             → RTOS 커널 (태스크 스케줄링)
│   │   │── task_scheduler.c   → 태스크 관리
│   │   │── semaphore.c        → 세마포어 및 동기화 관리
│   │
│   │── 📂 Peripherals/        → 센서 및 액추에이터 제어 코드
│   │   │── motor_control.c    → DC 모터 및 서보모터 제어
│   │   │── ultrasonic_sensor.c→ 초음파 센서 (HC-SR04)
│   │   │── camera_module.c    → 카메라 모듈 (ESP32-CAM)
│   │
│   │── 📂 Communication/      → 통신 관련 코드
│   │   │── ble_controller.c   → BLE 컨트롤러 (MOGA XP5)
│   │   │── can_protocol.c     → CAN 메시지 송수신
│   │
│   │── 📂 Config/             → 환경 설정 및 매크로 정의
│   │   │── config.h           → 시스템 설정 (주파수, 클럭 등)
│   │   │── pin_mapping.h      → 핀 매핑 정의
│
│── 📂 ESP32/                  → ESP32 관련 코드
│   │── 📂 Core/               → 메인 코드
│   │   │── main.cpp           → ESP32 실행 코드
│   │
│   │── 📂 Communication/      → 통신 관련 코드 (BLE, CAN)
│   │   │── ble_handler.cpp    → BLE 데이터 처리
│   │   │── can_handler.cpp    → CAN 메시지 처리
│   │
│   │── 📂 Sensors/            → 센서 데이터 처리
│   │   │── ultrasonic.cpp     → 초음파 센서 데이터 전송
│   │   │── camera.cpp         → ESP32-CAM 처리
│
│── 📂 Docs/                   → 문서 및 설명
│   │── README.md              → 프로젝트 설명
│   │── Circuit_Diagram.pdf     → 회로도
│
│── 📂 Tests/                  → 단위 테스트 코드
│   │── test_motor.c           → 모터 제어 테스트
│   │── test_ble.c             → BLE 입력 테스트
│   │── test_can.c             → CAN 통신 테스트
```

---

## 3. 빌드 및 플래싱 (WSL2)
```sh
make clean   # 기존 빌드 파일 삭제
make         # 프로젝트 빌드
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program firmware.elf verify reset exit"
```

---

## 4. 추가 자료
- [STM32F407G-DISC1 공식 문서](https://www.st.com/en/evaluation-tools/stm32f4discovery.html)
- [ARM GCC Toolchain Documentation](https://developer.arm.com/downloads/-/gnu-rm)
- [OpenOCD User Guide](http://openocd.org/doc-release/html/index.html)
- [WSL2에서 USB 장치 연결](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)

---

이 문서는 WSL2 기반(우분투 24.04.02 LTS)에서 STM32F407G-DISC1과 ESP32를 활용한 Bare-Metal 환경에서 GCC Toolchain을 각각 사용하여 진행하는 펌웨어 개발을 위해 작성되었습니다. 지속적으로 업데이트될 예정입니다.

