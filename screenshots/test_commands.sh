#!/bin/bash

# Week 3 curl test commands
# Run the server first: python api/server.py
# Then open a second terminal and run these one by one

echo "=== TEST 1: GET all transactions with valid auth ==="
curl -u admin:password123 http://localhost:8000/transactions

echo ""
echo "=== TEST 2: GET transactions filtered by category ==="
curl -u admin:password123 "http://localhost:8000/transactions?category=incoming"

echo ""
echo "=== TEST 3: GET a single transaction by ID ==="
curl -u admin:password123 http://localhost:8000/transactions/1

echo ""
echo "=== TEST 4: GET with wrong credentials - should return 401 ==="
curl -u wronguser:wrongpass http://localhost:8000/transactions

echo ""
echo "=== TEST 5: GET with no credentials - should return 401 ==="
curl http://localhost:8000/transactions

echo ""
echo "=== TEST 6: POST - create a new transaction ==="
curl -u admin:password123 -X POST http://localhost:8000/transactions \
  -H "Content-Type: application/json" \
  -d '{"category": "incoming", "amount": 5000, "date": "1 Jan 2025", "body": "Test incoming payment"}'

echo ""
echo "=== TEST 7: PUT - update a transaction ==="
curl -u admin:password123 -X PUT http://localhost:8000/transactions/1 \
  -H "Content-Type: application/json" \
  -d '{"category": "deposit", "amount": 9999}'

echo ""
echo "=== TEST 8: DELETE - delete a transaction ==="
curl -u admin:password123 -X DELETE http://localhost:8000/transactions/2

echo ""
echo "=== TEST 9: GET non-existent ID - should return 404 ==="
curl -u admin:password123 http://localhost:8000/transactions/99999

echo ""
echo "Done. Take screenshots of each output above."