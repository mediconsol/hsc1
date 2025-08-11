# HSC1 Custom Commands Configuration

HSC1 병원 관리 시스템을 위한 커스텀 Claude Code 명령어 정의

## 🏥 HSC1 Specialized Commands

### Core Hospital Operations

#### `/patient` - 환자 관리 명령어
```yaml
command: "/patient"
category: "Hospital Operations"
purpose: "환자 데이터 관리 및 분석"
wave-enabled: true
performance-profile: "standard"
```

**사용법**:
```bash
/patient list                    # 환자 목록 조회
/patient search [name|number]    # 환자 검색
/patient create [data]           # 신규 환자 등록
/patient update [id] [data]      # 환자 정보 수정
/patient validate               # 환자 데이터 무결성 검사
/patient stats                  # 환자 통계 분석
/patient checkup [id]           # 검진 이력 조회
```

**자동 활성화**:
- **Persona**: `--persona-analyzer` (데이터 분석 시)
- **MCP Integration**: Context7 (의료 표준), Sequential (복잡 분석)
- **Tool Orchestration**: [Read, Grep, Edit, TodoWrite]

#### `/appointment` - 예약 관리 명령어
```yaml
command: "/appointment" 
category: "Hospital Operations"
purpose: "예약 시스템 최적화 및 관리"
wave-enabled: true
performance-profile: "optimization"
```

**사용법**:
```bash
/appointment schedule           # 예약 스케줄 조회
/appointment book [patient] [time]  # 예약 등록
/appointment optimize           # 스케줄 최적화
/appointment conflicts          # 충돌 감지
/appointment waitlist           # 대기 명단 관리
/appointment analytics          # 예약 패턴 분석
```

**자동 활성화**:
- **Persona**: `--persona-performance` (최적화 요청 시)
- **MCP Integration**: Sequential (스케줄 분석), Magic (UI 개선)

#### `/health-check` - 시스템 상태 점검
```yaml
command: "/health-check"
category: "System Maintenance" 
purpose: "HSC1 시스템 전반적 상태 점검"
wave-enabled: true
performance-profile: "complex"
```

**사용법**:
```bash
/health-check all              # 전체 시스템 점검
/health-check api              # API 서비스 상태
/health-check database         # 데이터베이스 상태
/health-check security         # 보안 상태 점검
/health-check performance      # 성능 지표 확인
/health-check business         # 비즈니스 로직 검증
```

**자동 활성화**:
- **Persona**: `--persona-analyzer` + `--persona-security`
- **MCP Integration**: Sequential (시스템 분석), Playwright (E2E 테스트)
- **Flags**: `--think-hard --validate --safe-mode`

### Development & Quality Commands

#### `/code-review` - HSC1 코드 리뷰
```yaml
command: "/code-review"
category: "Code Quality"
purpose: "의료 시스템 특화 코드 리뷰"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/code-review models            # 모델 코드 리뷰
/code-review controllers       # 컨트롤러 리뷰
/code-review security          # 보안 관련 코드
/code-review medical-logic     # 의료 로직 검증
/code-review performance       # 성능 이슈 검토
```

**자동 활성화**:
- **Persona**: `--persona-security` (보안 리뷰), `--persona-refactorer` (품질 개선)
- **Focus**: 의료 데이터 보호, HIPAA 준수, 성능 최적화

#### `/test-generate` - HSC1 테스트 생성
```yaml
command: "/test-generate"
category: "Testing"
purpose: "의료 도메인 특화 테스트 케이스 생성"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/test-generate model [name]     # 모델 테스트 생성
/test-generate api [endpoint]   # API 테스트 생성
/test-generate integration      # 통합 테스트 생성
/test-generate security         # 보안 테스트 생성
/test-generate factory [model]  # Factory 생성
```

**자동 활성화**:
- **Persona**: `--persona-qa`
- **Templates**: HSC1 의료 도메인 테스트 패턴

### Data & Analytics Commands

#### `/analytics` - 병원 운영 분석
```yaml
command: "/analytics"
category: "Business Intelligence"
purpose: "병원 운영 데이터 분석 및 인사이트 생성"
wave-enabled: true
performance-profile: "complex"
```

**사용법**:
```bash
/analytics dashboard           # 대시보드 데이터 생성
/analytics patients            # 환자 통계 분석
/analytics appointments        # 예약 패턴 분석
/analytics revenue             # 수익 분석
/analytics efficiency          # 운영 효율성 분석
/analytics predictions         # 예측 분석
```

**자동 활성화**:
- **Persona**: `--persona-analyzer`
- **MCP Integration**: Sequential (복잡 분석), Context7 (업계 벤치마크)
- **Flags**: `--think-hard` (복잡 분석 시)

#### `/compliance` - 규정 준수 검사
```yaml
command: "/compliance"
category: "Regulatory"
purpose: "의료 규정 및 개인정보보호 준수 확인"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/compliance hipaa             # HIPAA 규정 준수 검사
/compliance privacy           # 개인정보보호 검사
/compliance audit             # 감사 준비
/compliance policies          # 내부 정책 준수
/compliance report            # 준수 리포트 생성
```

**자동 활성화**:
- **Persona**: `--persona-security`
- **Focus**: 의료 데이터 보호, 접근 권한, 감사 로그

### DevOps & Deployment Commands

#### `/deploy-hsc1` - HSC1 배포 관리
```yaml
command: "/deploy-hsc1"
category: "DevOps"
purpose: "HSC1 시스템 배포 및 운영 관리"
wave-enabled: false
performance-profile: "optimization"
```

**사용법**:
```bash
/deploy-hsc1 staging          # 스테이징 배포
/deploy-hsc1 production       # 프로덕션 배포
/deploy-hsc1 rollback         # 롤백 실행
/deploy-hsc1 migrate          # DB 마이그레이션
/deploy-hsc1 verify           # 배포 검증
```

**자동 활성화**:
- **Persona**: `--persona-devops`
- **Flags**: `--safe-mode --validate`
- **Health Checks**: 자동 실행

#### `/backup-restore` - 데이터 백업/복원
```yaml
command: "/backup-restore"
category: "Data Management"
purpose: "의료 데이터 백업 및 복원 관리"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/backup-restore backup        # 전체 백업 실행
/backup-restore restore [date] # 특정 시점 복원
/backup-restore verify        # 백업 무결성 검증
/backup-restore schedule      # 백업 스케줄 관리
/backup-restore encrypt       # 백업 암호화 확인
```

**자동 활성화**:
- **Persona**: `--persona-security` (암호화), `--persona-devops` (운영)
- **Security**: 의료 데이터 보호 강화

### Monitoring & Alerts Commands

#### `/monitor` - 실시간 모니터링
```yaml
command: "/monitor"
category: "System Operations"
purpose: "HSC1 시스템 실시간 모니터링"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/monitor start               # 모니터링 시작
/monitor alerts              # 알림 상태 확인
/monitor metrics             # 주요 지표 조회
/monitor logs                # 로그 분석
/monitor incidents           # 장애 이력 조회
```

**자동 활성화**:
- **Persona**: `--persona-analyzer` (로그 분석)
- **Real-time**: 실시간 데이터 수집 및 분석

## 🔧 Command Extensions for HSC1

### Medical Domain Validators
```yaml
validators:
  patient_data:
    - birth_date_realistic: "1900 <= year <= current_year"
    - phone_korean_format: "010-xxxx-xxxx or 0xx-xxx-xxxx"
    - insurance_valid: "national|employee|medical_aid|private|none"
    
  appointment_rules:
    - future_date_only: "appointment_date > current_time"
    - business_hours: "09:00 <= time <= 18:00"
    - no_double_booking: "unique per doctor per time slot"
    
  medical_codes:
    - icd10_validation: "valid ICD-10 diagnosis codes"
    - procedure_codes: "valid medical procedure codes"
```

### HSC1 Specific Helpers
```yaml
helpers:
  patient_number_generator:
    format: "P{YY}{MM}{NNNN}"
    description: "P + 연도 + 월 + 일련번호"
    
  appointment_scheduler:
    algorithm: "optimal_scheduling"
    factors: ["doctor_availability", "patient_preference", "urgency"]
    
  compliance_checker:
    standards: ["HIPAA", "Personal_Information_Protection_Act"]
    auto_anonymization: true
    
  performance_optimizer:
    database: "query_optimization"
    api: "response_time_monitoring"
    caching: "intelligent_caching"
```

### Integration Commands

#### `/integrate` - 외부 시스템 연동
```yaml
command: "/integrate"
category: "System Integration"  
purpose: "외부 의료 시스템 및 서비스 연동"
wave-enabled: false
performance-profile: "standard"
```

**사용법**:
```bash
/integrate insurance          # 보험사 시스템 연동
/integrate equipment          # 의료 장비 연동
/integrate ehr               # 전자의무기록 시스템
/integrate notification       # 알림 서비스 연동
/integrate analytics         # 분석 도구 연동
```

#### `/migration` - 데이터 마이그레이션
```yaml
command: "/migration"
category: "Data Migration"
purpose: "의료 데이터 안전 마이그레이션"
wave-enabled: true
performance-profile: "complex"
```

**사용법**:
```bash
/migration plan              # 마이그레이션 계획 수립
/migration validate          # 데이터 검증
/migration execute           # 마이그레이션 실행
/migration rollback          # 롤백 실행
/migration verify            # 결과 검증
```

## 🎯 Command Usage Patterns

### Daily Operations Workflow
```bash
# 아침 시스템 점검
/health-check all
/monitor alerts

# 환자 데이터 관리
/patient validate
/appointment optimize

# 성능 모니터링
/analytics efficiency
```

### Development Workflow
```bash
# 코드 작업 후
/code-review medical-logic
/test-generate integration
/compliance hipaa

# 배포 전
/health-check all
/deploy-hsc1 staging
```

### Weekly Maintenance
```bash
# 주간 정기 점검
/analytics dashboard
/compliance audit
/backup-restore verify
/performance-review
```

## 📊 Command Analytics

### Usage Tracking
```yaml
metrics:
  - command_frequency
  - execution_time
  - success_rate
  - error_patterns
  
insights:
  - most_used_commands
  - performance_bottlenecks
  - common_failure_points
  - optimization_opportunities
```

### Command Optimization
```yaml
auto_optimization:
  - command_caching
  - parameter_prediction
  - workflow_suggestions
  - performance_tuning

feedback_loop:
  - usage_pattern_analysis
  - command_effectiveness
  - user_satisfaction
  - continuous_improvement
```

이러한 HSC1 특화 명령어들을 통해 병원 관리 시스템의 개발, 운영, 유지보수를 효율적으로 수행할 수 있습니다.