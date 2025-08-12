# 🚀 HSC1 Railway 배포 완전 가이드

Hospital Management System을 Railway에 배포하기 위한 완전한 단계별 가이드입니다.

## 📋 사전 준비 완료 상태

### ✅ 구현 완료된 기능들
- [x] GitHub Actions 자동 배포 워크플로우
- [x] Railway 최적화된 nixpacks 설정
- [x] Production 환경 설정 최적화
- [x] 데이터베이스 마이그레이션 자동화
- [x] Health Check 및 모니터링 시스템
- [x] 보안 설정 강화 (SSL, CORS, CSP)
- [x] 구조화된 로깅 시스템
- [x] 환경 변수 템플릿

### 📁 주요 파일들
```
hsc1/
├── .github/workflows/railway-deploy.yml    # 자동 배포 워크플로우
├── .railway/railway.json                   # Railway 설정
├── backend/
│   ├── nixpacks.toml                      # 백엔드 빌드 설정
│   ├── bin/railway-setup                  # 데이터베이스 설정 스크립트
│   └── config/environments/production.rb   # 최적화된 운영 설정
├── frontend/
│   ├── nixpacks.toml                      # 프론트엔드 빌드 설정
│   └── config/environments/production.rb   # 최적화된 운영 설정
├── railway-setup.md                       # Railway 설정 가이드
├── github-secrets-setup.md                # GitHub Secrets 설정
├── deployment-checklist.md                # 배포 검증 체크리스트
└── security-checklist.md                  # 보안 점검 가이드
```

## 🚀 배포 실행 단계

### 1단계: Railway 프로젝트 생성

1. **Railway 계정 생성 및 로그인**
   ```bash
   # Railway CLI 설치
   npm install -g @railway/cli
   
   # 로그인
   railway login
   ```

2. **새 프로젝트 생성**
   - Railway Dashboard에서 "New Project" 클릭
   - "Deploy from GitHub repo" 선택
   - `hsc1` 저장소 선택

### 2단계: 데이터베이스 서비스 추가

1. **PostgreSQL 추가**
   - 프로젝트에서 "Add Service" 클릭
   - "Database" → "PostgreSQL" 선택
   - 자동으로 환경 변수가 생성됨

### 3단계: 백엔드 서비스 설정

1. **백엔드 서비스 생성**
   - "Add Service" → "GitHub Repo" → "hsc1"
   - 서비스 이름: `backend`
   - Root Directory: `/backend`

2. **환경 변수 설정**
   ```
   RAILS_ENV=production
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   PGDATABASE=${{Postgres.PGDATABASE}}
   PGUSER=${{Postgres.PGUSER}}
   PGPASSWORD=${{Postgres.PGPASSWORD}}
   PGHOST=${{Postgres.PGHOST}}
   PGPORT=${{Postgres.PGPORT}}
   RAILS_MASTER_KEY=06fe0825bdc0b62f5891cc578c3bf4b0
   RAILS_MAX_THREADS=10
   GEMINI_API_KEY=[여기에 Gemini API 키 입력]
   ```

3. **Public Domain 생성**
   - "Networking" 탭에서 도메인 생성
   - 생성된 URL 복사 (예: `https://backend-xxx.railway.app`)

### 4단계: 프론트엔드 서비스 설정

1. **프론트엔드 서비스 생성**
   - "Add Service" → "GitHub Repo" → "hsc1"
   - 서비스 이름: `frontend`
   - Root Directory: `/frontend`

2. **환경 변수 설정**
   ```
   RAILS_ENV=production
   RAILS_MASTER_KEY=a241e335d7ca459953b4ada6149311d9
   BACKEND_API_URL=https://[백엔드-도메인].railway.app/api/v1
   RAILS_MAX_THREADS=5
   ```

3. **Public Domain 생성**
   - "Networking" 탭에서 도메인 생성

### 5단계: 백엔드 CORS 설정 업데이트

1. **백엔드 환경 변수에 추가**
   ```
   FRONTEND_URL=https://[프론트엔드-도메인].railway.app
   ```

### 6단계: GitHub Secrets 설정

1. **Railway Token 생성**
   - Railway Dashboard → Account → Tokens
   - "Create New Token" (이름: "GitHub Actions HSC1")

2. **GitHub Repository Secrets 추가**
   ```
   RAILWAY_TOKEN=[생성된 토큰]
   ```

### 7단계: 자동 배포 실행

1. **코드 커밋 및 푸시**
   ```bash
   git add .
   git commit -m "feat: Railway 배포 설정 완료"
   git push origin main
   ```

2. **배포 모니터링**
   - GitHub Actions 탭에서 워크플로우 실행 확인
   - Railway Dashboard에서 서비스 상태 확인

## 🔍 배포 후 검증

### 1. Health Check 확인
```bash
# 백엔드 Health Check
curl https://[backend-domain].railway.app/up
curl https://[backend-domain].railway.app/health/detailed

# 프론트엔드 접근 확인
curl -I https://[frontend-domain].railway.app
```

### 2. 기능 테스트
- [ ] 프론트엔드 로그인 페이지 접근
- [ ] 로그인 기능 (admin@hospital.com / password123)
- [ ] 대시보드 접근 및 API 통신
- [ ] AI 채팅 기능 테스트
- [ ] 주요 모듈 기능 확인

### 3. 성능 확인
- [ ] 페이지 로드 시간 < 3초
- [ ] API 응답 시간 < 500ms
- [ ] 메모리 사용량 정상 범위
- [ ] 에러율 < 1%

## 🛠️ 문제 해결

### 일반적인 오류들

#### 1. 데이터베이스 연결 오류
```
Error: could not connect to database
```
**해결방법**:
- DATABASE_URL 환경 변수 확인
- PostgreSQL 서비스 상태 확인
- 네트워크 연결 확인

#### 2. Asset 컴파일 오류
```
Error: Asset precompilation failed
```
**해결방법**:
- RAILS_MASTER_KEY 환경 변수 확인
- 빌드 로그에서 상세 에러 분석
- 로컬에서 에셋 컴파일 테스트:
  ```bash
  cd frontend
  RAILS_ENV=production rails assets:precompile
  ```

#### 3. CORS 오류
```
Access blocked by CORS policy
```
**해결방법**:
- Backend의 FRONTEND_URL 환경 변수 업데이트
- 정확한 도메인 주소 확인
- CORS 설정 파일 점검

### 로그 확인 방법
```bash
# Railway CLI로 로그 확인
railway logs --service backend
railway logs --service frontend

# 실시간 로그 모니터링
railway logs --follow --service backend
```

## 📊 모니터링 설정

### 1. Railway Dashboard 모니터링
- CPU 사용률
- 메모리 사용량
- 네트워크 트래픽
- 응답 시간

### 2. Custom Health Checks
```bash
# 상세 상태 확인
curl https://[backend].railway.app/health/detailed

# 버전 정보 확인
curl https://[backend].railway.app/health/version
```

### 3. 알림 설정
- Railway Dashboard에서 알림 규칙 설정
- GitHub Actions 실패 알림
- 성능 임계값 경고

## 🔄 지속적 배포

### 자동 배포 흐름
1. `main` 브랜치에 코드 푸시
2. GitHub Actions 자동 실행
3. 백엔드 → 프론트엔드 순차 배포
4. Health Check 실행
5. 성공/실패 알림

### 수동 배포
```bash
# Railway CLI로 수동 배포
railway up --service backend
railway up --service frontend
```

## 🛡️ 보안 관리

### 정기적 점검사항
- [ ] 환경 변수 보안성 재검토
- [ ] 의존성 취약점 스캔
- [ ] 접근 권한 재검토
- [ ] SSL 인증서 상태 확인

### 보안 스캔 실행
```bash
# 의존성 취약점 검사
cd backend && bundle audit
cd frontend && npm audit

# 코드 보안 검사
cd backend && brakeman
```

## 📈 성능 최적화

### 권장 설정
- **Backend**: RAILS_MAX_THREADS=10
- **Frontend**: RAILS_MAX_THREADS=5
- **Database**: Connection Pool 최적화
- **Caching**: Redis 추가 (선택사항)

### 모니터링 메트릭
- 응답 시간: < 500ms
- 메모리 사용량: < 512MB
- CPU 사용률: < 70%
- 데이터베이스 연결: < 80%

## 🎯 다음 단계

### 추가 개선사항
1. **Redis 캐시 서버 추가**
2. **CDN 설정** (에셋 최적화)
3. **백업 자동화** 설정
4. **부하 테스트** 실행
5. **성능 모니터링** 강화

### 운영 계획
- 정기적인 데이터베이스 백업
- 보안 패치 적용 일정
- 성능 모니터링 및 최적화
- 사용자 피드백 수집 및 개선

---

## 🎉 배포 완료!

축하합니다! HSC1 병원 관리 시스템이 Railway에 성공적으로 배포되었습니다.

**접속 정보**:
- **Frontend**: https://[your-frontend].railway.app
- **Backend API**: https://[your-backend].railway.app
- **API 문서**: https://[your-backend].railway.app/api-docs

**기본 계정**:
- Email: admin@hospital.com
- Password: password123

시스템이 정상적으로 작동하는지 확인하고, 필요에 따라 추가 설정을 진행하세요!