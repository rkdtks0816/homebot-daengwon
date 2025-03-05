# Scripts Usage

이 문서는 **나의 조그만 전기차 프로젝트**의 `scripts` 폴더 내 자동화 스크립트 사용 방법을 설명합니다.

## 디렉터리 구조

```
📁 scripts
├── build_stm32.sh        # STM32 펌웨어 빌드 스크립트
├── flash_stm32.sh        # STM32 펌웨어 플래싱 스크립트
├── build_esp32.sh        # ESP32 펌웨어 빌드 스크립트
├── flash_esp32.sh        # ESP32 펌웨어 플래싱 스크립트
├── can_monitor.py        # CAN 버스 모니터링 도구
├── clean_project.sh      # 프로젝트 정리 스크립트
```

## 사전 준비
다음과 같은 필수 패키지가 설치되어 있어야 합니다:
- `arm-none-eabi-gcc` (STM32 컴파일러)
- `openocd` (STM32 플래싱 및 디버깅)
- `esp-idf` (ESP32 개발 환경)
- `can-utils` (CAN 버스 모니터링)(예정)

### 1. STM32 펌웨어 빌드
```sh
./scripts/build_stm32.sh
```
이 명령어를 실행하면 STM32 펌웨어가 컴파일되며, `stm32_vcu_drive_ecu/Build/` 디렉터리에 바이너리 파일이 생성됩니다.

### 2. STM32 펌웨어 플래싱
```sh
./scripts/flash_stm32.sh
```
이 스크립트를 실행하면 OpenOCD를 사용하여 STM32 보드에 펌웨어를 업로드합니다.

### 3. ESP32 펌웨어 빌드
```sh
./scripts/build_esp32.sh
```
이 명령어를 실행하면 `esp-idf`를 사용하여 ESP32 펌웨어가 컴파일되며, 결과물은 `esp32_sensor_ecu/Build/` 및 `esp32_controller_ecu/Build/` 디렉터리에 저장됩니다.

### 4. ESP32 펌웨어 플래싱
```sh
./scripts/flash_esp32.sh
```
이 스크립트를 실행하면 컴파일된 ESP32 펌웨어를 각각의 ESP32 모듈에 업로드합니다.

### 5. CAN 버스 모니터링
```sh
python3 scripts/can_monitor.py
```
이 스크립트를 실행하면 실시간으로 CAN 버스 메시지를 수신하고 로그를 출력합니다.

### 6. 프로젝트 정리
```sh
./scripts/clean_project.sh
```
이 명령어를 실행하면 빌드 결과물을 삭제하고 환경을 초기화합니다.

## 참고 사항
- 플래싱 전에 올바른 보드가 연결되어 있는지 확인하세요.
- 환경에 맞게 스크립트를 수정하여 사용할 수 있습니다.
- 실행 권한이 없는 경우 `chmod +x scripts/*.sh` 명령어로 권한을 부여하세요.

자세한 내용은 프로젝트 루트에 있는 `README.md`를 참고하세요.

