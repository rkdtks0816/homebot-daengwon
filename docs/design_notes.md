# Design Notes

## 1. Overview
"나의 조그만 전기차" 프로젝트는 임베디드 시스템과 CAN 통신을 활용하여 전기차 아키텍처를 소형 RC카에 적용하는 프로젝트입니다. STM32와 ESP32 기반의 다양한 ECU를 설계하고, RTOS 및 레지스터 기반 프로그래밍을 통해 실시간 제어 시스템을 구현합니다.

## 2. System Architecture
### 2.1 Hardware Architecture
- **VCU & Drive ECU (STM32F407)**: 모터 제어 및 CAN 메시지 관리
- **Sensor ECU (ESP32-CAM)**: 전방 시각 정보 및 장애물 감지 센서 데이터 처리
- **Controller ECU (ESP32-WROOM-32D)**: BLE 통신을 통한 외부 컨트롤러 입력 수신 및 CAN 메시지 전송
- **Peripherals**: 초음파 센서, 카메라 모듈, 서보모터, DC 모터, 배터리, CAN 트랜시버

### 2.2 Software Architecture
- **VCU & Drive ECU (STM32)**
  - Bare-metal 레지스터 기반 제어
  - DC 모터 및 서보모터 PWM 신호 생성
  - CAN 메시지 송수신 및 오류 처리
- **Sensor ECU (ESP32)**
  - FreeRTOS 기반 멀티태스킹
  - 초음파 센서 및 카메라 데이터 수집
  - CAN 메시지를 통한 장애물 정보 송신
- **Controller ECU (ESP32)**
  - BLE 기반 컨트롤러 입력 처리
  - CAN 메시지를 통한 주행 명령 전송
  - UI 인터페이스 확장 가능성 고려

## 3. Communication Design
### 3.1 CAN Protocol
- **ID Allocation**
  - `0x100`: 모터 속도 및 방향 제어
  - `0x200`: 조향 각도 설정
  - `0x300`: 장애물 감지 정보
  - `0x400`: 컨트롤러 입력 데이터
- **Message Structure**
  - 8바이트 데이터 프레임 사용 (AUTOSAR 기본 프로파일 준수)
  - 주기적 메시지(Heartbeat)와 이벤트 기반 메시지 분리

### 3.2 BLE Communication
- **Controller → ESP32**
  - 컨트롤러 데이터를 BLE으로 수신
  - ESP32에서 이를 CAN 메시지로 변환 후 전송

## 4. Power Management
- **18650 배터리 3개 직렬 연결 (12.6V) → DC-DC 컨버터 (5V/3.3V 변환)**
- **VCU, Sensor ECU, Controller ECU 각각 독립적인 전력 분배 필요**
- **저전력 모드 및 전력 소비 최적화 고려**

## 5. Development & Debugging
### 5.1 Development Environment
- **STM32**: VSCode + GCC Toolchain + OpenOCD + GDB
- **ESP32**: ESP-IDF + FreeRTOS
- **공통 빌드 스크립트**: 프로젝트 폴더 내 `scripts/build.sh` 자동화 적용

### 5.2 Debugging Strategy
- **STM32**: SWD 디버깅 (OpenOCD + ST-Link)
- **ESP32**: UART 디버깅 + ESP-IDF 로그 시스템
- **CAN Bus**: CAN 분석기(Saleae Logic 또는 CANoe) 활용하여 패킷 모니터링(예정)

## 6. Future Improvements
- **차선 감지 및 장애물 회피 알고리즘 추가**
- **UI 기반 원격 제어 기능 확장 (웹 인터페이스)**
- **ROS2 기반 상위 시스템 연동 실험**

