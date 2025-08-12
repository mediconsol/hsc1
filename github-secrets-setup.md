# GitHub Secrets 설정 가이드

Rails 애플리케이션의 Railway 배포를 위한 GitHub Secrets 설정 방법을 설명합니다.

## 1. Railway Token 생성

### Railway Dashboard에서 Token 생성:
1. [Railway.app](https://railway.app) 로그인
2. **Account Settings** 클릭 (오른쪽 상단 프로필 아이콘)
3. **Tokens** 탭 선택
4. **Create New Token** 버튼 클릭
5. 토큰 이름 입력 (예: "GitHub Actions HSC1 Deploy")
6. **Create Token** 클릭
7. 생성된 토큰 복사 (한 번만 표시됨)

### 토큰 권한:
- 기본적으로 모든 프로젝트에 대한 전체 액세스 권한
- 배포, 환경 변수 설정, 서비스 관리 등 모든 작업 가능

## 2. GitHub Repository Secrets 설정

### GitHub Repository에서 Secrets 추가:
1. GitHub Repository 페이지로 이동
2. **Settings** 탭 클릭
3. 왼쪽 사이드바에서 **Secrets and variables** → **Actions** 클릭
4. **New repository secret** 버튼 클릭
5. 다음 정보 입력:
   ```
   Name: RAILWAY_TOKEN
   Secret: [1단계에서 복사한 Railway 토큰 값]
   ```
6. **Add secret** 클릭

## 3. Rails Master Key 설정 (선택사항)

Rails production 환경에서 필요한 경우:

### Backend Master Key:
```
Name: RAILS_MASTER_KEY_BACKEND
Secret: [backend/config/master.key 파일 내용]
```

### Frontend Master Key:
```
Name: RAILS_MASTER_KEY_FRONTEND  
Secret: [frontend/config/master.key 파일 내용]
```

## 4. 추가 보안 설정 (선택사항)

### JWT Secret:
```
Name: JWT_SECRET
Secret: [강력한 랜덤 문자열, 예: openssl rand -hex 32]
```

### Database URL (백업용):
```
Name: DATABASE_URL_BACKUP
Secret: [백업 데이터베이스 URL]
```

## 5. Secret 사용 방법

### GitHub Actions 워크플로우에서 사용:
```yaml
- name: Deploy to Railway
  run: railway up --service backend
  env:
    RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
    RAILS_MASTER_KEY: ${{ secrets.RAILS_MASTER_KEY_BACKEND }}
```

### 환경 변수로 전달:
```yaml
env:
  RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
  JWT_SECRET: ${{ secrets.JWT_SECRET }}
```

## 6. 보안 Best Practices

### Token 관리:
- **절대 코드에 하드코딩하지 않음**
- **정기적으로 토큰 로테이션** (3-6개월)
- **최소 권한 원칙** 적용
- **팀원 퇴사 시 즉시 토큰 교체**

### Secret 값 보안:
- **강력한 랜덤 값 사용**
- **길이 32자 이상 권장**
- **특수문자 포함**
- **예측 가능한 패턴 피함**

### Access Control:
- **필요한 워크플로우에만 사용**
- **브랜치 보호 규칙 설정**
- **PR에서는 read-only 권한만**

## 7. 문제 해결

### 일반적인 오류:

#### Railway Token 인증 실패:
```
Error: Authentication failed
```
**해결방법**: 
- Railway 토큰 재확인
- 토큰 만료 여부 확인
- 새 토큰 생성 후 교체

#### Secret 접근 오류:
```
Error: Secret RAILWAY_TOKEN not found
```
**해결방법**:
- GitHub Secrets 설정 재확인
- 이름 오타 확인
- Repository 권한 확인

#### 워크플로우 권한 오류:
```
Error: Permission denied
```
**해결방법**:
- Repository Settings → Actions → General
- Workflow permissions를 "Read and write permissions"로 설정

## 8. 모니터링 및 감사

### Secret 사용 추적:
- GitHub Actions 로그에서 사용 이력 확인
- Railway Dashboard에서 API 사용량 모니터링
- 비정상적인 활동 패턴 감시

### 정기적인 검토:
- **월별**: Secret 사용량 및 접근 패턴 검토
- **분기별**: 토큰 로테이션 및 권한 재검토
- **연별**: 전체 보안 정책 업데이트

## 9. 팀 환경에서의 관리

### 역할별 접근 권한:
- **Owner**: 모든 Secret 관리 가능
- **Admin**: Secret 읽기/쓰기 가능
- **Write**: 제한된 Secret만 접근
- **Read**: Secret 접근 불가

### 팀 워크플로우:
1. **개발자**: 로컬 개발용 .env 파일 사용
2. **DevOps**: Production secret 관리
3. **팀 리더**: Secret 정책 수립 및 감독

## 10. 백업 및 복구

### Secret 백업:
- **안전한 외부 저장소**에 암호화하여 보관
- **접근 권한자 최소화**
- **정기적인 백업 상태 확인**

### 복구 절차:
1. 새로운 토큰/키 생성
2. GitHub Secrets 업데이트
3. 배포 파이프라인 테스트
4. 이전 토큰 비활성화

---

## 요약 체크리스트

- [ ] Railway Token 생성 완료
- [ ] GitHub Repository Secret (RAILWAY_TOKEN) 설정 완료
- [ ] Rails Master Key Secret 설정 (필요시)
- [ ] 워크플로우에서 Secret 사용 확인
- [ ] 배포 테스트 성공
- [ ] 보안 정책 검토 완료
- [ ] 팀원 권한 설정 완료
- [ ] 모니터링 체계 구축 완료