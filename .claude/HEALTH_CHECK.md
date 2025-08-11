# HSC1 System Health Check Configuration

HSC1 병원 관리 시스템의 포괄적인 헬스 체크 및 모니터링 설정

## 🏥 시스템 헬스 체크 개요

HSC1은 의료 시스템의 특성상 높은 가용성과 안정성이 요구되므로, 다층적 모니터링 체계를 구축합니다.

---

## 🔍 Health Check Categories

### 1. Application Health (애플리케이션 상태)
### 2. Database Health (데이터베이스 상태)  
### 3. API Health (API 서비스 상태)
### 4. Security Health (보안 상태)
### 5. Performance Health (성능 상태)
### 6. Business Logic Health (비즈니스 로직 상태)

---

## 🎯 1. Application Health Checks

### Backend API Server (Port 7001)
```yaml
service: "hsc1-backend-api"
endpoint: "http://localhost:7001/up"
checks:
  - name: "rails_application_boot"
    description: "Rails 애플리케이션 부팅 상태"
    method: GET
    expected_status: 200
    timeout: 5000ms
    
  - name: "database_connection"
    description: "데이터베이스 연결 상태"
    query: "SELECT 1"
    timeout: 2000ms
    
  - name: "redis_connection"
    description: "Redis 캐시 연결 (있는 경우)"
    timeout: 2000ms
    
  - name: "jwt_secret_loaded"
    description: "JWT 비밀키 로드 상태"
    validation: "ENV['JWT_SECRET'].present?"
```

### Frontend Web Server (Port 7002)
```yaml
service: "hsc1-frontend-web"
endpoint: "http://localhost:7002/"
checks:
  - name: "rails_frontend_boot"
    description: "프론트엔드 서버 부팅 상태"
    method: GET
    expected_status: 200
    timeout: 5000ms
    
  - name: "asset_compilation"
    description: "CSS/JS 에셋 컴파일 상태"
    validation: "assets_compiled?"
    
  - name: "api_backend_connectivity"
    description: "백엔드 API 연결성"
    target: "http://localhost:7001/up"
    timeout: 3000ms
```

---

## 🗄️ 2. Database Health Checks

### PostgreSQL Database
```yaml
service: "postgresql-database"
checks:
  - name: "connection_pool_status"
    description: "데이터베이스 연결 풀 상태"
    query: |
      SELECT count(*) as active_connections 
      FROM pg_stat_activity 
      WHERE state = 'active'
    threshold:
      warning: 50
      critical: 80
      
  - name: "table_integrity"
    description: "핵심 테이블 무결성 검사"
    tables:
      - users: "SELECT COUNT(*) FROM users"
      - patients: "SELECT COUNT(*) FROM patients WHERE status = 'active'"
      - appointments: "SELECT COUNT(*) FROM appointments WHERE appointment_date >= CURRENT_DATE"
      - employees: "SELECT COUNT(*) FROM employees WHERE active = true"
    
  - name: "index_usage_efficiency" 
    description: "인덱스 사용 효율성"
    query: |
      SELECT schemaname, tablename, attname, n_distinct, correlation
      FROM pg_stats 
      WHERE tablename IN ('patients', 'appointments', 'employees')
    
  - name: "slow_query_detection"
    description: "느린 쿼리 감지"
    query: |
      SELECT query, mean_time, calls 
      FROM pg_stat_statements 
      WHERE mean_time > 1000
    threshold:
      warning: "mean_time > 1000ms"
      critical: "mean_time > 5000ms"
      
  - name: "database_size_monitoring"
    description: "데이터베이스 크기 모니터링"
    query: |
      SELECT pg_size_pretty(pg_database_size('hsc1_development')) as db_size
    threshold:
      warning: "1GB"
      critical: "5GB"
```

### Migration Status
```yaml
checks:
  - name: "pending_migrations"
    description: "대기 중인 마이그레이션 확인"
    command: "rails db:migrate:status"
    expected: "no pending migrations"
    
  - name: "schema_version_sync"
    description: "스키마 버전 동기화 상태"
    validation: "ActiveRecord::Migrator.current_version"
```

---

## 🌐 3. API Health Checks

### Authentication API
```yaml
endpoint_group: "authentication"
checks:
  - name: "login_endpoint"
    method: POST
    url: "/api/v1/auth/login"
    payload:
      email: "health_check@test.com"
      password: "test_password"
    expected_status: 200
    response_validation:
      - "response['access_token'].present?"
      - "response['refresh_token'].present?"
      
  - name: "token_validation"
    method: GET  
    url: "/api/v1/auth/me"
    headers:
      Authorization: "Bearer {test_token}"
    expected_status: 200
    
  - name: "token_refresh"
    method: POST
    url: "/api/v1/auth/refresh"
    expected_status: 200
```

### Core Business APIs
```yaml
endpoint_group: "core_business"
checks:
  - name: "patients_list_api"
    method: GET
    url: "/api/v1/patients"
    headers:
      Authorization: "Bearer {admin_token}"
    expected_status: 200
    response_validation:
      - "response.is_a?(Array)"
      - "response_time < 500ms"
      
  - name: "appointments_api"
    method: GET
    url: "/api/v1/appointments"
    expected_status: 200
    
  - name: "employees_api"
    method: GET
    url: "/api/v1/employees" 
    expected_status: 200
    
  - name: "health_checkups_api"
    method: GET
    url: "/api/v1/health_checkups"
    expected_status: 200
```

### API Response Time Monitoring
```yaml
performance_checks:
  - endpoints:
      - "/api/v1/patients"
      - "/api/v1/appointments"  
      - "/api/v1/employees"
    thresholds:
      excellent: "<100ms"
      good: "<300ms"
      warning: "<500ms"
      critical: ">1000ms"
```

---

## 🔒 4. Security Health Checks

### Authentication Security
```yaml
security_group: "authentication"
checks:
  - name: "jwt_token_expiration"
    description: "JWT 토큰 만료 시간 검증"
    validation: |
      token = JWT.decode(sample_token, ENV['JWT_SECRET'], true)
      exp_time = Time.at(token[0]['exp'])
      (exp_time - Time.current) <= 15.minutes
      
  - name: "password_encryption"
    description: "비밀번호 암호화 검증"
    validation: |
      user = User.first
      BCrypt::Password.new(user.password_digest).is_password?('known_password')
      
  - name: "cors_configuration"
    description: "CORS 설정 검증"
    validation: "Rails.application.config.middleware.include?(Rack::Cors)"
```

### Data Protection
```yaml
security_group: "data_protection" 
checks:
  - name: "sensitive_data_exposure"
    description: "민감 데이터 노출 검사"
    validation: |
      # 환자 개인정보 로그 노출 검사
      log_content = File.read('log/development.log')
      !log_content.include?('birth_date') && 
      !log_content.include?('phone') &&
      !log_content.include?('email')
      
  - name: "sql_injection_protection"
    description: "SQL 인젝션 보호 검증"
    tests:
      - "Patient.where('name = ?', \"'; DROP TABLE patients; --\")"
      - "User.find_by_sql([\"SELECT * FROM users WHERE email = ?\", \"admin'; --\"])"
      
  - name: "xss_protection"
    description: "XSS 공격 방지 검증" 
    validation: "ActionController::Base.protect_from_forgery?"
```

### Access Control
```yaml
security_group: "access_control"
checks:
  - name: "role_based_access"
    description: "역할 기반 접근 제어 검증"
    tests:
      - role: "read_only"
        allowed: ["GET /api/v1/patients"]
        forbidden: ["POST /api/v1/patients", "DELETE /api/v1/patients"]
      - role: "staff"
        allowed: ["GET /api/v1/patients", "POST /api/v1/appointments"]
        forbidden: ["DELETE /api/v1/employees"]
      - role: "admin"
        allowed: ["*"]
        
  - name: "unauthorized_access_attempts"
    description: "무단 접근 시도 모니터링"
    log_pattern: "Unauthorized|401|403"
    threshold:
      warning: "10 attempts/hour"
      critical: "50 attempts/hour"
```

---

## ⚡ 5. Performance Health Checks

### Response Time Monitoring
```yaml
performance_group: "response_time"
checks:
  - name: "api_response_time"
    description: "API 응답 시간 모니터링"
    endpoints:
      - "/api/v1/patients": 200ms
      - "/api/v1/appointments": 300ms
      - "/api/v1/auth/login": 500ms
    measurement: "95th percentile"
    
  - name: "database_query_performance"
    description: "데이터베이스 쿼리 성능"
    slow_query_threshold: 1000ms
    n_plus_one_detection: true
    
  - name: "memory_usage"
    description: "메모리 사용량 모니터링"
    thresholds:
      warning: "500MB"
      critical: "1GB"
      
  - name: "cpu_utilization" 
    description: "CPU 사용률"
    thresholds:
      warning: "70%"
      critical: "90%"
```

### Load Testing
```yaml
load_testing:
  scenarios:
    - name: "patient_registration_load"
      endpoint: "POST /api/v1/patients"
      concurrent_users: 10
      duration: "5 minutes"
      success_rate: ">95%"
      
    - name: "appointment_booking_load"
      endpoint: "POST /api/v1/appointments" 
      concurrent_users: 20
      duration: "10 minutes"
      success_rate: ">98%"
```

---

## 🏥 6. Business Logic Health Checks

### Patient Management Logic
```yaml
business_group: "patient_management"
checks:
  - name: "patient_number_generation"
    description: "환자번호 생성 로직 검증"
    test: |
      patient = Patient.create!(name: "Test Patient", birth_date: Date.current - 30.years, gender: "male", phone: "010-1234-5678")
      patient.patient_number.match?(/P\d{6}\d{4}/)
      
  - name: "health_checkup_reminder"
    description: "건강검진 알림 로직"
    test: |
      patient = Patient.create!(last_checkup_date: 11.months.ago)
      patient.needs_checkup? == true
      
  - name: "appointment_conflict_detection"
    description: "예약 충돌 감지"
    test: |
      time = DateTime.current + 1.day
      Appointment.create!(appointment_date: time, patient: patient1)
      conflicting_appointment = Appointment.new(appointment_date: time, patient: patient2)
      !conflicting_appointment.valid?
```

### Approval Workflow Logic
```yaml
business_group: "approval_workflow"
checks:
  - name: "document_approval_flow"
    description: "문서 승인 흐름 검증"
    test: |
      document = Document.create!(title: "Test Document", content: "Test", user: staff_user)
      workflow = ApprovalWorkflow.create!(document: document, approver: manager_user)
      document.request_approval
      document.status == 'pending_approval'
      
  - name: "leave_request_approval"
    description: "휴가 신청 승인 로직"
    test: |
      leave_request = LeaveRequest.create!(employee: employee, start_date: Date.current + 7.days, end_date: Date.current + 9.days)
      leave_request.approve!(manager_user)
      leave_request.status == 'approved'
```

### Data Integrity Checks
```yaml
business_group: "data_integrity"
checks:
  - name: "referential_integrity"
    description: "참조 무결성 검사"
    queries:
      - "SELECT COUNT(*) FROM appointments WHERE patient_id NOT IN (SELECT id FROM patients)"
      - "SELECT COUNT(*) FROM health_checkups WHERE patient_id NOT IN (SELECT id FROM patients)" 
      - "SELECT COUNT(*) FROM approvals WHERE document_id NOT IN (SELECT id FROM documents)"
    expected_result: 0
    
  - name: "business_rule_compliance"
    description: "비즈니스 규칙 준수"
    rules:
      - "환자 나이는 0-150세 범위": "SELECT COUNT(*) FROM patients WHERE DATE_PART('year', AGE(birth_date)) > 150"
      - "예약 시간은 미래여야 함": "SELECT COUNT(*) FROM appointments WHERE appointment_date < CURRENT_TIMESTAMP"
      - "활성 직원만 예약 가능": "SELECT COUNT(*) FROM appointments a JOIN employees e ON a.employee_id = e.id WHERE e.active = false"
```

---

## 🚨 Alert Configuration

### Critical Alerts (즉시 알림)
```yaml
critical_alerts:
  - condition: "database_connection_failed"
    notification: ["email", "slack", "sms"]
    escalation: "5분 후 관리자 호출"
    
  - condition: "authentication_service_down"  
    notification: ["email", "slack"]
    escalation: "10분 후 개발팀 호출"
    
  - condition: "patient_data_corruption"
    notification: ["email", "slack", "sms"]
    escalation: "즉시 관리자 및 의료진 알림"
```

### Warning Alerts (경고)
```yaml
warning_alerts:
  - condition: "api_response_time > 1000ms"
    notification: ["slack"]
    frequency: "hourly_summary"
    
  - condition: "database_connections > 70%"
    notification: ["email"]
    frequency: "daily_summary"
    
  - condition: "disk_usage > 80%"
    notification: ["slack"]
    frequency: "daily_summary"
```

---

## 📊 Health Check Dashboard

### Real-time Metrics
```yaml
dashboard:
  refresh_interval: 30
  sections:
    - name: "System Overview"
      metrics:
        - "Overall System Status"
        - "Active Users Count" 
        - "API Requests/min"
        - "Database Connections"
        
    - name: "Business Metrics"
      metrics:
        - "Active Patients"
        - "Today's Appointments"
        - "Pending Approvals"
        - "System Errors (24h)"
        
    - name: "Performance Metrics"
      metrics:
        - "Average Response Time"
        - "Database Query Time"
        - "Memory Usage"
        - "CPU Utilization"
```

### Historical Trends
```yaml
trends:
  retention_period: "90 days"
  aggregation_intervals: ["hourly", "daily", "weekly"]
  metrics:
    - "System Uptime %"
    - "API Success Rate %"
    - "Average Response Time"
    - "Patient Registration Count"
    - "Appointment Booking Count"
```

---

## 🔧 Health Check Automation

### Scheduled Health Checks
```yaml
schedule:
  continuous:
    - "Application Health" (every 30 seconds)
    - "Database Connection" (every 1 minute)
    - "API Availability" (every 1 minute)
    
  periodic:
    - "Security Scan" (daily at 2 AM)
    - "Performance Audit" (weekly)
    - "Business Logic Validation" (daily at 6 AM)
    - "Data Integrity Check" (daily at 1 AM)
```

### Auto-Recovery Actions
```yaml
auto_recovery:
  - trigger: "database_connection_lost"
    action: "restart_connection_pool"
    max_attempts: 3
    
  - trigger: "high_memory_usage"
    action: "garbage_collection"
    threshold: "memory > 800MB"
    
  - trigger: "api_timeout"
    action: "restart_puma_worker"
    condition: "timeout_count > 5 in 5_minutes"
```

이 헬스 체크 설정을 통해 HSC1 시스템의 안정성과 성능을 지속적으로 모니터링하고, 문제 발생 시 즉시 대응할 수 있는 체계를 구축할 수 있습니다.