import xml.etree.ElementTree as ET
import re
import json


def parse_amount(text):
    match = re.search(r'[\d,]+(?:\.\d+)?\s*RWF', text)
    if match:
        return int(match.group().replace(',', '').replace(' RWF', '').replace('RWF', ''))
    return 0


def get_category(body):
    if 'received' in body and 'mobile money account' in body:
        return 'incoming'
    if 'bank deposit' in body or 'Cash Deposit' in body:
        return 'deposit'
    if 'transferred to' in body or 'payment of' in body:
        return 'outgoing'
    if 'withdrawn' in body:
        return 'withdrawal'
    if 'Airtime' in body or 'Cash Power' in body or 'Bundles' in body or 'WASAC' in body:
        return 'payment'
    if 'one-time password' in body:
        return 'otp'
    return 'other'


def parse_sms(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    transactions = []
    tx_id = 1

    for sms in root.findall('sms'):
        body = sms.get('body', '')
        readable_date = sms.get('readable_date', '')
        date_ts = int(sms.get('date', 0))

        category = get_category(body)
        amount = parse_amount(body)

        balance_match = re.search(r'(?:new balance[:\s]*|NEW BALANCE\s*:)\s*([\d,]+)\s*RWF', body, re.IGNORECASE)
        balance = int(balance_match.group(1).replace(',', '')) if balance_match else 0

        txid_match = re.search(r'(?:TxId[:\s]*|Financial Transaction Id[:\s]*)([\d]+)', body)
        transaction_id = txid_match.group(1) if txid_match else str(tx_id)

        record = {
            "id": tx_id,
            "transaction_id": transaction_id,
            "date": readable_date,
            "timestamp": date_ts,
            "category": category,
            "amount": amount,
            "balance": balance,
            "body": body
        }

        transactions.append(record)
        tx_id += 1

    return transactions


if __name__ == "__main__":
    data = parse_sms("../backend/data/raw/modified_sms_v2.xml")
    print(json.dumps(data[:3], indent=2))