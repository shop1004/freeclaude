# 🐳 Free Claude Code (FCC) 도커 원스톱 복사 및 사용 가이드

이 가이드는 현재 구성된 도커 환경과 데이터를 통째로 다른 서버나 PC로 복사하여 **아무런 추가 설정 없이 원스톱으로 바로 사용하는 방법**을 설명합니다.

---

## 1. 📦 도커 통째로 복사하기 (마이그레이션)

현재 프로젝트 폴더에는 모든 설정, API 키, 데이터베이스 정보가 `data/` 폴더에 안전하게 저장되어 있습니다.

1. **현재 작업 폴더(`freeclaude`)를 통째로 압축**합니다. (또는 USB 등에 그대로 복사)
2. 새로운 PC나 서버에 해당 폴더를 압축 해제(복사) 합니다.
3. 새 PC의 터미널(또는 PowerShell)에서 해당 폴더로 이동한 후 아래 명령어를 실행합니다:

```powershell
docker-compose up -d --build
```

> [!NOTE]
> `data` 폴더가 같이 복사되었기 때문에, 기존에 설정했던 **NVIDIA NIM API 키 등의 설정이 그대로 유지**됩니다. 새로 설정할 필요가 전혀 없습니다!

---

## 2. 🔗 정확한 접속 URL 및 확인 방법

컨테이너가 정상적으로 실행되었다면, 다음 URL을 통해 서버가 잘 작동하는지 확인하고 관리할 수 있습니다.

### 🌐 Admin UI (관리자 페이지) 접속
웹 브라우저를 열고 아래 주소로 접속합니다. API 키 변경, 모델 선택 등을 할 수 있습니다.
* **접속 URL:** [http://127.0.0.1:8082/admin](http://127.0.0.1:8082/admin) 또는 [http://localhost:8082/admin](http://localhost:8082/admin)

### ✅ 서버 정상 작동 확인 (상태 체크)
브라우저에 아래 주소를 입력했을 때, 서버 상태와 모델 정보가 JSON 형태로 출력되면 정상적으로 연동된 것입니다.
* **접속 URL:** [http://localhost:8082/](http://localhost:8082/)
* **정상 응답 예시:**
  ```json
  {"status":"ok","provider":"nvidia_nim","model":"nvidia_nim/deepseek-ai/deepseek-v4-pro-0813"}
  ```

---

## 3. 💻 코딩 에이전트(Claude Code) 실행 가이드

새 PC에서 FCC를 구동한 후 코딩 에이전트를 사용하는 2가지 방법입니다. 

### 방법 A: 도커 컨테이너 내부에서 직접 실행 (가장 확실하고 격리된 환경)
PC에 아무런 언어나 환경을 설치할 필요 없이, 도커 내부에서 바로 에이전트를 구동합니다.

```powershell
# 컨테이너의 터미널에 접속하면서 바로 fcc-claude 실행
docker exec -it free-claude-code fcc-claude
```
*(현재 호스트의 폴더가 컨테이너의 `/workspace`와 연동되어 있으므로, 도커 안에서 작성된 코드도 실제 내 PC에 그대로 실시간 저장됩니다.)*

### 방법 B: 호스트(내 PC)의 터미널(PowerShell)에서 실행
서버는 도커(또는 백그라운드)로 돌려두고, 기존처럼 내 PowerShell에서 명령어로 바로 쓰고 싶을 때 사용합니다.

1. 호스트 PC에 파이썬 패키지 관리자인 `uv`가 설치되어 있어야 합니다.
2. 터미널(PowerShell)에서 아래 명령어로 실행합니다:
```powershell
uv run fcc-claude
```

> [!IMPORTANT]
> **인증 에러 방지 안내**
> PowerShell에서 실행할 때 `Both ANTHROPIC_AUTH_TOKEN and /login managed key set` 과 같은 인증 충돌 경고가 나타난다면, 이전에 공식 Claude 툴로 로그인했던 정보가 꼬인 것입니다.
> 이 경우 PowerShell에서 `uv run claude /logout` 또는 `npx @anthropic-ai/claude-code /logout` 을 실행하여 로컬 로그아웃을 한번 해주시면 무료 토큰(`freecc`)으로 완벽하게 우회 연결됩니다.
