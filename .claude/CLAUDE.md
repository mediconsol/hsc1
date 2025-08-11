# HSC1 Hospital Management System - Claude Code Configuration

HSC1 병원 관리 시스템을 위한 Claude Code 전용 설정 파일입니다.

## 📋 프로젝트 개요

**프로젝트명**: HSC1 (Hospital System Care 1)
**타입**: 병원 관리 시스템 (Ruby on Rails 풀스택)
**아키텍처**: Backend API Server(7001) + Frontend Web App(7002)
**데이터베이스**: PostgreSQL
**인증**: JWT 기반 클라이언트사이드 인증

## 🏗️ 시스템 구조

```
hsc1/
├── backend/          # Rails API 서버 (포트 7001)
│   ├── app/
│   │   ├── controllers/api/v1/  # API 컨트롤러
│   │   ├── models/              # 데이터 모델 (20개)
│   │   └── views/               # 메일러 뷰
│   ├── config/                  # 설정 파일
│   ├── db/                      # 마이그레이션 (22개)
│   ├── test/                    # 테스트 (57개)
│   └── swagger/                 # API 문서
├── frontend/         # Rails 웹앱 (포트 7002)
│   ├── app/
│   │   ├── controllers/         # 웹 컨트롤러
│   │   ├── views/               # HTML 템플릿
│   │   ├── assets/              # CSS, JS, 이미지
│   │   └── javascript/modules/  # JS 모듈
│   └── config/                  # 설정 파일
├── docs/                        # 문서
├── .claude/                     # Claude Code 설정
└── docker-compose.yml           # Docker 설정
```

## 🎯 핵심 비즈니스 도메인

### 👥 사용자 관리
- **역할**: read_only(0), staff(1), manager(2), admin(3)
- **인증**: JWT 토큰 (access_token, refresh_token)
- **권한**: 역할 기반 접근 제어

### 🏥 환자 관리
- **모델**: Patient, Appointment, HealthCheckup
- **기능**: 환자 등록, 예약 관리, 건강검진 추적
- **연관**: MedicalHistory, FamilyHistory

### 👨‍⚕️ 의료진 관리
- **모델**: Employee, Attendance, Payroll
- **기능**: 출퇴근 관리, 급여 계산, 휴가 신청

### 📄 문서/전자결재
- **모델**: Document, ApprovalWorkflow, Approval
- **기능**: 전자결재, 승인 라인, 문서 관리

### 📢 소통/공지
- **모델**: Announcement, DepartmentPost, Comment
- **기능**: 공지사항, 부서 게시판, 댓글 시스템

## 🛠️ 개발 명령어

### 환경 설정
```bash
# 전체 시스템 시작
./start-dev.bat

# 개별 서비스 시작
cd backend && rails server -p 7001
cd frontend && rails server -p 7002

# 데이터베이스 초기화
cd backend && rails db:drop db:create db:migrate db:seed

# 테스트 실행
cd backend && rails test
```

### 코드 품질 검사
```bash
# Rubocop (Ruby 코드 스타일)
bundle exec rubocop

# Brakeman (보안 검사)
bundle exec brakeman

# 테스트 커버리지
bundle exec rails test --coverage
```

## 🌐 API 엔드포인트

### 인증 API
```
POST   /api/v1/auth/login     # 로그인
DELETE /api/v1/auth/logout    # 로그아웃
GET    /api/v1/auth/me        # 사용자 정보
POST   /api/v1/auth/refresh   # 토큰 갱신
```

### 핵심 리소스 API
- **환자**: `/api/v1/patients`
- **예약**: `/api/v1/appointments`
- **건강검진**: `/api/v1/health_checkups`
- **직원**: `/api/v1/employees`
- **출퇴근**: `/api/v1/attendances`
- **휴가**: `/api/v1/leave_requests`
- **급여**: `/api/v1/payrolls`
- **문서**: `/api/v1/documents`
- **공지**: `/api/v1/announcements`

## 📊 데이터베이스 스키마

### 주요 테이블
- **users**: 사용자 기본 정보 및 인증
- **patients**: 환자 정보 (이름, 생년월일, 연락처, 보험)
- **appointments**: 예약 정보 (날짜, 시간, 상태)
- **employees**: 직원 정보 (부서, 직급, 급여)
- **health_checkups**: 건강검진 기록
- **documents**: 전자결재 문서

### 연관 관계
- Patient → Appointments, HealthCheckups, MedicalHistories
- Employee → Attendances, LeaveRequests, Payrolls
- Document → ApprovalWorkflows → Approvals
- Announcement → AnnouncementReads

## 🔧 프로젝트별 도구 및 유틸리티

### 배치 파일
- `start-dev.bat`: 개발 서버 시작
- `setup-local.bat`: 로컬 환경 설정
- `fix-db.bat`: 데이터베이스 복구

### 테스트 현황
- **총 테스트**: 57개 케이스
- **커버리지**: 모델, 컨트롤러, 통합 테스트
- **성능 테스트**: API, DB, Factory 성능 검증

### Swagger 문서
- **개발**: http://localhost:7001/api-docs
- **JSON**: http://localhost:7001/api/v1/swagger.json

## 🏥 의료 도메인 특화 정보

### 환자 생명주기
1. **신규 등록** → 환자번호 자동 생성 (P2411001 형식)
2. **예약 접수** → 상태별 관리 (pending, confirmed, completed)
3. **건강검진** → 주기적 검진 알림 (1-5년 주기)
4. **의료 기록** → 과거력, 가족력 관리

### 직원 근무 관리
1. **출퇴근** → 체크인/체크아웃 시스템
2. **휴가 관리** → 신청, 승인, 잔여 휴가 추적
3. **급여 계산** → 기본급, 수당, 공제 항목

### 전자결재 워크플로우
1. **문서 생성** → 작성자가 초안 작성
2. **결재 요청** → 승인 라인 설정
3. **순차 승인** → 단계별 승인/반려
4. **최종 처리** → 완료/보관

## 🚨 보안 고려사항

### JWT 토큰 관리
- `access_token`: 15분 유효기간
- `refresh_token`: 7일 유효기간
- localStorage 저장, XSS 방지 필요

### 의료 데이터 보호
- 환자 개인정보 암호화 필요
- 접근 로그 기록
- HIPAA 준수 고려사항

### API 보안
- CORS 설정: 프론트엔드만 허용
- Rate Limiting 구현 필요
- SQL Injection 방지

## 🎯 성능 최적화 포인트

### 데이터베이스
- 인덱스: 검색 빈도가 높은 컬럼
- N+1 쿼리 방지: includes 사용
- 페이지네이션: 대용량 데이터 처리

### API 응답
- JSON 직렬화 최적화
- 불필요한 데이터 제거
- 캐싱 전략 구현

### 프론트엔드
- JavaScript 모듈 최적화
- CSS 번들링
- 이미지 최적화

---

**마지막 업데이트**: 2024년 8월 11일
**담당자**: HSC1 개발팀
**버전**: 1.0.0