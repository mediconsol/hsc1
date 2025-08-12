# 🔧 GitHub Actions 배포 문제해결 가이드

Railway 배포 시 발생하는 GitHub Actions 오류 해결 방법입니다.

## 🚨 일반적인 오류들

### 1. "Backend status: failure" 오류

#### 원인:
- Railway 프로젝트가 생성되지 않음
- GitHub Secrets가 설정되지 않음  
- Railway CLI 인증 실패

#### 해결방법:

**Step 1: Railway 프로젝트 생성**
```bash
# Railway CLI 설치
npm install -g @railway/cli

# Railway 로그인
railway login

# 새 프로젝트 생성
railway new
```

**Step 2: GitHub Secrets 설정**
1. Railway Dashboard → Account → Tokens
2. "Create New Token" (이름: "GitHub Actions HSC1")
3. 토큰 복사
4. GitHub Repository → Settings → Secrets and Variables → Actions
5. "New repository secret" 클릭:
   ```
   Name: RAILWAY_TOKEN
   Secret: [복사한 토큰]
   ```

**Step 3: Railway 프로젝트 ID 설정 (선택사항)**
```bash
# 프로젝트 ID 확인
railway status

# GitHub Secrets에 추가
Name: RAILWAY_PROJECT_ID
Secret: [프로젝트 ID]
```

### 2. "railway up" 명령 실패

#### 에러 메시지:
```
Error: No Railway project connected
```

#### 해결방법:
1. **Railway 프로젝트를 GitHub Repository와 연결**:
   - Railway Dashboard → 프로젝트 선택
   - "Settings" → "Environment" 
   - "Connect Repo" → GitHub → hsc1 선택

2. **Root Directory 설정**:
   - Backend 서비스: Root Directory = `/backend`
   - Frontend 서비스: Root Directory = `/frontend`

### 3. Railway CLI 인증 오류

#### 에러 메시지:
```
❌ Railway authentication failed
```

#### 해결방법:
1. **토큰 유효성 확인**:
   ```bash
   # 로컬에서 테스트
   railway login --token [YOUR_TOKEN]
   railway list
   ```

2. **새 토큰 생성**:
   - Railway Dashboard → Account → Tokens
   - 기존 토큰 삭제 후 새로 생성
   - GitHub Secrets 업데이트

### 4. 서비스 배포 실패

#### 에러 메시지:
```
❌ Backend deployment failed
```

#### 해결방법:
1. **nixpacks.toml 확인**:
   ```toml
   # backend/nixpacks.toml
   [providers]
   ruby = "3.4.5"
   
   [variables]
   PORT = "7001"
   
   [build]
   cmd = "bundle install && chmod +x bin/railway-setup"
   
   [start]
   cmd = "bin/railway-setup && bundle exec rails server -b 0.0.0.0 -p $PORT"
   ```

2. **환경 변수 설정 확인**:
   - Railway Dashboard → 서비스 → Variables
   - 필수 환경 변수들이 모두 설정되었는지 확인

## 🛠️ 단계별 해결 프로세스

### Phase 1: 기본 설정 확인
```bash
# 1. Railway CLI 설치 및 로그인
npm install -g @railway/cli
railway login

# 2. 프로젝트 생성 (없는 경우)
railway new hsc1

# 3. 프로젝트 상태 확인
railway status
```

### Phase 2: GitHub 설정
1. **Repository Secrets 설정**:
   - `RAILWAY_TOKEN`: Railway API 토큰
   - `RAILWAY_PROJECT_ID`: 프로젝트 ID (선택사항)

2. **Repository와 Railway 연결**:
   - Railway Dashboard에서 GitHub repo 연결
   - Root directory 설정

### Phase 3: 서비스 설정
1. **PostgreSQL 데이터베이스 추가**:
   - Railway Dashboard → Add Service → Database → PostgreSQL

2. **환경 변수 설정**:
   - Backend: RAILS_MASTER_KEY, DATABASE_URL 등
   - Frontend: RAILS_MASTER_KEY, BACKEND_API_URL 등

### Phase 4: 배포 테스트
1. **Manual Workflow 실행**:
   - GitHub Actions 탭 → "Deploy to Railway" → "Run workflow"

2. **로그 확인**:
   - 각 단계별 로그 자세히 확인
   - 실패 지점 파악

## 🔍 디버깅 팁

### 로그 분석 방법
```bash
# GitHub Actions에서 확인할 로그들:
📦 Installing Railway CLI...          # CLI 설치 확인
🔐 Authenticating with Railway...     # 인증 상태 확인
📋 Railway projects:                  # 프로젝트 목록 확인
🔗 Linking to Railway project:        # 프로젝트 연결 확인  
📤 Deploying backend service...       # 배포 시작 확인
✅ Backend deployment initiated       # 배포 성공 확인
```

### 로컬에서 테스트
```bash
# 로컬에서 Railway 명령 테스트
cd backend
railway login --token [YOUR_TOKEN]
railway link [PROJECT_ID]
railway status
railway up --detach
```

### 일반적인 실패 패턴
1. **인증 실패**: RAILWAY_TOKEN 문제
2. **프로젝트 연결 실패**: 프로젝트가 존재하지 않음
3. **빌드 실패**: nixpacks.toml 설정 오류
4. **환경 변수 오류**: 필수 변수 누락

## 📋 체크리스트

### 배포 전 확인사항
- [ ] Railway 계정 생성 완료
- [ ] Railway 프로젝트 생성 완료
- [ ] PostgreSQL 데이터베이스 추가 완료
- [ ] GitHub Repository와 Railway 연결 완료
- [ ] RAILWAY_TOKEN secret 설정 완료
- [ ] Master Key 파일들 존재 확인
- [ ] nixpacks.toml 파일들 존재 확인

### 배포 후 확인사항
- [ ] GitHub Actions 워크플로우 성공
- [ ] Railway 서비스들 정상 실행 중
- [ ] Health Check 엔드포인트 응답 확인
- [ ] 환경 변수 올바르게 설정됨

## 🆘 추가 지원

### 유용한 리소스
- [Railway Documentation](https://docs.railway.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Railway Discord](https://discord.gg/railway)

### 로그 수집 방법
```bash
# Railway 로그 확인
railway logs --service backend
railway logs --service frontend

# GitHub Actions 로그
# Repository → Actions → 실패한 워크플로우 → 단계별 로그 확인
```

### 긴급 복구 방법
1. **워크플로우 비활성화**:
   - `.github/workflows/railway-deploy.yml` 파일 임시 삭제

2. **수동 배포**:
   ```bash
   railway up --service backend
   railway up --service frontend
   ```

3. **롤백**:
   ```bash
   railway rollback --service backend
   railway rollback --service frontend
   ```

---

**💡 팁**: 문제가 지속되면 GitHub Actions에서 "Re-run failed jobs"를 시도해보세요. 일시적인 네트워크 오류인 경우가 많습니다.