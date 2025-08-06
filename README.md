# 병원 통합 관리 시스템 (Hospital Management System)

병원 내부 통합 운영 시스템을 위한 그룹웨어 솔루션

## 🏗️ 프로젝트 구조

```
hospital-system/
├── backend/           # Rails API (포트 7001)
│   ├── app/
│   ├── config/
│   └── ...
├── frontend/          # Hotwire 기반 프론트엔드 (포트 7002)
│   ├── app/
│   ├── views/
│   └── ...
├── docker-compose.yml # Docker 컨테이너 설정
└── README.md
```

## 🛠️ 기술 스택

### 백엔드 (포트 7001)
- **Framework**: Ruby on Rails (API 모드)
- **Database**: PostgreSQL
- **Authentication**: JWT
- **Language**: Ruby 3.x

### 프론트엔드 (포트 7002)
- **Framework**: Rails with Hotwire (Turbo + Stimulus)
- **Styling**: Tailwind CSS
- **Language**: Ruby + JavaScript/TypeScript

### 기타
- **Container**: Docker + Docker Compose
- **Database**: PostgreSQL
- **Cache/Queue**: Redis

## 🚀 개발 환경 설정

### 1. Docker를 사용한 설정 (권장)

```bash
# 프로젝트 클론 후
cd hospital-system

# Docker 컨테이너 실행
docker-compose up -d

# 데이터베이스 설정 (백엔드)
docker-compose exec backend rails db:create db:migrate db:seed

# 데이터베이스 설정 (프론트엔드)
docker-compose exec frontend rails db:create db:migrate
```

### 2. 로컬 환경 설정

#### 백엔드 설정
```bash
cd backend

# 의존성 설치
bundle install

# 데이터베이스 설정
rails db:create db:migrate db:seed

# 서버 실행 (포트 7001)
rails server -p 7001
```

#### 프론트엔드 설정
```bash
cd frontend

# 의존성 설치
bundle install

# Tailwind CSS 설치
rails tailwindcss:install

# 데이터베이스 설정
rails db:create db:migrate

# 서버 실행 (포트 7002)
rails server -p 7002
```

## 🔐 기본 사용자 계정

시스템에는 다음과 같은 기본 사용자 계정이 생성됩니다:

- **관리자**: admin@hospital.com / password123
- **매니저**: manager@hospital.com / password123  
- **스태프**: staff@hospital.com / password123

## 📋 주요 기능

### Phase 1: 기본 시스템
- [x] 사용자 인증 시스템 (JWT)
- [x] 권한 관리 (admin, manager, staff, read_only)
- [ ] 대시보드
- [ ] 기본 네비게이션

### Phase 2: 내부 행정 시스템
- [ ] 전자결재 시스템
- [ ] 문서관리 시스템
- [ ] 예산/재무 관리
- [ ] 시설/자산 관리

### Phase 3: 확장 기능
- [ ] 예약·문진 관리
- [ ] 상담/CRM 시스템
- [ ] 인사·급여·근태 관리
- [ ] 재고·구매 관리

## 🌐 API 엔드포인트

### 인증 API
- `POST /api/v1/auth/login` - 로그인
- `DELETE /api/v1/auth/logout` - 로그아웃
- `GET /api/v1/auth/me` - 현재 사용자 정보

## 🔧 개발 명령어

### 백엔드
```bash
# 테스트 실행
rails test

# 콘솔 실행
rails console

# 마이그레이션 생성
rails generate migration MigrationName

# 모델 생성
rails generate model ModelName
```

### 프론트엔드
```bash
# Tailwind CSS 빌드
rails tailwindcss:build

# 자산 미리 컴파일
rails assets:precompile
```

## 📦 배포

```bash
# Docker 이미지 빌드
docker-compose build

# 프로덕션 환경 실행
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## 📝 개발 가이드라인

1. **코드 스타일**: RuboCop 규칙 준수
2. **브랜치 전략**: feature/기능명 형태로 브랜치 생성
3. **커밋 메시지**: 영어로 작성, 현재형 동사 사용
4. **테스트**: 새로운 기능에 대한 테스트 작성 필수

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.