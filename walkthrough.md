# Free Claude Code (FCC) 사용 가이드 (Docker 지원)

FCC의 로컬 설치 및 **완벽한 Docker 컨테이너 구성**이 완료되었습니다! 아래 안내에 따라 원하는 환경에서 100% 기능들을 모두 활용해 보세요.

---

## 🐳 Docker(도커) 환경에서 실행하기 (권장)

도커를 이용하면 내 PC 환경을 전혀 오염시키지 않고, 안전하게 모든 에이전트와 서버를 구동할 수 있습니다. 이미 모든 설정(`Dockerfile`, `docker-compose.yml`)을 마쳤습니다.

1. **Docker 컨테이너 시작하기 (백그라운드)**
   ```powershell
   cd C:\xampp\htdocs\freeclaude
   docker-compose up -d --build
   ```
   *현재 백그라운드에서 빌드가 진행되고 있습니다. 첫 빌드 시에는 약 3~5분 정도 소요될 수 있습니다.*

2. **Admin UI 접속하기**
   * 컨테이너가 켜지면 브라우저에서 `http://localhost:8082/admin` 에 접속하여 API 키 등을 설정할 수 있습니다.

3. **도커 내부에서 코딩 에이전트 실행하기**
   서버가 백그라운드에서 돌고 있는 상태에서, 언제든지 터미널을 열고 에이전트를 컨테이너 안에서 실행할 수 있습니다.
   * **Claude Code 실행**: `docker-compose exec freeclaude fcc-claude`
   * **Codex 실행**: `docker-compose exec freeclaude fcc-codex`
   * **Cline 실행**: `docker-compose exec freeclaude fcc-cline`
   *(현재 폴더가 컨테이너 내부의 `/workspace`로 마운트되어 있으므로, 여기서 작성되는 코드는 실제 내 PC에도 그대로 저장됩니다!)*

---

## 💻 로컬 터미널에서 직접 실행하기 (기존 방식)

모든 기능의 허브 역할을 하는 FCC 서버를 시작해야 합니다.

1. **PowerShell** 또는 **터미널**을 열고 설치된 폴더로 이동합니다.
   ```powershell
   cd C:\xampp\htdocs\freeclaude
   ```
2. **서버 시작 명령어**를 실행합니다.
   ```powershell
   uv run fcc-server
   ```
   *참고: 서버가 실행되면 웹 브라우저에서 자동으로 Admin UI가 열리거나 터미널에 Admin UI 주소(예: `http://localhost:8082/admin`)가 표시됩니다.*

> [!IMPORTANT]
> ### API 키 입력 방법
> 1. 브라우저에 열린 **Admin UI**에 접속합니다.
> 2. `Providers` 탭에서 발급받은 서비스(예: NVIDIA NIM, Groq, OpenRouter 등)의 빈칸에 API 키를 붙여넣습니다.
> 3. 아래의 `Validate` 버튼을 눌러 키가 유효한지 확인 후, `Apply`를 눌러 저장합니다.

## 2. 코딩 에이전트 실행 방법

FCC 서버가 켜져 있는 상태에서, 새로운 터미널 창을 열고 원하는 코딩 에이전트를 실행할 수 있습니다. 
명령어 앞에 `uv run`을 붙여 로컬 환경에서 바로 실행합니다.

*   **Claude Code 실행**: `uv run fcc-claude`
*   **Codex 실행**: `uv run fcc-codex`
*   **Cline 실행**: `uv run fcc-cline`
*   **Aider 실행**: `uv run fcc-aider`
*   기타 에이전트: `fcc-pi`, `fcc-opencode`, `fcc-hermes`, `fcc-dsh`, `fcc-grok`, `fcc-muse`

## 3. 고급 기능 100% 활용하기

### 🤖 텔레그램 / 디스코드 봇 연동
휴대폰이나 외부에서 에이전트에 코딩을 요청하고 결과를 받아볼 수 있습니다.
1. Admin UI의 **[Messaging]** 탭으로 이동합니다.
2. `Messaging Platform`을 **discord** 또는 **telegram**으로 선택합니다.
3. 발급받은 Bot Token과 권한을 허용할 사용자 ID(또는 채널 ID)를 입력하고 저장합니다.
4. 서버를 재시작(`fcc-server` 재실행)하면 봇이 활성화됩니다.
5. 봇에게 코딩 관련 질문이나 지시를 내리면 에이전트가 답변합니다. (명령어: `/clear`, `/stop` 등 지원)

### 🎙️ 음성 노트 (Voice Notes)
마이크를 통해 음성으로 에이전트에게 지시를 내릴 수 있습니다.
1. Admin UI의 **[Messaging]** -> **[Voice]** 설정으로 이동합니다.
2. `Voice Note Enabled`를 켭니다.
3. 로컬 Whisper 모델을 사용하려면 Device를 `cpu` (또는 `cuda`), 모델을 `base` 등으로 설정합니다.
4. 메신저(텔레그램/디스코드) 앱에서 음성 메시지를 보내면, FCC가 이를 자동으로 텍스트 코딩 지시로 변환합니다.

### 🛡️ 모델 대체 기능 (Fallback) 및 최적화
*   **에러 방어**: 제공업체(Provider) 장애 시 끊기지 않게 하려면, `.env` 파일 내 `MODEL_FALLBACKS`에 예비 모델들을 쉼표로 구분해 입력해두세요. (예: `groq/llama-3.3-70b-versatile,open_router/openrouter/free`)
*   **터미널 토큰 절약 (RTK)**: 긴 명령 출력을 줄이고 모델 사용량을 최적화하는 기능이 기본 탑재되어 있어, 불필요한 과금을 줄여줍니다.

> [!TIP]
> **오류 대처법**: 제공업체 제한(Rate Limit)에 걸리거나 API 오류가 나더라도, FCC는 자동으로 다음 설정된 모델로 재시도하므로 대화 흐름이 끊기지 않습니다!

> [!NOTE]
> `.env` 파일은 프로젝트 폴더(`C:\xampp\htdocs\freeclaude\.env`)에 복사해 두었습니다. Admin UI를 통해 설정하면 이 파일이나 내부 설정에 자동으로 적용되므로, **Admin UI 사용을 가장 권장**합니다.
