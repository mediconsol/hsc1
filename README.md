# Hospital Management System (HSC1)

병원 관리 시스템 - Ruby on Rails 기반 풀스택 애플리케이션

[![CI Status](https://github.com/hospital/hms/workflows/CI/badge.svg)](https://github.com/hospital/hms/actions)
[![Coverage Status](https://codecov.io/gh/hospital/hms/branch/main/graph/badge.svg)](https://codecov.io/gh/hospital/hms)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [시스템 아키텍처](#-시스템-아키텍처)
- [기술 스택](#️-기술-스택)
- [개발 환경 설정](#-개발-환경-설정)
- [인증 시스템](#-인증-시스템)
- [API 문서](#-api-문서)
- [테스트](#-테스트)
- [배포](#-배포)
- [문제 해결](#-문제-해결)
- [프로젝트 전송](#-프로젝트-전송)

## 🚀 프로젝트 개요

HSC1은 병원 운영을 위한 종합 관리 시스템으로, 환자 관리, 의료진 관리, 예약 시스템, 전자결재 등의 기능을 제공하는 웹 애플리케이션입니다.

### 주요 기능
- 🔐 JWT 기반 인증/권한 관리
- 👥 사용자 및 역할 관리 (읽기전용, 직원, 관리자, 시스템관리자)
- 🏥 환자 정보 관리
- 👨‍⚕️ 의료진 관리
- 📅 예약 시스템
- 📄 전자결재 시스템
- 💼 휴가 관리 시스템
- 📊 대시보드 및 통계

### 주요 특징
- **🔐 클라이언트사이드 JWT 인증**: localStorage 기반 토큰 관리
- **👥 4단계 역할 관리**: read_only, staff, manager, admin
- **📊 실시간 대시보드**: 병원 운영 현황 모니터링
- **📱 반응형 디자인**: Tailwind CSS 기반 모바일 최적화
- **🧪 종합 테스트**: 57개 테스트 케이스, Factory Bot 활용
- **📖 API 문서화**: OpenAPI/Swagger 자동 생성
- **🐳 Docker 지원**: 개발/운영 환경 컨테이너화

## 🏗️ 시스템 아키텍처

```
HSC1/
├── backend/          # Rails API 서버 (포트 7001)
└── frontend/         # Rails View 애플리케이션 (포트 7002)
```

### 인증 흐름
1. 프론트엔드(7002) → 로그인 페이지 (사이드바 없음)
2. 로그인 → 백엔드(7001) API → JWT 토큰 발급
3. 클라이언트 localStorage에 토큰 저장
4. 인증된 사용자 → 대시보드 (사이드바 포함)
5. API 요청 시 Bearer 토큰으로 인증

## 🛠️ 기술 스택

### Backend (API Server - 포트 7001)
- **Framework**: Ruby on Rails 8.0.0 (API 모드)
- **Database**: PostgreSQL
- **Authentication**: JWT (JSON Web Token)
- **Language**: Ruby 3.2.0
- **Testing**: RSpec + FactoryBot + Faker
- **Documentation**: RSwag (OpenAPI/Swagger)
- **Security**: Brakeman, 매개변수 검증

### Frontend (Web Application - 포트 7002)
- **Framework**: Ruby on Rails 8.0.0
- **UI**: Hotwire (Turbo + Stimulus)
- **Styling**: Tailwind CSS
- **Language**: Ruby + JavaScript ES6+
- **Authentication**: Client-side JWT 관리

### DevOps & Tools
- **Container**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **Version Control**: Git
- **Testing**: 57개 테스트 케이스

## 📁 프로젝트 구조

```
hsc1/
├── backend/                 # Rails API 서버
│   ├── app/
│   │   ├── controllers/     # API 컨트롤러
│   │   ├── models/         # 데이터 모델
│   │   ├── services/       # 비즈니스 로직
│   │   └── serializers/    # JSON 직렬화
│   ├── config/             # 설정 파일
│   ├── db/                 # 데이터베이스 마이그레이션
│   ├── spec/               # 테스트 파일 (57개)
│   │   ├── factories/      # Factory Bot 정의
│   │   ├── models/         # 모델 테스트
│   │   ├── controllers/    # 컨트롤러 테스트
│   │   └── requests/       # 통합 테스트
│   └── swagger/            # API 문서 스키마
├── frontend/               # Rails 웹 애플리케이션
│   ├── app/
│   │   ├── controllers/    # 웹 컨트롤러
│   │   ├── views/         # HTML 템플릿 (ERB)
│   │   │   ├── layouts/   # application.html.erb, login.html.erb
│   │   │   ├── home/      # index.html.erb, login.html.erb
│   │   │   └── shared/    # _sidebar.html.erb 등
│   │   ├── assets/        # CSS, JS, 이미지
│   │   └── javascript/    # JavaScript 모듈
│   │       └── modules/   # auth.js (AuthManager)
│   └── config/            # 라우팅, 환경 설정
├── .github/               # GitHub Actions CI/CD
├── .gitignore            # Git 제외 파일 목록
├── docker-compose.yml     # Docker 설정
└── README.md             # 이 파일
```

## 🚀 개발 환경 설정

### 1. 시스템 요구사항

- Ruby 3.2.0
- Node.js 18+ (Tailwind CSS용)
- PostgreSQL 13+
- Git

### 2. 프로젝트 클론

```bash
git clone <repository-url>
cd hsc1
```

### 3. 백엔드 설정

```bash
cd backend

# 의존성 설치
bundle install

# 데이터베이스 설정
rails db:create
rails db:migrate
rails db:seed

# 개발 서버 시작 (포트 7001)
rails server -p 7001
```

### 4. 프론트엔드 설정

```bash
cd ../frontend

# 의존성 설치
bundle install
npm install

# Tailwind CSS 빌드
npm run build:css

# 개발 서버 시작 (포트 7002)
rails server -p 7002
```

### 5. 환경 변수 설정

각 애플리케이션에 `.env` 파일을 생성하세요:

**backend/.env**
```
DATABASE_URL=postgresql://username:password@localhost/hsc1_development
JWT_SECRET=your_jwt_secret_key_here
RAILS_ENV=development
```

**frontend/.env**
```
RAILS_ENV=development
API_BASE_URL=http://localhost:7001
```

### 6. Docker를 사용한 설정 (대안)

```bash
# 전체 서비스 시작
docker-compose up -d

# 개별 서비스 시작
docker-compose up backend
docker-compose up frontend
```

### 접속 정보
- **프론트엔드**: http://localhost:7002
- **백엔드 API**: http://localhost:7001
- **API 문서**: http://localhost:7001/api-docs

## 🔐 인증 시스템

### 사용자 역할
- `0`: 읽기전용 (read_only)
- `1`: 직원 (staff)
- `2`: 관리자 (manager)
- `3`: 시스템관리자 (admin)

### 기본 계정
개발용 기본 계정은 `db:seed`로 생성됩니다:
- Email: admin@hospital.com
- Password: password123
- Role: 시스템관리자 (3)

### JWT 토큰 흐름
1. 로그인 시 `access_token`과 `refresh_token` 발급
2. 클라이언트에서 `localStorage`에 토큰 저장
3. API 요청 시 `Authorization: Bearer <token>` 헤더 사용
4. 토큰 만료 시 자동 갱신 또는 로그인 페이지 리다이렉트

## 📊 주요 기능 및 API 엔드포인트

### 인증 API
```
POST   /api/v1/auth/login     # 로그인
DELETE /api/v1/auth/logout    # 로그아웃
GET    /api/v1/auth/me        # 사용자 정보 조회
POST   /api/v1/auth/refresh   # 토큰 갱신
```

### 사용자 관리 API
```
GET    /api/v1/users          # 사용자 목록
POST   /api/v1/users          # 사용자 생성
GET    /api/v1/users/:id      # 사용자 조회
PUT    /api/v1/users/:id      # 사용자 수정
DELETE /api/v1/users/:id      # 사용자 삭제
```

### 환자 관리 API
```
GET    /api/v1/patients       # 환자 목록
POST   /api/v1/patients       # 환자 등록
GET    /api/v1/patients/:id   # 환자 정보 조회
PUT    /api/v1/patients/:id   # 환자 정보 수정
DELETE /api/v1/patients/:id   # 환자 삭제
```

### 의료진 관리 API
```
GET    /api/v1/medical_staff  # 의료진 목록
POST   /api/v1/medical_staff  # 의료진 등록
GET    /api/v1/medical_staff/:id   # 의료진 정보 조회
PUT    /api/v1/medical_staff/:id   # 의료진 정보 수정
DELETE /api/v1/medical_staff/:id   # 의룼진 삭제
```

### 휴가 관리 API
```
GET    /api/v1/vacations      # 휴가 목록
POST   /api/v1/vacations      # 휴가 신청
GET    /api/v1/vacations/:id  # 휴가 조회
PUT    /api/v1/vacations/:id  # 휴가 수정
DELETE /api/v1/vacations/:id  # 휴가 삭제
POST   /api/v1/vacations/:id/approve   # 휴가 승인
POST   /api/v1/vacations/:id/reject    # 휴가 반려
```

### 문서/전자결재 API
```
GET    /api/v1/documents      # 문서 목록
POST   /api/v1/documents      # 문서 생성
GET    /api/v1/documents/:id  # 문서 조회
PUT    /api/v1/documents/:id  # 문서 수정
DELETE /api/v1/documents/:id  # 문서 삭제
POST   /api/v1/documents/:id/request_approval  # 결재 요청
POST   /api/v1/documents/:id/approve           # 문서 승인
POST   /api/v1/documents/:id/reject            # 문서 반려
```

## 📖 API 문서화

Swagger/OpenAPI 문서는 다음 주소에서 확인할 수 있습니다:
- Development: http://localhost:7001/api-docs
- Swagger JSON: http://localhost:7001/api/v1/swagger.json

## 🧪 테스트

### 백엔드 테스트 실행
```bash
cd backend

# 모든 테스트 실행
bundle exec rspec

# 특정 테스트 실행
bundle exec rspec spec/models/user_spec.rb

# 커버리지 확인
bundle exec rspec --format documentation
```

### 테스트 커버리지
- 총 57개 테스트 케이스
- 모든 주요 모델 및 컨트롤러 테스트 포함
- Factory Bot을 사용한 테스트 데이터 생성

## 🔧 개발 도구

### 유용한 Rails 명령어
```bash
# 데이터베이스 리셋
rails db:drop db:create db:migrate db:seed

# 콘솔 접속
rails console

# 로그 확인
tail -f log/development.log

# 라우트 확인
rails routes
```

### 디버깅
- `byebug` 또는 `pry` 사용
- 로그 파일: `backend/log/development.log`
- 브라우저 개발자 도구 활용

## 🚀 배포

### Docker를 사용한 배포
```bash
# 전체 서비스 시작
docker-compose up -d

# 프로덕션 환경
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
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

### 프로덕션 환경 설정
1. 환경 변수를 프로덕션 값으로 변경
2. SECRET_KEY_BASE 설정
3. DATABASE_URL 설정
4. SSL/TLS 인증서 설정
5. CORS 정책 조정

## 🔒 보안 고려사항

- JWT 토큰의 안전한 저장 및 관리
- CORS 정책 설정
- SQL 인젝션 방지
- XSS 공격 방지
- CSRF 토큰 사용
- 비밀번호 해싱 (bcrypt)
- API 요청 제한 (Rate Limiting)

## 🚪 문제 해결

### 일반적인 문제들

1. **포트 충돌 에러**
   ```bash
   # 포트 사용 중인 프로세스 확인
   netstat -ano | findstr :7001
   # 프로세스 종료
   taskkill /PID <process_id> /F
   ```

2. **데이터베이스 연결 에러**
   - PostgreSQL 서비스 실행 상태 확인
   - 환경 변수 DATABASE_URL 확인
   - 데이터베이스 권한 확인

3. **JWT 토큰 에러**
   - JWT_SECRET 환경 변수 설정 확인
   - 토큰 만료 시간 확인
   - 브라우저 localStorage 확인

4. **CORS 에러**
   - backend/config/initializers/cors.rb 설정 확인
   - 프론트엔드 요청 헤더 확인

5. **CSS 스타일 적용 안됨**
   ```bash
   cd frontend
   npm run build:css
   ```

## 🔄 프로젝트 전송

다른 PC에서 이 작업을 이어서 하기 위해서는 다음 단계를 따르세요:

### 1. 현재 PC에서 (이미 완료)
```bash
# 모든 변경사항을 Git에 커밋
# (2024.08.07 커밋 완료: "Implement complete JWT authentication system with client-side auth")
```

### 2. 새로운 PC에서
```bash
# 저장소 클론
git clone <repository-url>
cd hsc1

# 환경 변수 설정
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
# 각각 수정 필요

# 백엔드 설정
cd backend
bundle install
rails db:create db:migrate db:seed
rails server -p 7001 &

# 프론트엔드 설정
cd ../frontend  
bundle install
npm install
npm run build:css
rails server -p 7002
```

### 3. 작업 상태 확인
- http://localhost:7002 접속
- 로그인: admin@hospital.com / password123
- 인증 시스템 정상 작동 확인
- API 연동 상태 확인

### 현재 작업 상태
✅ JWT 기반 인증 시스템 구현 완료
✅ 클라이언트사이드 인증으로 전환
✅ 로그인 전 사이드바 비표시
✅ 대시보드 인증 체크 구현
✅ 57개 테스트 케이스 추가
✅ OpenAPI/Swagger 문서 생성
✅ CI/CD 파이프라인 구축

## 📞 연락처 및 지원

이 프로젝트에 대한 문의사항이나 버그 리포트가 있으시면 GitHub Issues를 통해 연락해 주세요.


## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

---

**마지막 업데이트**: 2024년 8월 7일 (Git 커밋 기록 참조)

## 🔄 최근 변경사항

- JWT 기반 인증 시스템 구현 완료
- 클라이언트사이드 인증으로 전환
- 전자결재 시스템 추가
- 테스트 커버리지 대폭 확장 (57개 테스트)
- OpenAPI/Swagger 문서화 완료
- CI/CD 파이프라인 구축
- Docker 컨테이너화 지원