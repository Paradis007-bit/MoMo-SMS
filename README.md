Team EMPERIUM
### Members:

Mukamugisha Pascaline
Monique Niyobyose
Anas Khalid Nasir
Hirwa Paradis Cesar

# MoMo-SMS

MoMo-SMS is a full-stack web application built to make sense of Mobile Money transaction data. It processes raw SMS messages from an XML file, cleans the data, groups transactions by type, and saves everything into a database. Users can then explore their transaction history through a clean, easy-to-use dashboard.


## Links

Architecture Diagram: https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=0#G1K5mjgxxOaDQ69c7VAwRNcYyzFGd9lRhZ

 Scrum Board :https://trello.com/b/288w3gd7/my-trello-board
 
 ERD Diagram Documentation: https://docs.google.com/document/d/1Q-lzg5gMEvYKbviP5TsyF_tCnm3lq1TU7N9RLxu3f84/edit?tab=t.0

 Team participation sheet:
 AI Usage Log :
---

## Project Structure

```
MoMo-SMS/
│
├── README.md
├── .env.example
├── requirements.txt
│
├── docs/
│   └── erd_diagram.png
│
├── database/
│   └── database_setup/
│       ├── init.sql
│       ├── roles.sql
│       ├── users.sql
│       ├── transaction_category.sql
│       ├── transactions.sql
│       ├── transaction_participants.sql
│       ├── system_logs.sql
│       └── indexes.sql
│
├── examples/
│   └── json_schemas.json
│
├── frontend/
│   ├── index.html
│   ├── register.html
│   ├── dashboard.html
│   ├── send-money.html
│   ├── pay-merchant.html
│   ├── transactions.html
│   ├── css/styles.css
│   └── js/
│       ├── api.js
│       ├── auth.js
│       ├── wallet.js
│       ├── transaction.js
│       └── ui.js
│
├── assets/
│
└── backend/
    ├── src/
    │   ├── app.js
    │   ├── controllers/
    │   ├── services/
    │   ├── models/
    │   ├── routes/
    │   └── middleware/
    ├── config/db.js
    ├── etl/
    ├── data/
    ├── scripts/
    ├── tests/
    └── package.json
```

---

## Database Design

We have six tables. Here is what each one does and how they connect:

**roles** — defines what type of user someone is: admin, agent, or customer. Every user gets a role.

**users** — stores everyone who appears in the MoMo SMS data. Each user has a phone number, full name, and a role. Phone numbers are unique so no duplicates can exist.

**Transaction_Categories** — groups transactions by type. The five types we found in the SMS data are: Incoming Money, Transfer, Payment, Airtime, and Withdrawal.

**transactions** — the main table. Every MoMo transaction goes here with its amount, fee, status, date, and category. The amount must always be greater than zero.

**transaction_participants** — the junction table that solves the many-to-many relationship between users and transactions. One transaction has two participants: a sender and a receiver.

**system_logs** — records every ETL pipeline event so we can track what was processed, what failed, and when.

### Table Relationships

| Relationship | Type |
|-------------|------|
| roles → users | 1:M |
| users → transaction_participants | 1:M |
| transactions → transaction_participants | 1:M |
| users ↔ transactions (via transaction_participants) | M:N |
| transactions → system_logs | 1:M |
| Transaction_Categories → transactions | 1:M |

---

## ERD Diagram
The ERD diagram added as a folder on the repository 
---

## Some of the Database Screenshots

### 1. Database Created
https://docs.google.com/document/d/184otarbCZM0CwUQYW3Q0yffriI4p8jVbMXG_CDDP5mc/edit?usp=sharing

### 2. Tables Created
https://docs.google.com/document/d/184otarbCZM0CwUQYW3Q0yffriI4p8jVbMXG_CDDP5mc/edit?usp=sharing

### 3. Sample Data Inserted
https://docs.google.com/document/d/184otarbCZM0CwUQYW3Q0yffriI4p8jVbMXG_CDDP5mc/edit?usp=sharing

### 4. Security Rule — Negative amount blocked
https://docs.google.com/document/d/184otarbCZM0CwUQYW3Q0yffriI4p8jVbMXG_CDDP5mc/edit?usp=sharing
### 5.Indexes Created
https://docs.google.com/document/d/184otarbCZM0CwUQYW3Q0yffriI4p8jVbMXG_CDDP5mc/edit?usp=sharing

---

## JSON to SQL Mapping

The `examples/json_schemas.json` file shows how each database table maps to a JSON API response:

| SQL Table | JSON Key |
|-----------|----------|
| users | users_example |
| roles | roles_example |
| Transaction_Categories | transaction_categories_example |
| transactions | transactions_example |
| system_logs | system_logs_example |
| All tables combined | complex_transaction_example |

The `complex_transaction_example` shows a full API response — one transaction with the sender, receiver, category, and log all nested inside it.

---

## How to Run

**Database setup**
```bash
mysql -u root -p < database/database_setup/init.sql
```

**ETL Pipeline**
```bash
pip install -r requirements.txt
python backend/etl/run.py --xml backend/data/raw/momo.xml
```

**Backend API**
```bash
cd backend
npm install
npm run dev
```

**Frontend**
```bash
python -m http.server 8080 --directory frontend
```

---
## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML, CSS, JavaScript |
| Backend | Node.js, Express |
| ETL | Python, ElementTree |
| Database | MySQL |
| Testing | pytest |