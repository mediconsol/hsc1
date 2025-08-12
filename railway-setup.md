# Railway 배포 설정 가이드

## 1. Railway 프로젝트 설정

### Railway Dashboard에서:
1. 새 프로젝트 생성
2. GitHub repository 연결 (hsc1)
3. PostgreSQL 데이터베이스 추가

### 서비스 생성:
1. **Backend Service**:
   - Root Directory: `/backend`
   - Service Name: `backend`
   
2. **Frontend Service**:
   - Root Directory: `/frontend`  
   - Service Name: `frontend`

## 2. 환경 변수 설정

### Backend Service Variables:
```
RAILS_ENV=production
DATABASE_URL=${{Postgres.DATABASE_URL}}
PGDATABASE=${{Postgres.PGDATABASE}}
PGUSER=${{Postgres.PGUSER}}
PGPASSWORD=${{Postgres.PGPASSWORD}}
PGHOST=${{Postgres.PGHOST}}
PGPORT=${{Postgres.PGPORT}}
RAILS_MASTER_KEY=[backend/config/master.key 내용]
FRONTEND_URL=https://[frontend-domain].railway.app
RAILS_MAX_THREADS=10
```

### Frontend Service Variables:
```
RAILS_ENV=production
RAILS_MASTER_KEY=[frontend/config/master.key 내용]
BACKEND_API_URL=https://[backend-domain].railway.app/api/v1
RAILS_MAX_THREADS=5
```

## 3. GitHub Actions 설정

### Repository Secrets 추가:
1. GitHub Repository → Settings → Secrets and Variables → Actions
2. **New repository secret** 클릭
3. 다음 시크릿 추가:
   ```
   Name: RAILWAY_TOKEN
   Secret: [Railway Dashboard → Account → Tokens에서 생성한 토큰]
   ```

### Railway Token 생성:
1. Railway Dashboard → Account Settings → Tokens
2. "Create New Token" 클릭
3. 토큰 이름 입력 (예: "GitHub Actions Deploy")
4. 생성된 토큰을 GitHub Secrets에 저장

## 4. 배포 흐름

### 자동 배포:
- `main` 브랜치에 push 시 자동 배포
- GitHub Actions가 백엔드 → 프론트엔드 순서로 배포

### 수동 배포:
- GitHub Repository → Actions → "Deploy to Railway" → "Run workflow"

## 5. 배포 확인

### Backend 확인:
- `https://[backend-domain].railway.app/up` → 200 OK
- API 문서: `https://[backend-domain].railway.app/api-docs`

### Frontend 확인:
- `https://[frontend-domain].railway.app` → 로그인 페이지
- 로그인 기능 테스트: admin@hospital.com / password123

## 6. 모니터링

### Railway Dashboard:
- Deployment Logs 확인
- Metrics (CPU, Memory, Network) 모니터링
- Service Health 확인

### GitHub Actions:
- Actions 탭에서 배포 상태 확인
- 실패 시 로그 분석 및 수정

## 7. 장애 대응

### 배포 실패 시:
1. GitHub Actions 로그 확인
2. Railway 서비스 로그 확인
3. 환경 변수 설정 재확인
4. Railway CLI로 수동 배포 시도

### 롤백 방법:
1. GitHub에서 이전 커밋으로 revert
2. Railway Dashboard에서 이전 deployment로 롤백
3. 또는 Railway CLI: `railway rollback`