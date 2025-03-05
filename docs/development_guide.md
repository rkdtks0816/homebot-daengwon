# Development Guide

## 1. 프로젝트 개요
본 프로젝트는 **STM32F407 및 ESP32 기반 임베디드 시스템**을 활용하여 소형 전기차 모델을 개발하는 것을 목표로 합니다. 주요 기능은 CAN 통신을 활용한 **주행 제어, 장애물 감지, 원격 조종**이며, 이를 통해 **임베디드 소프트웨어 개발 및 자동차 소프트웨어 아키텍처 설계 경험을 쌓는 것**이 목적입니다.

## 2. 개발 환경
### 2.1. 하드웨어 구성
- **MCU**: STM32F407VGT6, ESP32-WROOM-32D, ESP32-CAM
- **통신**: CAN (SN65HVD230 기반), BLE (컨트롤러 연결)
- **센서**: 초음파 센서 (HC-SR04), 카메라 모듈 (ESP32-CAM)
- **모터**: DC 모터, 서보모터
- **전원 공급**: 18650 배터리 3개, DC-DC Step Down Converter

### 2.2. 소프트웨어 구성
- **운영체제**: FreeRTOS (ESP32), Bare-metal (STM32)
- **개발 도구**:
  - **VSCode + GCC Toolchain** (STM32, ESP32)
  - **ESP-IDF** (ESP32)
  - **OpenOCD + GDB** (디버깅)
  - **WSL2 환경에서 개발**

## 3. 프로젝트 구조
```
📁 my_small_ev_project
├── 📁 stm32_vcu_drive_ecu (VCU + Drive ECU, STM32)
│   ├── 📁 Core
│   ├── 📁 MCAL
│   ├── 📁 BSW
│   ├── 📁 RTE
│   ├── 📁 APP
│   ├── 📁 Drivers
│   ├── 📁 Middlewares
│   ├── 📁 Build
│
├── 📁 esp32_sensor_ecu (센서 ECU, ESP32-CAM)
│   ├── 📁 src
│   ├── 📁 include
│   ├── 📁 drivers
│   ├── 📁 Build
│
├── 📁 esp32_controller_ecu (컨트롤러 ECU, ESP32)
│   ├── 📁 src
│   ├── 📁 include
│   ├── 📁 drivers
│   ├── 📁 Build
│
├── 📁 shared (공통 코드)
│   ├── 📁 CAN_protocol
│   ├── 📁 Utils
│
├── 📁 docs (프로젝트 문서)
├── 📁 scripts (자동화 스크립트)
├── 📁 configs (설정 파일)
├── README.md
```

## 4. 개발 워크플로우
### 4.1. 빌드 및 플래싱
#### STM32 빌드 및 플래싱
```sh
cd stm32_vcu_drive_ecu
make clean && make
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program build/main.elf verify reset exit"
```

#### ESP32 빌드 및 플래싱
```sh
cd esp32_sensor_ecu
idf.py build flash monitor
```

### 4.2. 디버깅
#### STM32 GDB 디버깅
```sh
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "gdbserver :3333"
gdb-multiarch build/main.elf -ex "target remote localhost:3333"
```

#### ESP32 GDB 디버깅
```sh
cd esp32_sensor_ecu
idf.py gdb
```

## 5. 개발 지침
### 5.1. 코딩 스타일
- STM32: **레지스터 직접 제어 (Bare-metal)** 방식 사용
- ESP32: **ESP-IDF API** 사용
- 모든 코드 파일은 `snake_case` 네이밍 컨벤션 준수
- `clang-format`을 사용한 코드 스타일 통일

### 5.2. 커밋 규칙
- 기능 추가: `feat: [기능명] 기능 추가`
- 버그 수정: `fix: [버그명] 수정`
- 문서 변경: `docs: [문서명] 업데이트`
- 리팩토링: `refactor: [파일명] 코드 개선`

### 5.3. 브랜치 전략
- `main`: 안정적인 코드만 병합
- `develop`: 최신 기능이 통합된 브랜치
- `feature/[기능명]`: 새로운 기능 개발
- `bugfix/[버그명]`: 버그 수정

## 6. 테스트 및 검증(예정)
### 6.1. CAN 통신 테스트
```sh
cd shared/CAN_protocol
g++ -o can_test can_test.cpp -lcan
./can_test
```

### 6.2. 모터 및 센서 테스트
- **DC 모터**: PWM 신호 확인 (오실로스코프 사용)
- **서보모터**: 특정 각도로 회전 여부 확인
- **초음파 센서**: 일정 거리에서 정상 감지 여부 확인
- **카메라**: 영상 데이터 정상 수신 확인

## 7. 문서 작성 및 유지보수
- 개발 과정 문서는 `docs/` 폴더에 저장
- **HSI (Hardware-Software Interface) 문서**, **BOM 리스트** 포함
- `README.md`에 최신 개발 상태 유지

## 8. 마무리
이 가이드는 프로젝트의 체계적인 개발을 위해 작성되었습니다. 개발 시 본 지침을 준수하여 원활한 협업과 프로젝트 유지보수를 수행해 주세요.

