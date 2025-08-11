# HSC1 병원 관리 시스템 - Railway 배포 가이드

이 가이드는 HSC1 병원 관리 시스템을 Railway에 배포하는 방법을 설명합니다.

## 프로젝트 구조

```
hsc1/
├── backend/          # Rails 8.0.2 API 서버 (포트 7001)
├── frontend/         # Rails 8.0.2 웹 애플리케이션 (포트 7002)
├── railway-backend.env.example
├── railway-frontend.env.example
└── RAILWAY_DEPLOYMENT.md
```

## Railway 배포 단계별 가이드

### 1단계: Railway 계정 및 프로젝트 설정

1. [Railway.app](https://railway.app) 가입 및 로그인
2. 새 프로젝트 생성
3. GitHub 계정 연결
4. `hsc1` repository 선택

### 2단계: 데이터베이스 설정

1. Railway Dashboard에서 `+ Add Service` 클릭
2. `Database` → `PostgreSQL` 선택
3. 데이터베이스가 생성되면 연결 정보 확인

### 3단계: Backend 서비스 배포

1. `+ Add Service` → `GitHub Repo` → `hsc1` 선택
2. 서비스 이름을 `backend`로 설정
3. **Settings** 탭에서 다음 설정:
   - **Root Directory**: `/backend`
   - **Build Command**: (비워둠 - Dockerfile 사용)
   - **Start Command**: (비워둠 - Dockerfile 사용)

4. **Variables** 탭에서 환경 변수 설정:
   ```
   RAILS_ENV=production
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   PGDATABASE=${{Postgres.PGDATABASE}}
   PGUSER=${{Postgres.PGUSER}}
   PGPASSWORD=${{Postgres.PGPASSWORD}}
   PGHOST=${{Postgres.PGHOST}}
   PGPORT=${{Postgres.PGPORT}}
   RAILS_MASTER_KEY=[backend/config/master.key 파일 내용]
   FRONTEND_URL=https://[frontend-service-domain].railway.app
   RAILS_MAX_THREADS=10
   ```

5. **Networking** 탭에서 Public Domain 생성

### 4단계: Frontend 서비스 배포

1. `+ Add Service` → `GitHub Repo` → `hsc1` 선택
2. 서비스 이름을 `frontend`로 설정
3. **Settings** 탭에서 다음 설정:
   - **Root Directory**: `/frontend`
   - **Build Command**: (비워둠 - Dockerfile 사용)
   - **Start Command**: (비워둠 - Dockerfile 사용)

4. **Variables** 탭에서 환경 변수 설정:
   ```
   RAILS_ENV=production
   RAILS_MASTER_KEY=[frontend/config/master.key 파일 내용]
   BACKEND_API_URL=https://[backend-service-domain].railway.app/api/v1
   RAILS_MAX_THREADS=5
   ```

5. **Networking** 탭에서 Public Domain 생성

### 5단계: 환경 변수 업데이트

Backend 서비스에서 Frontend 도메인이 생성된 후:
1. Backend 서비스의 `FRONTEND_URL` 변수를 실제 Frontend 도메인으로 업데이트

### 6단계: 배포 확인

1. **Backend 서비스 확인**:
   - `https://[backend-domain].railway.app/up` → 200 OK 응답 확인
   - 로그에서 데이터베이스 마이그레이션 성공 확인

2. **Frontend 서비스 확인**:
   - `https://[frontend-domain].railway.app` → 로그인 페이지 표시 확인
   - 브라우저 개발자 도구에서 API 호출 확인

3. **전체 기능 테스트**:
   - 로그인 기능
   - 공지사항 목록/상세 조회
   - 읽음 상태 추적
   - 고정 기능

## 주요 설정 파일 설명

### Backend Dockerfile
- Ruby 3.4.5 기반 멀티스테이지 빌드
- PostgreSQL 클라이언트 포함
- 포트 7001로 서비스 제공

### Frontend Dockerfile  
- Ruby 3.4.5 기반 멀티스테이지 빌드
- 에셋 프리컴파일 포함
- 포트 7002로 서비스 제공

### 환경 변수 처리
- Backend: `config/database.yml`에서 `DATABASE_URL` 환경 변수 사용
- Frontend: JavaScript에서 `window.BACKEND_API_URL` 사용
- CORS: `config/initializers/cors.rb`에서 `FRONTEND_URL` 환경 변수 사용

## 데이터베이스 마이그레이션

Railway는 배포 시 자동으로 `bin/docker-entrypoint`를 실행하여:
1. `rails db:prepare` 명령 실행
2. 필요한 경우 데이터베이스 생성 및 마이그레이션 실행

## 모니터링 및 로그

- **Railway Dashboard** → **각 서비스** → **Logs** 탭에서 실시간 로그 확인
- **Metrics** 탭에서 CPU, 메모리, 네트워크 사용량 모니터링

## 비용 최적화

1. **Hobby Plan** ($5/월): 개발/테스트 환경
2. **Pro Plan** ($20/월): 프로덕션 환경
3. **Serverless Mode**: 비활성 시 자동 0 스케일링으로 비용 절약

## 문제 해결

### 일반적인 오류

1. **데이터베이스 연결 실패**:
   - PostgreSQL 서비스가 실행 중인지 확인
   - DATABASE_URL 환경 변수 올바른지 확인

2. **CORS 오류**:
   - Backend의 FRONTEND_URL 환경 변수 확인
   - Frontend 도메인이 정확한지 확인

3. **Asset 로드 실패**:
   - Frontend 에셋 프리컴파일 로그 확인
   - RAILS_MASTER_KEY 환경 변수 확인

### 유용한 Railway CLI 명령어

```bash
# Railway CLI 설치
npm install -g @railway/cli

# 프로젝트 연결
railway login
railway link

# 로그 확인
railway logs --service backend
railway logs --service frontend

# 환경 변수 확인
railway variables --service backend
```

## 개발 환경과의 차이점

- **SSL 강제**: Production 환경에서 HTTPS 강제 사용
- **Asset Pipeline**: Frontend에서 에셋 프리컴파일 필요
- **환경 변수**: 하드코딩된 localhost URL을 환경 변수로 대체
- **로그 레벨**: Production에서는 info 레벨 이상만 로그 출력

## 보안 고려사항

1. **RAILS_MASTER_KEY**: 절대 코드에 포함하지 말고 환경 변수로만 관리
2. **DATABASE_URL**: Railway에서 자동 생성된 보안 연결 문자열 사용
3. **CORS**: 특정 도메인만 허용하도록 설정
4. **SSL/TLS**: 모든 통신 암호화

## 추가 리소스

- [Railway Documentation](https://docs.railway.com/)
- [Rails Deployment Guide](https://guides.rubyonrails.org/deployment.html)
- [Railway Discord](https://discord.gg/railway)