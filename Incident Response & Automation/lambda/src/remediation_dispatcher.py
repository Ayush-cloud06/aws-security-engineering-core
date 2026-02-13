import logging
import json
import os
import boto3
from actions import root_key_fix, s3_public_fix, sg_ssh_fix

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Central SNS for alerts (make sure to set this env var in Terraform!)
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")
sns = boto3.client("sns")

def alert(subject, message):
    if SNS_TOPIC_ARN:
        sns.publish(TopicArn=SNS_TOPIC_ARN, Subject=subject, Message=message)

def lambda_handler(event, context):
    logger.info(f"📨 Received Event: {json.dumps(event)}")
    
    source = event.get("source", "")
    detail_type = event.get("detail-type", "")
    detail = event.get("detail", {})
    
    result_msg = "No action taken"

    # --- ROUTING LOGIC ---

    # 1. Root Key Detection (CloudTrail via EventBridge)
    if source == "aws.iam" and detail.get("eventName") == "CreateAccessKey":
        if detail.get("userIdentity", {}).get("type") == "Root":
            result_msg = fix_root.execute(event)
            alert("🚨 Security Auto-Fix: Root Key", result_msg)

    # 2. Open SSH Detection (AWS Config)
    elif source == "aws.config" and "restricted-ssh" in str(detail.get("configRuleName", "")):
        if detail.get("newEvaluationResult", {}).get("complianceType") == "NON_COMPLIANT":
            result_msg = fix_sg.execute(event)
            alert("🚨 Security Auto-Fix: Security Group", result_msg)

    # 3. Public S3 Detection (AWS Config)
    elif source == "aws.config" and "s3-bucket-public-read" in str(detail.get("configRuleName", "")):
        if detail.get("newEvaluationResult", {}).get("complianceType") == "NON_COMPLIANT":
            result_msg = fix_s3.execute(event)
            alert("🚨 Security Auto-Fix: S3 Bucket", result_msg)

    logger.info(f"🏁 Dispatch Complete: {result_msg}")
    return {"status": "success", "action": result_msg}