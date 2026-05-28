import time
from parse_xml import parse_sms

#linear search 
def linear_search(transactions, target_id):
    for tx in transactions:
        if tx["transaction_id"] == target_id:
            return tx
    return None


def build_lookup(transactions):
    lookup = {}
    for tx in transactions:
        lookup[tx["transaction_id"]] = tx
    return lookup


def dictionary_search(lookup, target_id):
    return lookup.get(target_id)


def compare_search(xml_file, targets):
    transactions = parse_sms(xml_file)
    lookup = build_lookup(transactions)

    print(f"Dataset size: {len(transactions)} records\n")
    print(f"{'Method':<25} {'Target':<20} {'Time (ms)':<15} {'Found'}")
    print("-" * 70)

    for target in targets:
        start = time.perf_counter()
        result1 = linear_search(transactions, target)
        time1 = (time.perf_counter() - start) * 1000

        start = time.perf_counter()
        result2 = dictionary_search(lookup, target)
        time2 = (time.perf_counter() - start) * 1000

        found1 = "Yes" if result1 else "No"
        found2 = "Yes" if result2 else "No"

        print(f"{'Linear Search':<25} {target:<20} {time1:<15.6f} {found1}")
        print(f"{'Dictionary Lookup':<25} {target:<20} {time2:<15.6f} {found2}")
        print()

    print("Explanation:")
    print("Linear search goes through every record one by one. Time grows with dataset size: O(n).")
    print("Dictionary lookup uses a hash table. It finds records almost instantly: O(1).")
    print("For large datasets, dictionary lookup is much faster than linear search.")


if __name__ == "__main__":
    targets = ["73214484437", "45434420466", "99999999999"]
    compare_search("../backend/data/raw/modified_sms_v2.xml", targets)