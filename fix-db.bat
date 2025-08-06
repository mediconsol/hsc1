@echo off
echo PostgreSQL Connection Test and Fix
echo.

echo 1. Testing different PostgreSQL password configurations...
echo.

echo Try 1: Default password (password)
set DATABASE_PASSWORD=password
cd backend
call rails db:create
if %errorlevel% equ 0 (
    echo SUCCESS with password: password
    goto success
)

echo.
echo Try 2: Empty password
set DATABASE_PASSWORD=
call rails db:create
if %errorlevel% equ 0 (
    echo SUCCESS with empty password
    goto success
)

echo.
echo Try 3: postgres password
set DATABASE_PASSWORD=postgres
call rails db:create
if %errorlevel% equ 0 (
    echo SUCCESS with password: postgres
    goto success
)

echo.
echo Try 4: admin password  
set DATABASE_PASSWORD=admin
call rails db:create
if %errorlevel% equ 0 (
    echo SUCCESS with password: admin
    goto success
)

echo.
echo All attempts failed. Please check:
echo 1. PostgreSQL service is running
echo 2. Username 'postgres' exists
echo 3. Correct password
echo.
echo To manually test PostgreSQL connection:
echo   "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -h localhost
echo.
goto end

:success
echo.
echo Database created successfully!
echo Running migrations and seeds...
call rails db:migrate
call rails db:seed
echo.
echo Setup complete! You can now start the server:
echo   rails server -p 7001

:end
pause