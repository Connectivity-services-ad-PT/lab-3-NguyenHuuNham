@echo off
echo [1/4] Killing any existing prism processes...
taskkill /F /IM node.exe /T >nul 2>&1

echo [2/4] Starting Access Gate mock on port 4010...
start "prism-gate" /B cmd /c "npm run mock:gate > prism-gate.log 2>&1"

echo [3/4] Starting AI Vision mock on port 4011...
start "prism-vision" /B cmd /c "npm run mock:vision > prism-vision.log 2>&1"

echo [4/4] Waiting 8 seconds for mock servers to be ready...
timeout /t 8 /nobreak

echo [OK] Mock servers should be running. Check ports:
echo   Gate:   http://localhost:4010/health
echo   Vision: http://localhost:4011/models
