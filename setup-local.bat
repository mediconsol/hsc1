@echo off
echo ========================================
echo  Hospital Management System Setup
echo ========================================
echo.

echo Checking prerequisites...
echo.

echo 1. Checking Ruby installation...
ruby --version
if %errorlevel% neq 0 (
    echo ERROR: Ruby not found. Please install Ruby 3.x
    echo Download from: https://rubyinstaller.org/
    pause
    exit /b 1
)

echo.
echo 2. Checking PostgreSQL...
psql --version
if %errorlevel% neq 0 (
    echo WARNING: PostgreSQL not found in PATH
    echo Please install PostgreSQL and add to PATH
    echo Download from: https://www.postgresql.org/download/windows/
    echo.
    echo Continue anyway? (y/n)
    set /p continue=
    if /i not "%continue%"=="y" exit /b 1
)

echo.
echo 3. Setting up Backend...
cd backend
echo Installing gems...
call bundle install
if %errorlevel% neq 0 (
    echo ERROR: Bundle install failed
    pause
    exit /b 1
)

echo.
echo Creating and setting up database...
call rails db:create
call rails db:migrate
call rails db:seed

cd ..

echo.
echo 4. Setting up Frontend...
cd frontend
echo Installing gems...
call bundle install
if %errorlevel% neq 0 (
    echo ERROR: Bundle install failed
    pause
    exit /b 1
)

echo.
echo Setting up frontend database...
call rails db:create
call rails db:migrate

cd ..

echo.
echo ========================================
echo  Setup Complete!
echo ========================================
echo.
echo To start the development servers:
echo   Backend:  cd backend && rails server -p 7001
echo   Frontend: cd frontend && rails server -p 7002
echo.
echo Or run: start-dev.bat
echo.
echo Default users:
echo   Admin: admin@hospital.com / password123
echo   Manager: manager@hospital.com / password123
echo   Staff: staff@hospital.com / password123
echo.
pause