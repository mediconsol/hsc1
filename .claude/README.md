# HSC1 Claude Code Configuration

HSC1 병원 관리 시스템을 위한 Claude Code 전용 설정 모음

## 📁 구성 파일 개요

이 디렉토리는 HSC1 병원 관리 시스템에 최적화된 Claude Code 설정을 포함합니다.

### 📋 파일 구조
```
.claude/
├── README.md           # 이 파일 - 설정 가이드
├── CLAUDE.md          # HSC1 프로젝트 컨텍스트 정보
├── AGENTS.md          # 13개 특화 에이전트 정의
├── HEALTH_CHECK.md    # 6단계 시스템 헬스 체크
├── WORKFLOWS.md       # 16개 자동화 워크플로우
└── COMMANDS.md        # HSC1 전용 Claude 명령어
```

## 🎯 주요 기능

### 🤖 Specialized Agents (13개)
병원 시스템에 특화된 전문 에이전트:
- **Domain Agents (6개)**: Patient Manager, Appointment Scheduler, Document Workflow, HR Operations, Analytics Intelligence, Communication Hub
- **Quality Agents (4개)**: Code Quality Inspector, Test Automation, Database Health Monitor, Security Compliance
- **Operations Agents (3개)**: System Health Monitor, Deployment Pipeline, Resource Optimizer

### 🏥 Health Check System (6단계)
포괄적인 시스템 상태 점검:
1. **Application Health**: Backend/Frontend 서버 상태
2. **Database Health**: PostgreSQL 성능 및 무결성
3. **API Health**: 인증 및 비즈니스 API 상태
4. **Security Health**: JWT, 데이터 보호, 접근 제어
5. **Performance Health**: 응답시간, 메모리, CPU 사용률
6. **Business Logic Health**: 환자 관리, 승인 워크플로우 로직

### ⚡ Automated Workflows (16개)
개발부터 운영까지 전체 라이프사이클 자동화:
- **Development (5개)**: Code Quality, Database Migration, Feature Development, Hotfix, Refactoring
- **Testing (4개)**: Automated Testing, Security Testing, Performance Testing, Regression Testing
- **Deployment (3개)**: CI/CD Pipeline, Database Migration, Monitoring & Alerting
- **Business (4개)**: Patient Data, Appointment Management, Document Approval, Compliance Monitoring

### 🔧 Custom Commands (10개)
HSC1 특화 명령어:
- `/patient`: 환자 데이터 관리 및 분석
- `/appointment`: 예약 시스템 최적화
- `/health-check`: 시스템 상태 점검
- `/analytics`: 병원 운영 분석
- `/compliance`: 규정 준수 검사
- 기타 개발/운영 전용 명령어

## 🚀 빠른 시작

### 1. 프로젝트 컨텍스트 확인
```bash
# 프로젝트 정보 확인
cat .claude/CLAUDE.md
```

### 2. 시스템 상태 점검
```bash
# 전체 시스템 헬스체크 실행
/health-check all

# 특정 영역 점검
/health-check database
/health-check security
```

### 3. 환자 데이터 관리
```bash
# 환자 데이터 검증
/patient validate

# 환자 통계 분석
/patient stats

# 새 환자 등록 (개발/테스트)
/patient create --test-data
```

### 4. 예약 시스템 최적화
```bash
# 예약 스케줄 최적화
/appointment optimize

# 충돌 감지
/appointment conflicts

# 예약 패턴 분석
/appointment analytics
```

## 📊 운영 시나리오별 가이드

### 🌅 일일 운영 체크리스트
```bash
# 1. 시스템 상태 확인
/health-check all
/monitor alerts

# 2. 비즈니스 메트릭 확인
/analytics dashboard
/patient stats
/appointment analytics

# 3. 보안 상태 점검
/compliance privacy
/health-check security
```

### 🔧 개발 워크플로우
```bash
# 1. 코드 작업 전
/health-check all

# 2. 개발 중
/code-review medical-logic
/test-generate model Patient

# 3. 배포 전
/compliance hipaa
/health-check performance
/deploy-hsc1 staging
```

### 📈 주간 성능 리뷰
```bash
# 1. 성능 분석
/analytics efficiency
/health-check performance

# 2. 데이터 품질 점검
/patient validate
/compliance audit

# 3. 시스템 최적화
/appointment optimize
/analytics predictions
```

### 🚨 장애 대응 절차
```bash
# 1. 긴급 상태 점검
/health-check all --critical-only

# 2. 로그 분석
/monitor logs --error-only

# 3. 복구 작업
/deploy-hsc1 rollback  # 필요시
/backup-restore verify
```

## 🎛️ 에이전트 활용 전략

### Phase 1: 핵심 안정성 (즉시 구현)
```yaml
priority_agents:
  - System Health Monitor: 시스템 안정성
  - Security Compliance: 의료 데이터 보호  
  - Patient Management: 핵심 비즈니스 로직
```

### Phase 2: 운영 효율성 (단기 구현)
```yaml
efficiency_agents:
  - Database Health Monitor: 데이터 안정성
  - Code Quality Inspector: 코드 품질 유지
  - Appointment Scheduler: 운영 최적화
```

### Phase 3: 고도화 (장기 구현)
```yaml
advanced_agents:
  - Analytics Intelligence: 데이터 인사이트
  - Communication Hub: 자동화 알림
  - HR Operations: 인사 관리
```

## 🔒 보안 및 컴플라이언스

### HIPAA 준수 체크포인트
- 환자 데이터 암호화 검증
- 접근 로그 완전성 확인
- 데이터 유출 감지 시스템
- 직원 교육 이수 확인

### 개인정보보호 조치
- 민감 데이터 노출 방지
- SQL 인젝션 보호
- XSS 공격 방지
- 역할 기반 접근 제어

## 📋 커스터마이징 가이드

### 새로운 에이전트 추가
1. `AGENTS.md`에 에이전트 정의 추가
2. 해당 에이전트용 설정 파일 생성
3. 워크플로우에 통합

### 헬스체크 항목 확장
1. `HEALTH_CHECK.md`에 새 체크 항목 정의
2. 임계값 및 알림 규칙 설정
3. 대시보드에 메트릭 추가

### 워크플로우 수정
1. `WORKFLOWS.md`에서 해당 워크플로우 수정
2. 트리거 조건 및 단계 조정
3. 알림 및 에스컬레이션 정책 업데이트

## 🤝 팀 협업 가이드

### 개발팀
- 코드 품질 및 테스트 자동화 활용
- 보안 검사 및 성능 최적화
- 데이터베이스 마이그레이션 안전 실행

### 운영팀
- 시스템 모니터링 및 헬스체크
- 장애 대응 및 복구 프로세스
- 성능 분석 및 최적화

### 의료진/관리자
- 환자 데이터 품질 관리
- 예약 시스템 효율성 개선
- 규정 준수 상태 모니터링

## 📞 지원 및 문의

### 기술 지원
- **시스템 장애**: `/health-check all` 실행 후 결과 공유
- **성능 이슈**: `/analytics efficiency` 결과와 함께 문의
- **보안 문제**: `/compliance audit` 리포트 첨부

### 기능 개선 요청
1. 현재 설정의 한계점 분석
2. 개선 방향 제안
3. 기대 효과 정량화

---

**최종 업데이트**: 2024년 8월 11일
**설정 버전**: 1.0.0
**호환 시스템**: HSC1 v1.0.0

이 설정을 통해 HSC1 병원 관리 시스템의 개발, 운영, 유지보수를 Claude Code와 함께 효율적으로 수행할 수 있습니다.