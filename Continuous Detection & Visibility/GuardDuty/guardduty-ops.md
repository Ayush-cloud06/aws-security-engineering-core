# Check if GuardDuty is enabled
aws guardduty list-detectors

# Get detector ID
aws guardduty list-detectors --query 'DetectorIds[0]' --output text

# List recent findings
aws guardduty list-findings \
  --detector-id <detector-id> \
  --finding-criteria '{
    "Criterion": {
      "severity": {
        "Gte": 7
      }
    }
  }'

# Get details of a finding
aws guardduty get-findings \
  --detector-id <detector-id> \
  --finding-ids <id1> <id2>

# Check IP sets
aws guardduty list-ip-sets --detector-id <detector-id>

# Check Threat Intel Sets
aws guardduty list-threat-intel-sets --detector-id <detector-id>

# Check malware protection plans
aws guardduty list-malware-protection-plans
