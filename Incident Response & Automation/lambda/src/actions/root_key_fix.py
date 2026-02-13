import boto3
import logging

logger = logging.getLogger()

def execute(event):
    """
    Logic taken from ayush-cloud06/aws-automated-remediation-guardrails
    """
    iam = boto3.client("iam")
    
    keys = iam.list_access_keys(UserName='root')["AccessKeyMetadata"]
    
    remediated_count = 0
    for key in keys:
        key_id = key["AccessKeyId"]
        logger.info(f"🗑️ Deleting Root Access Key: {key_id}")
        
        iam.delete_access_key(
            UserName='root', 
            AccessKeyId=key_id
        )
        remediated_count += 1
        
    return f"Remediated {remediated_count} root keys"