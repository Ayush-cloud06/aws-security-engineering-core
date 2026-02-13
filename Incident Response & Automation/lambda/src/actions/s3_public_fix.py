import boto3
import logging

logger = logging.getLogger()

def execute(event):
    """
    Blocks Public Access on an S3 Bucket.
    """
    s3 = boto3.client("s3")
    
    bucket_name = event.get("detail", {}).get("resourceId")
    
    if not bucket_name:
        return "❌ Error: No Bucket Name found in event"

    try:
        logger.info(f"🛡️ Applying Public Access Block to {bucket_name}")
        
        s3.put_public_access_block(
            Bucket=bucket_name,
            PublicAccessBlockConfiguration={
                "BlockPublicAcls": True,
                "IgnorePublicAcls": True,
                "BlockPublicPolicy": True,
                "RestrictPublicBuckets": True
            }
        )
        return f"✅ BLOCKED Public Access for {bucket_name}"

    except Exception as e:
        logger.error(f"Failed to fix bucket {bucket_name}: {str(e)}")
        raise e