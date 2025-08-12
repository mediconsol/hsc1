# 배포 검증 체크리스트

Railway 배포를 위한 사전 점검 및 배포 후 검증 체크리스트입니다.

## 📋 사전 점검 (Pre-deployment Checklist)

### 1. 로컬 환경 테스트 ✅
- [ ] Backend 서버 정상 구동 (포트 7001)
- [ ] Frontend 서버 정상 구동 (포트 7002)
- [ ] 데이터베이스 연결 확인
- [ ] API 엔드포인트 테스트
- [ ] AI 채팅 기능 테스트
- [ ] JWT 인증 시스템 테스트

### 2. 코드 품질 검증 ✅
- [ ] Git 상태 정리 (모든 변경사항 커밋)
- [ ] 테스트 케이스 실행 (`bundle exec rspec`)
- [ ] 린트 검사 통과
- [ ] 보안 취약점 스캔
- [ ] 의존성 업데이트 확인

### 3. 설정 파일 검증 ✅
- [ ] `backend/nixpacks.toml` 설정 확인
- [ ] `frontend/nixpacks.toml` 설정 확인
- [ ] `.github/workflows/railway-deploy.yml` 검증
- [ ] `.railway/railway.json` 설정 확인
- [ ] `docker-compose.yml` 동작 확인

### 4. 환경 변수 준비 ✅
- [ ] `backend/config/master.key` 파일 존재 확인
- [ ] `frontend/config/master.key` 파일 존재 확인
- [ ] JWT_SECRET 키 준비
- [ ] 필수 환경 변수 목록 작성

## 🚀 배포 실행 단계

### 1. Railway 프로젝트 설정
```bash
# Railway CLI 설치 및 로그인
npm install -g @railway/cli
railway login

# 프로젝트 연결
railway link [project-id]
```

### 2. GitHub Repository 설정
- [ ] Repository를 Railway에 연결
- [ ] GitHub Secrets 설정 완료 (`RAILWAY_TOKEN`)
- [ ] 브랜치 보호 규칙 설정
- [ ] Actions 권한 설정 확인

### 3. Railway 서비스 생성
- [ ] PostgreSQL 데이터베이스 생성
- [ ] Backend 서비스 생성 (Root Directory: `/backend`)
- [ ] Frontend 서비스 생성 (Root Directory: `/frontend`)
- [ ] 각 서비스에 Public Domain 설정

### 4. 환경 변수 설정
#### Backend Service:
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
GEMINI_API_KEY=[Gemini API Key]
```

#### Frontend Service:
```
RAILS_ENV=production
RAILS_MASTER_KEY=[frontend/config/master.key 내용]
BACKEND_API_URL=https://[backend-domain].railway.app/api/v1
RAILS_MAX_THREADS=5
```

## ✅ 배포 후 검증

### 1. Backend 서비스 검증
- [ ] Health Check: `https://[backend-domain].railway.app/up`
- [ ] API 문서: `https://[backend-domain].railway.app/api-docs`
- [ ] 데이터베이스 마이그레이션 성공 확인
- [ ] 로그에서 에러 없음 확인

#### 테스트 API 호출:
```bash
# Health Check
curl https://[backend-domain].railway.app/up

# API 테스트 (로그인)
curl -X POST https://[backend-domain].railway.app/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@hospital.com","password":"password123"}'
```

### 2. Frontend 서비스 검증
- [ ] 메인 페이지 로드: `https://[frontend-domain].railway.app`
- [ ] 로그인 페이지 정상 표시
- [ ] CSS/JS 에셋 정상 로드
- [ ] 반응형 디자인 확인

#### 브라우저 테스트:
- [ ] 로그인 기능 (admin@hospital.com / password123)
- [ ] 대시보드 접근
- [ ] 사이드바 메뉴 동작
- [ ] API 호출 성공 (개발자 도구에서 확인)

### 3. 통합 기능 테스트
- [ ] 사용자 인증 플로우
- [ ] 공지사항 조회/작성
- [ ] AI 채팅 기능
- [ ] 전자결재 워크플로우
- [ ] 시설/자산 관리
- [ ] 예산/재무 관리

### 4. 성능 및 안정성 검증
- [ ] 페이지 로드 시간 < 3초
- [ ] API 응답 시간 < 500ms
- [ ] 메모리 사용량 모니터링
- [ ] CPU 사용율 확인
- [ ] 에러율 < 1%

## 🔧 문제 해결

### 일반적인 배포 오류

#### 1. 데이터베이스 연결 실패
```
Error: could not connect to database
```
**해결방법**:
- DATABASE_URL 환경 변수 확인
- PostgreSQL 서비스 상태 확인
- 네트워크 연결 확인

#### 2. Asset 컴파일 실패
```
Error: Asset precompilation failed
```
**해결방법**:
- RAILS_MASTER_KEY 환경 변수 확인
- 빌드 로그에서 상세 에러 분석
- 로컬에서 에셋 컴파일 테스트

#### 3. CORS 오류
```
Access to fetch at 'api-url' from origin 'frontend-url' has been blocked by CORS policy
```
**해결방법**:
- Backend의 FRONTEND_URL 환경 변수 업데이트
- CORS 설정 파일 확인
- 도메인 주소 정확성 검증

#### 4. JWT 토큰 오류
```
Error: Invalid or expired token
```
**해결방법**:
- JWT_SECRET 환경 변수 확인
- 토큰 만료 시간 설정 확인
- 클라이언트 localStorage 초기화

### 모니터링 도구
- **Railway Dashboard**: 실시간 로그 및 메트릭
- **GitHub Actions**: 배포 상태 및 히스토리
- **Browser DevTools**: 클라이언트 사이드 에러
- **Railway CLI**: 터미널에서 로그 확인

```bash
# Railway CLI로 로그 확인
railway logs --service backend
railway logs --service frontend

# 실시간 로그 모니터링
railway logs --follow --service backend
```

## 🎯 성공 기준

### 배포 성공 확인
- ✅ 모든 서비스가 정상 실행 중
- ✅ Health check API 응답 200 OK
- ✅ 프론트엔드 페이지 정상 로드
- ✅ 로그인 및 주요 기능 동작
- ✅ API 통신 정상
- ✅ 데이터베이스 연결 및 데이터 조회 가능

### 사용자 수용 테스트
- [ ] 관리자 계정으로 로그인
- [ ] 대시보드에서 전체 현황 확인
- [ ] 각 모듈별 기본 기능 테스트
- [ ] AI 채팅 기능 정상 작동
- [ ] 데이터 입력/수정/삭제 가능
- [ ] 권한별 접근 제어 확인

## 📝 배포 완료 후 작업

### 1. 문서 업데이트
- [ ] README.md 배포 정보 업데이트
- [ ] API 문서 URL 업데이트
- [ ] 팀원에게 배포 완료 공지

### 2. 모니터링 설정
- [ ] 알림 설정 (에러율, 응답시간)
- [ ] 백업 스케줄 설정
- [ ] 성능 모니터링 대시보드 설정

### 3. 보안 점검
- [ ] SSL 인증서 확인
- [ ] 환경 변수 보안성 검토
- [ ] 접근 권한 재검토
- [ ] 민감 정보 노출 여부 확인

---

## 🔄 정기 점검 계획

- **일일**: 서비스 상태 및 로그 확인
- **주간**: 성능 메트릭 분석
- **월간**: 보안 업데이트 및 의존성 점검
- **분기별**: 전체 시스템 리뷰 및 최적화