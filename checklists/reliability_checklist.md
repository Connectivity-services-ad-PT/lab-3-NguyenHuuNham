# Reliability Checklist — FIT4110 Lab 03 — team-gate

**Sinh viên thực hiện:** Nguyễn Hữu Nhâm

## 1. Functional tests

- [x] Có test cho endpoint health.
- [x] Có test happy path cho endpoint chính (`POST /access-events` → 201).
- [x] Có kiểm tra status code 2xx.
- [x] Có kiểm tra field quan trọng trong response (`event_id`, `decision`, `reason`).
- [x] Có ít nhất 1 test đọc dữ liệu danh sách (`GET /access-events` → `items` array).

## 2. Auth tests

- [x] Có test thiếu token (`POST /access-events` không có `Authorization` header).
- [x] Có test sai token (`Authorization: Bearer invalid-token-xyz`).
- [x] Endpoint public được khai báo rõ (`GET /health` có `security: []`).
- [x] Test thể hiện đúng expected status 401/403.

## 3. Negative tests

- [x] Có test thiếu field bắt buộc (`card_id` missing → 400/422).
- [x] Có test sai kiểu dữ liệu (không áp dụng trực tiếp, dùng sai enum).
- [x] Có test sai enum (`direction: "sideways"` → 400/422).
- [x] Lỗi trả về theo cùng một error model (`ProblemDetails`).

## 4. Boundary tests

- [x] Có test max boundary (`limit=100` cho `GET /access-events`).
- [x] Có test limit/pagination ngoài miền (`limit=0`).
- [x] Có test card_id tại minLength (3 ký tự).
- [x] Có ghi chú kỳ vọng xử lý dữ liệu biên (response 200/400 đều được document).

## 5. Reliability tests cơ bản

- [x] Có kiểm tra response time (folder `06_Local_only_NonFunctional`).
- [x] Có mô tả timeout mong muốn (< 1000ms trên service thật).
- [x] Có ghi chú idempotency: `POST /access-events` ghi nhận sự kiện, không idempotent.
- [x] Có consumer-side smoke test gọi mock AI Vision (`{{aiVisionMockUrl}}/detect` và `/models`).

## 6. Evidence

- [x] Collection export JSON: `postman/collections/FIT4110_lab03_gate.postman_collection.json`
- [x] Environment mock export JSON: `postman/environments/FIT4110_lab03_mock.postman_environment.json`
- [x] Environment local export JSON: `postman/environments/FIT4110_lab03_local.postman_environment.json`
- [x] Newman report XML/HTML: `reports/newman-report-mock.xml`, `reports/newman-report.html`
- [x] Test-case matrix đã điền: `templates/test-case-matrix.csv` (16 test cases)
- [x] Biên bản handshake đã điền: `templates/consumer-provider-handshake.md`
