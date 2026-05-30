# MoMo SMS API Documentation

**Base URL:** `http://localhost:8000`  
**Authentication:** Basic Auth — username: `admin`, password: `password123`

---

## How to run the server

```bash
python api/server.py
```

Then open a second terminal to send requests with curl.

---

## Endpoints

### GET /transactions

Returns all transactions. You can filter by category using a query parameter.

```bash
# Get all
curl -u admin:password123 http://localhost:8000/transactions

# Filter by category
curl -u admin:password123 "http://localhost:8000/transactions?category=incoming"
```

Available categories: `incoming`, `outgoing`, `deposit`, `withdrawal`, `payment`, `otp`, `other`

Response:
```json
{
  "count": 1691,
  "transactions": [
    {
      "id": 1,
      "transaction_id": "76662021700",
      "date": "10 May 2024 4:30:58 PM",
      "timestamp": 1715351458724,
      "category": "incoming",
      "amount": 2000,
      "balance": 2000,
      "body": "You have received 2000 RWF from Jane Smith..."
    }
  ]
}
```

---

### GET /transactions/{id}

Returns one transaction by ID.

```bash
curl -u admin:password123 http://localhost:8000/transactions/1
```

Returns 404 if the ID does not exist:
```json
{ "error": "Transaction not found." }
```

---

### POST /transactions

Adds a new transaction.

```bash
curl -u admin:password123 -X POST http://localhost:8000/transactions \
  -H "Content-Type: application/json" \
  -d "{\"category\": \"incoming\", \"amount\": 5000, \"date\": \"1 Jan 2025\", \"body\": \"Test payment\"}"
```

Response:
```json
{
  "message": "Transaction created.",
  "transaction": {
    "id": 1692,
    "category": "incoming",
    "amount": 5000,
    "date": "1 Jan 2025",
    "body": "Test payment"
  }
}
```

---

### PUT /transactions/{id}

Updates an existing transaction.

```bash
curl -u admin:password123 -X PUT http://localhost:8000/transactions/1 \
  -H "Content-Type: application/json" \
  -d "{\"category\": \"deposit\", \"amount\": 9999}"
```

Response:
```json
{
  "message": "Transaction updated.",
  "transaction": {
    "id": 1,
    "category": "deposit",
    "amount": 9999
  }
}
```

---

### DELETE /transactions/{id}

Deletes a transaction by ID.

```bash
curl -u admin:password123 -X DELETE http://localhost:8000/transactions/2
```

Response:
```json
{
  "message": "Transaction deleted.",
  "transaction": {
    "id": 2,
    "category": "outgoing",
    "amount": 1000
  }
}
```

---

## Authentication

All endpoints need Basic Auth. If you send wrong credentials or no credentials, you get a 401 response:

```json
{ "error": "Unauthorized. Provide valid Basic Auth credentials." }
```

---

## Transaction fields

| Field | Type | Description |
|-------|------|-------------|
| id | integer | Sequential ID assigned during parsing |
| transaction_id | string | Original transaction ID from the SMS |
| date | string | Readable date from the SMS |
| timestamp | integer | Unix timestamp in milliseconds |
| category | string | Type of transaction |
| amount | integer | Amount in RWF |
| balance | integer | Account balance after the transaction |
| body | string | Full SMS message text |

---

## DSA — Search comparison

We compared two ways to search through the 1691 transaction records:

**Linear search** loops through every record one by one until it finds a match. If the record is near the end, it takes longer. Time complexity: O(n).

**Dictionary lookup** builds a hash map from all transaction IDs first, then looks up any record directly. It does not matter how large the dataset is. Time complexity: O(1).

To run the comparison:
```bash
python dsa/search.py
```

The output shows the time each method takes for the same search targets, making it easy to see the difference.