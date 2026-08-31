FROM ubuntu:24.04

# 방화벽, 타임존 등 상호작용 방지
ENV DEBIAN_FRONTEND=noninteractive

# 기본 의존성 및 Node.js 설치
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    nodejs \
    npm \
    build-essential \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# 파이썬 패키지 매니저 uv 설치
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR=/usr/local/bin sh

# 작업 디렉토리 설정
WORKDIR /app

# 애플리케이션 코드 전체 복사
COPY . .

# uv를 사용하여 Python 3.14 버전을 기반으로 의존성 설치 (음성 모듈 모두 포함)
# pyproject.toml에 3.14.0 요구사항이 있으므로 uv가 자동으로 설치합니다.
RUN uv sync --extra voice_local --extra voice

# 자주 사용되는 주요 코딩 에이전트 글로벌 설치 (Node.js 기반)
RUN npm install -g @anthropic-ai/claude-code @cline/cli

# 환경 변수 및 가상 환경 PATH 추가
ENV PATH="/app/.venv/bin:$PATH"
ENV HOST=0.0.0.0
ENV PORT=8082
# 에이전트들이 작업할 기본 볼륨 디렉토리 지정
ENV ALLOWED_DIR=/workspace

# 외부 노출 포트 (Admin UI 및 프록시)
EXPOSE 8082

# 시작 스크립트 권한 부여 및 설정
COPY docker-entrypoint.sh /usr/local/bin/
RUN dos2unix /usr/local/bin/docker-entrypoint.sh && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# 기본 명령어: FCC 서버 실행
CMD ["fcc-server"]
