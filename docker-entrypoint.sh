#!/bin/bash
set -e

# 도커 환경에서 서버가 실행 중임을 명시적으로 출력
echo "=============================================="
echo " Starting Free Claude Code in Docker Sandbox"
echo " Workspace mapped to: /workspace"
echo "=============================================="

# 제공된 명령어가 없으면 fcc-server 실행
if [ "$#" -eq 0 ]; then
    exec fcc-server
else
    # 인자로 넘어온 명령어 실행 (예: fcc-claude)
    exec "$@"
fi
