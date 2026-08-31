# 🐣 초보자를 위한 Free Claude Code (Docker) 실행 가이드

사용자님께서 보여주신 터미널 창을 보면, 현재 위치가 `C:\Users` 폴더로 되어 있습니다. 
`docker-compose` 명령어는 설정 파일(`docker-compose.yml`)이 있는 폴더에서만 작동하기 때문에 "설정 파일을 찾을 수 없다(no configuration file provided: not found)"는 오류가 발생한 것입니다.

이를 해결하고 완벽하게 실행하기 위한 **두 가지 방법**을 아주 쉽게 설명해 드립니다!

---

## 방법 1: 설정 파일이 있는 폴더로 이동해서 실행하기 (정석)

가장 권장되는 방법입니다. 우리가 설치한 폴더로 직접 이동한 뒤 실행하는 방법입니다.

**1. 폴더 이동하기 (cd 명령어)**
터미널(PowerShell) 창에 아래 명령어를 그대로 복사해서 붙여넣고 엔터를 치세요.
```powershell
cd C:\xampp\htdocs\freeclaude
```
*(왼쪽의 경로가 `PS C:\xampp\htdocs\freeclaude>` 로 바뀌었는지 확인하세요!)*

**2. 에이전트 실행하기**
이제 해당 폴더 안에 설정 파일이 있으므로, 에러 없이 명령어가 작동합니다. 원하는 에이전트 명령어를 입력하고 엔터를 치세요.
```powershell
# Claude Code 실행
docker-compose exec freeclaude fcc-claude

# 또는 Codex 실행
docker-compose exec freeclaude fcc-codex
```

---

## 방법 2: 위치 상관없이 어디서든 바로 실행하기 (꿀팁)

폴더를 매번 이동하는 것이 귀찮다면, `docker-compose` 대신 순수 `docker` 명령어를 사용하면 **컴퓨터 내 어떤 폴더(예: C:\Users)에 있더라도** 바로 실행할 수 있습니다!

터미널(PowerShell)에 위치와 상관없이 아래 명령어를 복사해서 붙여넣고 엔터를 치세요.

```powershell
# Claude Code 실행
docker exec -it free-claude-code fcc-claude

# 또는 Codex 실행
docker exec -it free-claude-code fcc-codex
```
*(주의: `-it` 옵션과 컨테이너의 정확한 이름인 `free-claude-code`를 사용해야 합니다.)*

---

> [!TIP]
> ### 💡 작동 원리 이해하기
> * **`cd` (Change Directory)**: 폴더(디렉토리)를 이동하는 명령어입니다. 방에 들어가는 것과 같습니다.
> * **`docker-compose`**: 여러 개의 도커 설정을 묶어놓은 `docker-compose.yml` 파일이라는 '설명서'를 읽고 작동합니다. 따라서 설명서가 있는 방에 들어가야만 작동합니다.
> * **`docker exec`**: 현재 구동 중인 이름표가 붙은 컨테이너(`free-claude-code`)를 바로 콕 집어서 명령을 내립니다. 설명서 없이도 이름만 알면 어느 방에서든 부를 수 있습니다.

이제 위 가이드에 따라 터미널에서 다시 시도해 보세요! 아주 부드럽게 AI 에이전트가 응답할 것입니다. 😊
