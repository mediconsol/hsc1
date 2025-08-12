# 🔒 배포 전 보안 체크리스트

Railway 배포 전 필수 보안 점검 사항입니다.

## ✅ 환경 변수 보안

### 필수 환경 변수 확인
- [ ] `RAILS_MASTER_KEY` (backend/frontend 각각)
- [ ] `DATABASE_URL` (Railway 자동 생성)
- [ ] `FRONTEND_URL` / `BACKEND_API_URL`
- [ ] `JWT_SECRET` (강력한 랜덤 키)
- [ ] `GEMINI_API_KEY` (AI 기능용)

### 민감 정보 보호 확인
- [ ] master.key 파일이 .gitignore에 포함되어 있음
- [ ] 환경 변수 파일(.env)이 .gitignore에 포함되어 있음
- [ ] 하드코딩된 비밀번호/키가 코드에 없음
- [ ] API 키가 소스코드에 노출되지 않음

## 🛡️ 애플리케이션 보안

### HTTPS 및 SSL 설정
- [x] Production에서 `force_ssl = true` 설정
- [x] HSTS 헤더 설정
- [x] Secure 쿠키 설정
- [x] SameSite 쿠키 정책 설정

### CORS 설정
- [x] CORS origins가 환경 변수로 제한됨
- [x] 와일드카드(`*`) 사용 안함
- [x] 프론트엔드 도메인만 허용

### 세션 보안
- [x] 세션 쿠키가 secure, httponly 설정
- [x] 세션 만료 시간 설정 (24시간)
- [x] CSRF 보호 활성화

### Content Security Policy (CSP)
- [x] CSP 헤더 설정 (frontend)
- [x] 인라인 스크립트 제한
- [x] 외부 리소스 출처 제한
- [x] XSS 보호 강화

## 🔐 인증 및 권한

### JWT 토큰 보안
- [ ] JWT secret이 강력하고 무작위임 (32자 이상)
- [ ] 토큰 만료 시간이 적절함 (1시간 권장)
- [ ] Refresh token 구현 확인
- [ ] 토큰이 localStorage에 안전하게 저장됨

### 사용자 권한
- [x] 역할 기반 접근 제어 (RBAC) 구현
- [x] API 엔드포인트별 권한 확인
- [x] 관리자 권한 분리
- [x] 최소 권한 원칙 적용

## 🗄️ 데이터베이스 보안

### 연결 보안
- [x] SSL 연결 강제 (Railway 기본 제공)
- [x] 강력한 데이터베이스 패스워드
- [x] 데이터베이스 방화벽 설정

### 쿼리 보안
- [x] SQL Injection 방지 (ActiveRecord 사용)
- [x] 파라미터 바인딩 사용
- [x] 동적 쿼리 최소화

## 🌐 네트워크 보안

### 호스트 보안
- [x] 허용된 호스트 제한 설정
- [x] Railway 도메인만 허용
- [x] DNS 리바인딩 공격 방지

### API 보안
- [x] Rate limiting (필요시 구현)
- [x] API 버전 관리
- [x] 에러 메시지에서 민감 정보 숨김

## 📝 로깅 및 모니터링

### 보안 로깅
- [x] 인증 실패 로깅
- [x] 권한 오류 로깅  
- [x] 민감 정보 로그 제외
- [x] 구조화된 로그 포맷

### 모니터링
- [x] Health check 엔드포인트 구현
- [x] 성능 메트릭 수집
- [x] 오류 추적 시스템

## 🔍 코드 보안

### 의존성 보안
- [ ] 알려진 취약점이 있는 gem 없음
- [ ] 정기적인 보안 업데이트 계획
- [ ] Bundler audit 실행

```bash
# 의존성 보안 검사
cd backend && bundle audit
cd frontend && bundle audit && npm audit
```

### 입력 검증
- [x] Strong Parameters 사용
- [x] 입력 데이터 검증
- [x] 파일 업로드 제한
- [x] XSS 방지 처리

## 🚀 배포 보안

### CI/CD 보안
- [x] GitHub Secrets 사용
- [x] 빌드 환경 격리
- [x] 배포 권한 제한

### Railway 플랫폼 보안
- [x] 서비스별 환경 분리
- [x] 프로덕션 환경 접근 제한
- [x] 백업 및 복구 계획

## ⚠️ 보안 주의사항

### 금지 사항
- ❌ 프로덕션에서 debug 모드 사용
- ❌ 기본 패스워드 사용
- ❌ 불필요한 서비스 노출
- ❌ 민감 정보 로깅
- ❌ 개발 도구 프로덕션 포함

### 권장 사항
- ✅ 정기적인 보안 감사
- ✅ 침입 탐지 시스템 구축
- ✅ 보안 인시던트 대응 계획
- ✅ 팀 보안 교육

## 🛠️ 보안 도구

### 추천 도구
```bash
# Ruby 보안 검사
gem install brakeman
brakeman

# 의존성 취약점 검사
gem install bundler-audit
bundle audit

# JavaScript 보안 검사
npm audit
npm install -g eslint-plugin-security
```

### Railway 보안 기능
- 자동 SSL 인증서
- 네트워크 격리
- 환경 변수 암호화
- 접근 로그 기록

## 📋 배포 전 최종 점검

1. [ ] 모든 환경 변수가 설정되었음
2. [ ] master.key 파일이 안전하게 관리됨
3. [ ] CORS 설정이 올바름
4. [ ] SSL/HTTPS가 강제됨
5. [ ] 세션 보안이 적절함
6. [ ] CSP 헤더가 설정됨
7. [ ] 의존성 취약점이 없음
8. [ ] 로깅이 적절히 설정됨
9. [ ] Health check가 작동함
10. [ ] 백업 계획이 수립됨

---

**⚠️ 중요**: 이 체크리스트의 모든 항목을 확인한 후 배포를 진행하세요. 보안은 한 번 설정하고 끝나는 것이 아니라 지속적으로 관리해야 합니다.