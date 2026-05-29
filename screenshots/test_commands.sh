#!/bin/bash

curl -u admin:password123 http://localhost:8000/transactions

curl -u admin:password123 "http://localhost:8000/transactions?category=incoming"

curl -u admin:password123 http://localhost:8000/transactions/1

curl -u wronguser:wrongpass http://localhost:8000/transactions

curl http://localhost:8000/transactions

curl -u admin:password123 -X POST http://localhost:8000/transactions \
  -H "Content-Type: application/json" \
  -d "{\"category\": \"incoming\", \"amount\": 5000, \"date\": \"1 Jan 2025\", \"body\": \"Test incoming payment\"}"

curl -u admin:password123 -X PUT http://localhost:8000/transactions/1 \
  -H "Content-Type: application/json" \
  -d "{\"category\": \"deposit\", \"amount\": 9999}"

curl -u admin:password123 -X DELETE http://localhost:8000/transactions/2

curl -u admin:password123 http://localhost:8000/transactions/99999