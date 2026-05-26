# Reliability Checklist - FIT4110 Lab 03

Completed for Pair 10: Access Gate consumer with Core Business provider, plus Analytics consumer-side smoke test.

## 1. Functional tests

- [x] Health endpoint is tested: `GET /health`.
- [x] Main happy path is tested: `POST /access/check`.
- [x] 2xx status codes are asserted.
- [x] Important response fields are asserted: `decisionId`, `decision`, `policyId`, `checkedAt`.
- [x] List/detail reads are tested: `GET /policies/access`, `GET /policies/access/{policyId}`, `GET /decisions`.

## 2. Auth tests

- [x] Missing token is tested on `POST /access/check`.
- [x] Invalid token behavior is tested without using `Prefer: code=401`.
- [x] Public endpoint is explicit: `/health` has no security requirement.
- [x] Expected unauthorized status is documented as 401/403 for local service.

## 3. Negative tests

- [x] Missing required field is tested: missing `cardId`.
- [x] Invalid enum is tested: `direction=SIDEWAYS`.
- [x] Invalid query boundary is tested: `limit=101`.
- [x] Error response model uses Problem Details with `status` between 400 and 599.

## 4. Boundary tests

- [x] Pagination lower boundary is tested: `limit=1`.
- [x] Pagination maximum is protected by negative test: `limit=101`.
- [x] Nullable optional idempotency key is tested.
- [x] Expected idempotency behavior is documented from negotiation issue #3.

## 5. Reliability tests

- [x] SLA from negotiation issue #1 is represented: local `/access/check` should respond under 500ms.
- [x] Timeout/fallback expectation is documented from negotiation issue #2.
- [x] Retry/idempotency concern is covered with optional `idempotencyKey`.
- [x] Consumer-side smoke test calls Analytics mock at `POST /analytics/access-events`.

## 6. Evidence

- [x] Collection export JSON: `postman/collections/access-gate-core.postman_collection.json`.
- [x] Mock environment export JSON: `postman/environments/access-gate-core_mock.postman_environment.json`.
- [x] Local environment export JSON: `postman/environments/access-gate-core_local.postman_environment.json`.
- [x] Newman report target: `reports/newman-report.xml` and `reports/newman-report.html`.
- [x] Contract lint report target: `reports/contract-lint-report.txt`.
- [x] Test-case matrix is completed: `templates/test-case-matrix.csv`.
- [x] Consumer-provider handshake is completed: `templates/consumer-provider-handshake.md`.
