# Consumer–Provider Handshake

## Thông tin chung

- **Lab:** FIT4110 Lab 03
- **Ngày:** 2026-05-19
- **Provider team:** team-gate
- **Consumer team:** team-core
- **Provider service:** Access Gate API (`contracts/gate.openapi.yaml`)
- **Consumer service:** Core Business Service

## Contract

- **Contract file:** `contracts/gate.openapi.yaml`
- **Mock base URL:** `http://localhost:4010`
- **Auth method:** Bearer Token (`Authorization: Bearer lab-token`)
- **Endpoint được test:**
  - `POST /access-events/verify` — team-core gọi để kiểm tra quyền truy cập của thẻ
  - `GET /access-events` — team-core gọi để lấy danh sách sự kiện

## Smoke test

### Request (Consumer: team-core → Provider mock: team-gate)

```http
POST /access-events/verify
Authorization: Bearer lab-token
Content-Type: application/json
```

```json
{
  "card_id": "CARD-STU-001",
  "gate_id": "GATE-MAIN-01"
}
```

### Expected response

```json
{
  "card_id": "CARD-STU-001",
  "gate_id": "GATE-MAIN-01",
  "decision": "allow",
  "reason": "Card is active and authorized"
}
```

## Consumer-side smoke test trong collection

Team-gate đóng vai consumer gọi mock của AI Vision (`{{aiVisionMockUrl}}/detect`) trong folder `05_Consumer_side_Smoke`.

### Request (Consumer: team-gate → Provider mock: team-vision)

```http
POST /detect
Authorization: Bearer lab-token
Content-Type: application/json
```

```json
{
  "image_url": "https://smart-campus.local/frames/cam-01/frame-001.jpg",
  "confidence_threshold": 0.8
}
```

### Expected response

```json
{
  "detections": [
    { "label": "PERSON-STU-001", "confidence": 0.95 }
  ],
  "model_version": "v2.1.0"
}
```

## Kết quả

- [x] Consumer gọi mock thành công.
- [x] Consumer parse được field cần dùng (`decision`, `reason`, `detections`).
- [x] Consumer hiểu lỗi 4xx/5xx provider trả về (ProblemDetails).
- [x] Có Newman report trong `reports/newman-report-mock.xml` và `reports/newman-report.html`.

## Ghi chú thay đổi hợp đồng

| Nội dung | Trước | Sau | Người đồng ý |
|---|---|---|---|
| Thêm endpoint `/access-events/verify` | Không có | Có | team-gate + team-core |
| Thêm `decision` enum `[allow, deny]` | Không có | Có | team-gate |
| Thêm `429 Too Many Requests` | Không có | Có | team-gate |

## Xác nhận

- **Provider representative:** team-gate
- **Consumer representative:** team-core
