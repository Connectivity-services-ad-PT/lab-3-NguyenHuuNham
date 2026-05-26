# Consumer–Provider Handshake

## Thông tin chung

- **Lab:** FIT4110 Lab 03
- **Ngày:** 2026-05-26
- **Sinh viên thực hiện:** Nguyễn Hữu Nhâm
- **Provider team:** team-core (Core Business)
- **Consumer team:** team-gate (Access Gate)
- **Provider service:** Core Business Access Policy API (`contracts/gate.openapi.yaml`)
- **Consumer service:** Access Gate Service

## Contract

- **Contract file:** `contracts/gate.openapi.yaml`
- **Mock base URL:** `http://127.0.0.1:4010`
- **Auth method:** Bearer Token (`Authorization: Bearer lab-token`)
- **Endpoint được test:**
  - `POST /access/check` — Access Gate gọi Core Business realtime để kiểm tra policy ra/vào trước khi mở cổng
  - `GET /policies/access` — Access Gate lấy danh sách policy ra/vào để đồng bộ cache hoặc audit

## Smoke test

### Request (Consumer: team-gate → Provider mock: team-core)

```http
POST /access/check
Authorization: Bearer lab-token
Content-Type: application/json
```

```json
{
  "cardId": "RFID-2026-001",
  "gateId": "GATE-01",
  "direction": "IN",
  "timestamp": "2026-05-10T08:00:00Z",
  "idempotencyKey": "0196fb3d-4ad7-7d1e-9f49-5d5148d2babe"
}
```

### Expected response

```json
{
  "decisionId": "0196fb3d-4ad7-7d1e-9f49-5d5148d2babf",
  "decision": "ALLOW",
  "reasonCode": null,
  "policyId": "0196fb3d-4ad7-7d1e-9f49-5d5148d2bac0",
  "expiresAt": "2026-05-10T08:05:00Z",
  "checkedAt": "2026-05-10T08:00:00Z"
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
- [x] Consumer parse được field cần dùng (`decision`, `policyId`, `detections`).
- [x] Consumer hiểu lỗi 4xx/5xx provider trả về (Problem).
- [x] Có Newman report trong `reports/newman-report-mock.xml` và `reports/newman-report.html`.

## Ghi chú thay đổi hợp đồng

| Nội dung | Trước | Sau | Người đồng ý |
|---|---|---|---|
| Thay đổi Provider sang Core Business | team-gate là Provider | team-core (Core Business) là Provider | team-gate + team-core |
| Cập nhật endpoint chính | `POST /access-events` | `POST /access/check` | team-gate + team-core |
| Thêm endpoint quản lý policy | Không có | `GET /policies/access` | team-gate + team-core |
| Thao tác lỗi Problem định dạng chuẩn | ProblemDetails cũ | Problem schema mới với `errors` array | team-gate + team-core |

## Xác nhận

- **Provider representative:** team-core (Core Business)
- **Consumer representative:** team-gate (Nguyễn Hữu Nhâm)
