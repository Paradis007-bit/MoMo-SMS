import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'dsa'))
from parse_xml import parse_sms
import json
import base64
import sys
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'dsa'))

XML_PATH = os.path.join(os.path.dirname(__file__), '..',
                        'backend', 'data', 'raw', 'modified_sms_v2.xml')

transactions = parse_sms(XML_PATH)

USERS = {
    "admin": "password123"
}

# check for Basic Auth header and validate credentials


def check_auth(headers):
    auth = headers.get("Authorization", "")
    if not auth.startswith("Basic "):
        return False
    try:
        decoded = base64.b64decode(auth[6:]).decode("utf-8")
        username, password = decoded.split(":", 1)
        return USERS.get(username) == password
    except Exception:
        return False

# send JSON response with appropriate headers


def send_json(handler, status, data):
    body = json.dumps(data, indent=2).encode("utf-8")
    handler.send_response(status)
    handler.send_header("Content-Type", "application/json")
    handler.send_header("Content-Length", str(len(body)))
    handler.end_headers()
    handler.wfile.write(body)


class APIHandler(BaseHTTPRequestHandler):

    def log_message(self, format, *args):
        print(f"[{self.address_string()}] {format % args}")


    def do_GET(self):
        if not check_auth(self.headers):
            send_json(
                self, 401, {"Error": "Unauthorized. Provide valid Basic Auth credentials."})
            return

        parsed = urlparse(self.path)
        parts = parsed.path.strip("/").split("/")
        params = parse_qs(parsed.query)

        if parts[0] == "transactions":
            if len(parts) == 1:
                category = params.get("category", [None])[0]
                if category:
                    result = [
                        t for t in transactions if t["category"] == category]
                else:
                    result = transactions
                send_json(self, 200, {"count": len(
                    result), "transactions": result})

            elif len(parts) == 2:
                tx_id = parts[1]
                result = next(
                    (t for t in transactions if str(t["id"]) == tx_id), None)
                if result:
                    send_json(self, 200, result)
                else:
                    send_json(self, 404, {"Error": "Transaction not found."})
            else:
                send_json(self, 404, {"Error": "Endpoint not found."})
        else:
            send_json(self, 404, {"Error": "Endpoint not found."})

    
    def do_POST(self):
        if not check_auth(self.headers):
            send_json(
                self, 401, {"Error": "Unauthorized. Provide valid Basic Auth credentials."})
            return

        parsed = urlparse(self.path)
        parts = parsed.path.strip("/").split("/")

        if parts[0] == "transactions":
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length)
            try:
                new_tx = json.loads(body)
            except json.JSONDecodeError:
                send_json(self, 400, {"Error": "Invalid JSON body."})
                return

            new_tx["id"] = len(transactions) + 1
            if "category" not in new_tx:
                new_tx["category"] = "other"
            if "amount" not in new_tx:
                new_tx["amount"] = 0

            transactions.append(new_tx)
            send_json(
                self, 201, {"message": "Transaction created.", "transaction": new_tx})
        else:
            send_json(self, 404, {"Error": "Endpoint not found."})

    def do_PUT(self):
        if not check_auth(self.headers):
            send_json(
                self, 401, {"Error": "Unauthorized. Provide valid Basic Auth credentials."})
            return

        parsed = urlparse(self.path)
        parts = parsed.path.strip("/").split("/")

        if parts[0] == "transactions" and len(parts) == 2:
            tx_id = parts[1]
            index = next((i for i, t in enumerate(transactions)
                         if str(t["id"]) == tx_id), None)
            if index is None:
                send_json(self, 404, {"Error": "Transaction not found."})
                return

            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length)
            try:
                updates = json.loads(body)
            except json.JSONDecodeError:
                send_json(self, 400, {"Error": "Invalid JSON body."})
                return

            transactions[index].update(updates)
            send_json(self, 200, {
                      "message": "Transaction updated.", "transaction": transactions[index]})
        else:
            send_json(self, 404, {"Error": "Endpoint not found."})

    def do_DELETE(self):
        if not check_auth(self.headers):
            send_json(
                self, 401, {"Error": "Unauthorized. Provide valid Basic Auth credentials."})
            return

        parsed = urlparse(self.path)
        parts = parsed.path.strip("/").split("/")

        if parts[0] == "transactions" and len(parts) == 2:
            tx_id = parts[1]
            index = next((i for i, t in enumerate(transactions)
                         if str(t["id"]) == tx_id), None)
            if index is None:
                send_json(self, 404, {"Error": "Transaction not found."})
                return

            deleted = transactions.pop(index)
            send_json(
                self, 200, {"message": "Transaction deleted.", "transaction": deleted})
        else:
            send_json(self, 404, {"Error": "Endpoint not found."})


if __name__ == "__main__":
    port = 8000
    server = HTTPServer(("0.0.0.0", port), APIHandler)
    print(f"Server running on port {port}")
    print("Username: admin | Password: password123")
    server.serve_forever()
