@echo off
echo Starting Hospital Management System Development Environment
echo.

echo Starting PostgreSQL (requires PostgreSQL installation)...
echo Please make sure PostgreSQL is installed and running on port 5432
echo Default database: hospital_system_development
echo Default user: postgres
echo.

echo Starting Backend (Rails API) on port 7001...
start cmd /k "cd backend && bundle install && rails db:create db:migrate db:seed && rails server -p 7001"

echo.
echo Waiting 10 seconds for backend to start...
timeout /t 10 /nobreak

echo Starting Frontend (Hotwire) on port 7002...
start cmd /k "cd frontend && bundle install && rails db:create db:migrate && rails server -p 7002"

echo.
echo Development servers starting...
echo Backend: http://localhost:7001
echo Frontend: http://localhost:7002
echo.
echo Press any key to continue...
pause