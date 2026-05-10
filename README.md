# MoMo-SMS

# Team EMPERIUM

**Members:**
1. Mukamugisha Pascaline
2. Monique Niyobyose
3. Anas Khalid Nasir
4. Hirwa Paradis Cesar

---

# Project Description

MoMo-SMS is a full-stack web application built to make sense of Mobile Money transaction data. It processes raw SMS messages from an XML file, cleans the data, groups transactions by type, and saves everything into a database. Users can then explore their transaction history through a clean, easy-to-use dashboard.

---

# Project Structure

```
MoMo-SMS/
│
├── README.md
├── .env.example
├── requirements.txt
│
├── frontend/
│   ├── index.html
│   ├── register.html
│   ├── dashboard.html
│   ├── send-money.html
│   ├── pay-merchant.html
│   ├── transactions.html
│   ├── css/
│   │   └── styles.css
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
    │   │   ├── authController.js
    │   │   ├── walletController.js
    │   │   └── transactionController.js
    │   ├── services/
    │   │   ├── authService.js
    │   │   ├── walletService.js
    │   │   └── transactionService.js
    │   ├── models/
    │   │   ├── User.js
    │   │   ├── Wallet.js
    │   │   └── Transaction.js
    │   ├── routes/
    │   │   ├── authRoutes.js
    │   │   ├── walletRoutes.js
    │   │   └── transactionRoutes.js
    │   └── middleware/
    │       └── auth.js
    ├── config/
    │   └── db.js
    ├── etl/
    │   ├── config.py
    │   ├── parse_xml.py
    │   ├── clean_normalize.py
    │   ├── categorize.py
    │   ├── load_db.py
    │   └── run.py
    ├── data/
    │   ├── raw/
    │   ├── processed/
    │   └── logs/
    │       └── dead_letter/
    ├── scripts/
    │   ├── run_etl.sh
    │   └── serve_frontend.sh
    ├── tests/
    │   ├── test_parse_xml.py
    │   ├── test_clean_normalize.py
    │   └── test_categorize.py
    └── package.json
```

---

# Scrum Board

Our team uses a Trello board to manage tasks and track progress following Agile practices. The board helps us see what needs to be done, what is currently in progress, and what has been completed. It is organized into the following columns:

- To Do
- In Progress
- Done

All team members update the board regularly, ensuring transparency and smooth collaboration throughout the project.

**Scrum Board Link:**

-  [Trello Scrum Board](https://trello.com/b/288w3gd7/my-trello-board)

---

# High-Level System Architecture

**Week 1 :**

**Draw.io Architecture Diagram link:**
https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&dark=0#G1K5mjgxxOaDQ69c7VAwRNcYyzFGd9lRhZ

