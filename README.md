# 나의 조그만 전기차

**"나의 조그만 전기차"** 프로젝트는 STM32와 ESP32 기반의 임베디드 시스템을 활용하여 전기차의 축소판을 개발하는 프로젝트입니다. CAN 통신을 통해 여러 ECU를 연동하고, 주행 및 장애물 감지 기능을 구현합니다.

## 📌 프로젝트 개요

- **목표**: 실차 아키텍처와 유사한 임베디드 시스템을 개발하여 차량용 소프트웨어 설계 및 CAN 통신 경험 습득
- **주요 기능**:
  - DC 모터 및 서보모터를 이용한 주행 및 조향 제어
  - 초음파 센서 및 카메라를 활용한 장애물 감지
  - CAN 프로토콜을 통한 ECU 간 데이터 송수신
  - BLE 컨트롤러를 통한 원격 제어
- **사용 기술**:
  - **MCU**: STM32F407, ESP32-WROOM-32D, ESP32-CAM
  - **통신**: CAN(SN65HVD230), BLE
  - **운영체제**: FreeRTOS(ESP32), Bare-metal(STM32)
  - **전원**: 18650 배터리(3개), DC-DC 다운 컨버터

## 📂 프로젝트 폴더 구조

```
📁 my_small_ev_project (프로젝트 루트)
├── 📁 stm32_vcu_drive_ecu (VCU + Drive ECU, STM32)
│   ├── 📁 Core (메인 코드)
│   ├── 📁 MCAL (하드웨어 추상화 계층)
│   ├── 📁 BSW (기본 소프트웨어 계층)
│   ├── 📁 RTE (런타임 환경)
│   ├── 📁 APP (애플리케이션 계층)
│   ├── 📁 Drivers (STM32 드라이버 코드)
│   ├── 📁 Middlewares (추가 라이브러리)
│   ├── 📁 Build (빌드 결과물)
│
├── 📁 esp32_sensor_ecu (센서 ECU, ESP32-CAM)
│   ├── 📁 src (소스 코드)
│   ├── 📁 include (헤더 파일)
│   ├── 📁 drivers (드라이버)
│   ├── 📁 Build (빌드 결과물)
│
├── 📁 esp32_controller_ecu (컨트롤러 ECU, ESP32)
│   ├── 📁 src (소스 코드)
│   ├── 📁 include (헤더 파일)
│   ├── 📁 drivers (드라이버)
│   ├── 📁 Build (빌드 결과물)
│
├── 📁 shared (공통 코드)
│   ├── 📁 CAN_protocol (CAN 메시지 정의)
│   ├── 📁 Utils (공용 유틸리티 코드)
│
├── 📁 docs (프로젝트 문서)
├── 📁 scripts (자동화 스크립트)
├── 📁 configs (설정 파일)
├── README.md (프로젝트 개요)
```

## 🛠️ 개발 환경 설정

### 1️⃣ 필수 도구 설치
- **Toolchain**
  - STM32: GNU Arm Embedded Toolchain, OpenOCD, GDB
  - ESP32: ESP-IDF, Xtensa GCC Toolchain
- **IDE**: VSCode + PlatformIO / STM32CubeIDE (선택 사항)
- **Python 스크립트 실행 환경**: `Python 3.x`, `pip install -r scripts/requirements.txt`

### 2️⃣ 빌드 및 플래싱

#### 🏎️ STM32 (VCU + Drive ECU)
```bash
cd stm32_vcu_drive_ecu
make flash  # OpenOCD를 사용하여 플래싱
```

#### 📡 ESP32 (센서 ECU)
```bash
cd esp32_sensor_ecu
idf.py build flash monitor
```

#### 🎮 ESP32 (컨트롤러 ECU)
```bash
cd esp32_controller_ecu
idf.py build flash monitor
```

## 📡 CAN 통신 메시지 정의

| ID | 송신 ECU | 수신 ECU | 데이터 | 설명 |
|----|---------|---------|--------|------|
| 0x100 | Controller ECU | VCU | `0x01`~`0x04` | 조향 및 속도 제어 |
| 0x200 | Sensor ECU | VCU | 거리 값 (`cm`) | 장애물 감지 |
| 0x300 | VCU | Controller ECU | 상태 정보 | 모터 상태 |

## 🚀 실행 방법
1. 배터리 연결 후 전원 공급
2. ESP32 및 STM32에 각각 펌웨어 업로드
3. 컨트롤러 ECU(BLE)와 게임패드 연결 후 조작
4. 센서 ECU에서 장애물 감지 후 CAN 메시지 전송
5. VCU에서 주행 제어 후 모터 동작 확인

## 🔥 이슈 및 개선 사항
- 📌 CAN 메시지 최적화 및 오류 처리 로직 추가 예정
- 📌 ROS2 기반 원격 모니터링 기능 추가 검토 중
- 📌 전력 소비 최적화 및 배터리 효율 개선

## 📜 라이선스
본 프로젝트는 **MIT 라이선스** 하에 배포됩니다.

---

추가 문의 또는 기여를 원하시면 [GitHub Issues](https://github.com/)에 남겨주세요! 🚗💨

