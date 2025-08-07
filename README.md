# 병원 통합 관리 시스템 (Hospital Management System)

병원 내부 통합 운영 시스템을 위한 그룹웨어 솔루션입니다.

[![CI Status](https://github.com/hospital/hms/workflows/CI/badge.svg)](https://github.com/hospital/hms/actions)
[![Coverage Status](https://codecov.io/gh/hospital/hms/branch/main/graph/badge.svg)](https://codecov.io/gh/hospital/hms)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [기술 스택](#️-기술-스택)
- [프로젝트 구조](#️-프로젝트-구조)
- [개발 환경 설정](#-개발-환경-설정)
- [API 문서](#-api-문서)
- [테스트](#-테스트)
- [배포](#-배포)
- [개발 가이드라인](#-개발-가이드라인)

## 🚀 프로젝트 개요

병원 내부 통합 운영을 위한 현대적인 그룹웨어 솔루션으로, 직원 관리, 휴가 신청, 출근 관리, 문서 관리 등의 핵심 기능을 제공합니다.

### 주요 특징

- **🔐 JWT 기반 인증**: 안전한 토큰 기반 사용자 인증
- **👥 역할 기반 권한 관리**: admin, manager, staff, read_only 4단계 권한
- **📊 실시간 대시보드**: 출근 현황, 휴가 통계 등 실시간 모니터링
- **📱 반응형 웹 디자인**: 모바일과 데스크톱 최적화
- **🧪 포괄적인 테스트**: 50+ 테스트 케이스로 95%+ 코드 커버리지
- **🔄 CI/CD 파이프라인**: GitHub Actions을 통한 자동화된 테스트 및 배포
- **📖 API 문서**: OpenAPI/Swagger 기반 상세 API 문서
- **🐳 Docker 지원**: 컨테이너 기반 개발 및 배포 환경

## 🛠️ 기술 스택

### 백엔드 (포트 7001)
- **Framework**: Ruby on Rails 8.0.2 (API 모드)
- **Database**: PostgreSQL 15
- **Authentication**: JWT (JSON Web Token)
- **Language**: Ruby 3.2+
- **Testing**: Minitest + Factory Bot + Faker
- **Documentation**: RSwag (OpenAPI/Swagger)
- **Security**: Brakeman + RuboCop
- **Performance**: Benchmark-ips

### 프론트엔드 (포트 7002)
- **Framework**: Rails with Hotwire (Turbo + Stimulus)
- **Styling**: Tailwind CSS
- **Language**: Ruby + JavaScript/TypeScript
- **Testing**: System Tests with Capybara

### 인프라 & 도구
- **Container**: Docker + Docker Compose
- **Cache/Queue**: Redis 7
- **CI/CD**: GitHub Actions
- **Code Quality**: RuboCop + ESLint
- **Security Scanning**: Trivy + Brakeman
- **Coverage**: SimpleCov + Codecov

## 🏗️ 프로젝트 구조

```
hsc1/
├── backend/              # Rails API 서버 (포트 7001)
│   ├── app/
│   │   ├── controllers/  # API 컨트롤러
│   │   ├── models/       # 데이터 모델
│   │   └── services/     # 비즈니스 로직
│   ├── config/           # 설정 파일
│   ├── db/               # 마이그레이션 & 시드
│   ├── test/             # 테스트 파일
│   │   ├── factories/    # Factory Bot 팩토리
│   │   ├── fixtures/     # 테스트 픽스처
│   │   ├── models/       # 모델 테스트
│   │   ├── controllers/  # 컨트롤러 테스트
│   │   ├── integration/  # 통합 테스트
│   │   └── performance/  # 성능 테스트
│   ├── swagger/          # OpenAPI 문서
│   └── Dockerfile
├── frontend/             # Rails 프론트엔드 (포트 7002)
│   ├── app/
│   ├── config/
│   └── Dockerfile
├── docs/                 # 프로젝트 문서
│   ├── api/              # API 상세 문서
│   ├── deployment/       # 배포 가이드
│   └── postman/          # Postman 컬렉션
├── .github/
│   └── workflows/        # CI/CD 파이프라인
├── docker-compose.yml    # 개발 환경 설정
├── docker-compose.prod.yml # 운영 환경 설정
└── README.md
```

## 🚀 개발 환경 설정

### 시스템 요구사항

- **Ruby**: 3.2 이상
- **Node.js**: 18 이상
- **PostgreSQL**: 15 이상
- **Redis**: 7 이상 (선택사항)
- **Docker**: 20.10 이상 (Docker 사용 시)

### 1. Docker를 사용한 설정 (권장)

```bash
# 프로젝트 클론
git clone <repository-url>
cd hsc1

# 환경 변수 파일 생성
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# Docker 컨테이너 실행
docker-compose up -d

# 데이터베이스 설정 (백엔드)
docker-compose exec backend rails db:create db:migrate db:seed

# 데이터베이스 설정 (프론트엔드)  
docker-compose exec frontend rails db:create db:migrate

# 서비스 확인
docker-compose ps

# 로그 확인
docker-compose logs -f backend
```

**접속 URL:**
- 백엔드 API: http://localhost:7001
- 프론트엔드: http://localhost:7002
- API 문서: http://localhost:7001/api-docs

### 2. 로컬 환경 설정

#### 사전 준비

```bash
# PostgreSQL 설치 및 실행 (macOS)
brew install postgresql@15
brew services start postgresql@15

# PostgreSQL 설치 및 실행 (Ubuntu)
sudo apt-get install postgresql-15 postgresql-contrib
sudo systemctl start postgresql

# Redis 설치 (선택사항)
brew install redis  # macOS
sudo apt-get install redis-server  # Ubuntu
```

#### 백엔드 설정

```bash
cd backend

# Ruby 버전 확인
ruby -v  # Ruby 3.2+ 필요

# Bundler 설치
gem install bundler

# 의존성 설치
bundle install

# 환경 변수 설정
cp .env.example .env
# .env 파일을 편집하여 데이터베이스 설정 등을 구성

# 데이터베이스 생성 및 마이그레이션
rails db:create
rails db:migrate
rails db:seed

# 서버 실행 (포트 7001)
rails server -p 7001

# 별도 터미널에서 테스트 실행
bundle exec rails test
```

#### 프론트엔드 설정

```bash
cd frontend

# 의존성 설치
bundle install

# Node.js 의존성 설치
npm install

# Tailwind CSS 설치
rails tailwindcss:install

# 환경 변수 설정
cp .env.example .env

# 데이터베이스 설정
rails db:create db:migrate

# 서버 실행 (포트 7002)
rails server -p 7002

# 별도 터미널에서 Tailwind 빌드 (개발 모드)
rails tailwindcss:watch
```

## 🔐 기본 사용자 계정

시스템에는 다음과 같은 기본 사용자 계정이 생성됩니다:

| 권한 | 이메일 | 비밀번호 | 설명 |
|------|--------|----------|------|
| **admin** | admin@hospital.com | password123 | 시스템 전체 관리자 |
| **manager** | manager@hospital.com | password123 | 부서 관리자 |
| **staff** | staff@hospital.com | password123 | 일반 직원 |
| **read_only** | readonly@hospital.com | password123 | 읽기 전용 사용자 |

## 📋 주요 기능

### ✅ Phase 1: 기본 시스템 (완료)
- [x] **사용자 인증 시스템**: JWT 기반 로그인/로그아웃
- [x] **권한 관리**: 4단계 역할 기반 접근 제어
- [x] **직원 관리**: CRUD 작업, 검색, 필터링
- [x] **휴가 신청 관리**: 신청, 승인, 반려, 통계
- [x] **출근 관리**: 체크인/체크아웃, 출근 통계
- [x] **공지사항**: 병원 공지사항 관리
- [x] **문서 관리**: 파일 업로드, 승인 워크플로우

### 🚧 Phase 2: 내부 행정 시스템 (진행 중)
- [ ] **대시보드**: 실시간 현황 모니터링
- [ ] **전자결재 시스템**: 다단계 승인 프로세스
- [ ] **예산/재무 관리**: 병원 예산 관리 시스템
- [ ] **시설/자산 관리**: 장비 및 시설 관리

### 🔮 Phase 3: 확장 기능 (예정)
- [ ] **예약·문진 관리**: 환자 예약 및 문진표
- [ ] **상담/CRM 시스템**: 환자 관계 관리
- [ ] **인사·급여**: 급여 계산 및 지급
- [ ] **재고·구매 관리**: 의료 용품 재고 관리

## 📖 API 문서

### 🌐 API 엔드포인트 개요

완전한 API 문서는 [Swagger UI](http://localhost:7001/api-docs)에서 확인할 수 있습니다.

#### 인증 API
- `POST /api/v1/auth/login` - 사용자 로그인 및 JWT 토큰 발급
- `GET /api/v1/auth/me` - 현재 사용자 정보 조회
- `DELETE /api/v1/auth/logout` - 로그아웃 및 토큰 무효화

#### 직원 관리 API
- `GET /api/v1/employees` - 직원 목록 조회 (필터링, 검색, 페이징)
- `POST /api/v1/employees` - 새 직원 등록 (admin 권한)
- `GET /api/v1/employees/:id` - 직원 상세 정보 조회
- `PATCH /api/v1/employees/:id` - 직원 정보 수정 (admin 권한)
- `DELETE /api/v1/employees/:id` - 직원 삭제 (admin 권한)

#### 휴가 신청 API
- `GET /api/v1/leave_requests` - 휴가 신청 목록 조회
- `POST /api/v1/leave_requests` - 새 휴가 신청 생성
- `GET /api/v1/leave_requests/statistics` - 휴가 통계 조회
- `GET /api/v1/leave_requests/annual_leave_status` - 연차 현황 조회
- `PATCH /api/v1/leave_requests/:id/approve` - 휴가 승인 (manager 권한)
- `PATCH /api/v1/leave_requests/:id/reject` - 휴가 반려 (manager 권한)

#### 출근 관리 API
- `POST /api/v1/attendances/check_in` - 출근 체크인
- `POST /api/v1/attendances/check_out` - 퇴근 체크아웃
- `GET /api/v1/attendances/statistics` - 출근 통계
- `GET /api/v1/attendances/today_status` - 오늘 출근 현황

### 📝 Postman 컬렉션

API 테스트를 위한 Postman 컬렉션이 제공됩니다:
- 파일 위치: `docs/postman/Hospital_Management_System.postman_collection.json`
- 자동 토큰 관리 및 환경 변수 설정 포함
- 모든 API 엔드포인트에 대한 예제 요청 및 테스트 스크립트

## 🧪 테스트

### 테스트 실행

```bash
cd backend

# 모든 테스트 실행
bundle exec rails test

# 특정 테스트 카테고리 실행
bundle exec rails test test/models/          # 모델 테스트
bundle exec rails test test/controllers/     # 컨트롤러 테스트
bundle exec rails test test/integration/     # 통합 테스트
bundle exec rails test test/performance/     # 성능 테스트

# 커버리지 리포트와 함께 실행
bundle exec rails test:coverage

# Factory Bot 유효성 검사
bundle exec rails test test/factories/
```

### 테스트 커버리지

- **현재 커버리지**: 95%+
- **목표 커버리지**: 90% 이상
- **리포트 위치**: `backend/coverage/index.html`

### CI/CD 파이프라인

GitHub Actions를 통한 자동화된 테스트:
- **백엔드 테스트**: 모델, 컨트롤러, 통합 테스트
- **보안 스캔**: Brakeman, Trivy
- **코드 품질**: RuboCop, 커버리지 분석
- **성능 테스트**: 자동화된 벤치마크
- **Docker 빌드 테스트**: 멀티 스테이지 빌드 검증

## 🔧 개발 명령어

### 백엔드 개발
```bash
cd backend

# 서버 실행
rails server -p 7001

# 개발용 콘솔
rails console

# 데이터베이스 관련
rails db:create               # DB 생성
rails db:migrate             # 마이그레이션 실행
rails db:seed                # 시드 데이터 생성
rails db:reset               # DB 초기화 후 시드

# 코드 생성
rails generate migration MigrationName
rails generate model ModelName
rails generate controller ControllerName

# 코드 품질
bundle exec rubocop           # 코드 스타일 검사
bundle exec rubocop -a       # 자동 수정
bundle exec brakeman         # 보안 스캔

# API 문서 생성
bundle exec rails rswag:specs:swaggerize
```

### 프론트엔드 개발
```bash
cd frontend

# 서버 실행
rails server -p 7002

# 자산 빌드
rails tailwindcss:build     # CSS 빌드
rails tailwindcss:watch     # CSS 실시간 빌드
rails assets:precompile     # 프로덕션용 자산 빌드

# JavaScript 관련
npm install                  # 의존성 설치
npm run lint                # ESLint 실행
npm run test                # JavaScript 테스트

# 시스템 테스트
bundle exec rails test:system
```

## 📦 배포

### Docker 기반 배포 (권장)

```bash
# 개발 환경
docker-compose up -d

# 프로덕션 환경
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# 이미지 빌드
docker-compose build --no-cache

# 특정 서비스만 재시작
docker-compose restart backend
docker-compose restart frontend

# 로그 확인
docker-compose logs -f backend
docker-compose logs -f frontend
```

### 수동 배포

```bash
# 백엔드 배포 준비
cd backend
bundle install --deployment --without development test
rails assets:precompile RAILS_ENV=production
rails db:migrate RAILS_ENV=production

# 프론트엔드 배포 준비
cd frontend
bundle install --deployment --without development test
npm ci --production
rails assets:precompile RAILS_ENV=production
```

### 환경 변수 설정

**백엔드 (.env)**
```bash
RAILS_ENV=production
DATABASE_URL=postgresql://username:password@localhost/hospital_production
JWT_SECRET=your_jwt_secret_key
REDIS_URL=redis://localhost:6379/0
```

**프론트엔드 (.env)**
```bash
RAILS_ENV=production
API_BASE_URL=https://api.hospital.com
```

## 📝 개발 가이드라인

### 코딩 표준
1. **Ruby 코드**: [RuboCop Rails Omakase](https://github.com/rails/rubocop-rails-omakase) 규칙 준수
2. **JavaScript**: ESLint 기본 규칙 + Prettier
3. **API 설계**: RESTful 원칙, OpenAPI 3.0 스펙 준수
4. **데이터베이스**: 정규화, 인덱스 최적화, 마이그레이션 역순 호환성

### Git 워크플로우
1. **브랜치 전략**: 
   - `main`: 프로덕션 브랜치
   - `develop`: 개발 통합 브랜치
   - `feature/*`: 기능 개발 브랜치
   - `hotfix/*`: 긴급 수정 브랜치

2. **커밋 메시지 규칙**:
   ```
   feat: 새 기능 추가
   fix: 버그 수정
   docs: 문서 수정
   style: 코드 스타일 변경
   refactor: 코드 리팩토링
   test: 테스트 추가/수정
   chore: 기타 작업
   ```

### 테스트 작성 규칙
1. **모든 새 기능**: 해당 테스트 작성 필수
2. **버그 수정**: 회귀 테스트 추가
3. **Factory Bot**: 테스트 데이터 생성에 활용
4. **테스트 커버리지**: 90% 이상 유지

### 코드 리뷰 체크리스트
- [ ] 기능이 요구사항을 충족하는가?
- [ ] 테스트가 적절히 작성되었는가?
- [ ] 보안 취약점이 없는가?
- [ ] 성능상 문제가 없는가?
- [ ] 코드 스타일이 일관성 있는가?
- [ ] 문서가 업데이트되었는가?

## 🔒 보안

### 보안 기능
- **JWT 토큰 인증**: 안전한 사용자 인증 및 세션 관리
- **역할 기반 접근 제어**: 4단계 권한 레벨로 세분화된 접근 제어
- **SQL 인젝션 방지**: Active Record ORM 사용으로 기본 보호
- **CORS 정책**: 적절한 Cross-Origin 요청 제어
- **보안 헤더**: Rack middleware를 통한 보안 헤더 설정

### 보안 스캔
- **Brakeman**: Ruby 코드 정적 보안 분석
- **Trivy**: 컨테이너 이미지 취약점 스캔
- **Bundler Audit**: Gem 의존성 취약점 검사
- **npm audit**: JavaScript 의존성 취약점 검사

### 보안 모니터링
```bash
# 정기 보안 스캔 실행
cd backend
bundle exec brakeman
bundle audit check --update

cd frontend  
npm audit
```

## 📊 성능 모니터링

### 성능 메트릭
- **API 응답 시간**: 평균 < 200ms
- **데이터베이스 쿼리**: N+1 쿼리 최적화
- **메모리 사용량**: 서버당 < 512MB
- **동시 연결**: 1000+ 연결 지원

### 성능 테스트
```bash
cd backend
bundle exec rails test test/performance/
bundle exec ruby scripts/benchmark.rb
```

## 🤝 기여하기

프로젝트에 기여해주셔서 감사합니다! 다음 단계를 따라주세요:

### 기여 절차
1. **이슈 생성**: 버그 리포트나 기능 요청사항 등록
2. **Fork**: 프로젝트를 개인 계정으로 Fork
3. **브랜치 생성**: 
   ```bash
   git checkout -b feature/amazing-feature
   git checkout -b fix/bug-description
   ```
4. **개발**: 
   - 코드 작성 및 테스트 추가
   - 코드 스타일 가이드 준수
   - 커밋 메시지 규칙 준수
5. **테스트**: 모든 테스트 통과 확인
   ```bash
   bundle exec rails test
   bundle exec rubocop
   ```
6. **Pull Request**: 상세한 설명과 함께 PR 생성

### 기여 가이드라인
- 모든 새 기능에는 테스트가 포함되어야 합니다
- 기존 테스트를 깨뜨리지 않아야 합니다
- 코드 커버리지를 유지하거나 개선해야 합니다
- API 변경사항은 문서도 함께 업데이트해야 합니다

## ❓ FAQ

### Q: 개발 환경에서 데이터베이스 연결 오류가 발생합니다
A: PostgreSQL이 실행 중인지 확인하고, `config/database.yml`의 설정을 확인해주세요.

### Q: JWT 토큰이 만료되었다는 오류가 나타납니다
A: 기본 토큰 만료 시간은 24시간입니다. 로그인을 다시 하거나 refresh 토큰을 사용해주세요.

### Q: API 문서는 어디에서 확인할 수 있나요?
A: 백엔드 서버 실행 후 http://localhost:7001/api-docs 에서 확인하실 수 있습니다.

### Q: 테스트는 어떻게 실행하나요?
A: `bundle exec rails test` 명령어로 모든 테스트를 실행할 수 있습니다.

## 📞 지원

- **이슈 트래커**: [GitHub Issues](https://github.com/hospital/hms/issues)
- **위키**: [프로젝트 위키](https://github.com/hospital/hms/wiki)
- **이메일**: dev-team@hospital.com

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🙏 감사의 말

이 프로젝트는 다음 오픈소스 프로젝트들의 도움을 받아 개발되었습니다:
- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
- [Factory Bot](https://github.com/thoughtbot/factory_bot)
- [RSwag](https://github.com/rswag/rswag)