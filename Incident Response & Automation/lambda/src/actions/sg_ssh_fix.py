import boto3
import logging
import os

logger = logging.getLogger()

def execute(event):
    """
    Revokes Open SSH (0.0.0.0/0) on port 22.
    """
    ec2 = boto3.client("ec2")
    
    # AWS Config events send the resource ID here
    sg_id = event.get("detail", {}).get("resourceId")
    
    if not sg_id:
        return "❌ Error: No Security Group ID found in event"

    try:
        # Check if it's actually open (Double Tap)
        response = ec2.describe_security_groups(GroupIds=[sg_id])
        if not response["SecurityGroups"]:
            return f"⚠️ Security Group {sg_id} not found (maybe already deleted?)"

        sg = response["SecurityGroups"][0]
        remediated = False

        for rule in sg.get("IpPermissions", []):
            # Check for TCP/22
            if rule.get("FromPort") == 22 and rule.get("ToPort") == 22:
                for ip_range in rule.get("IpRanges", []):
                    if ip_range.get("CidrIp") == "0.0.0.0/0":
                        
                        logger.info(f"🔥 Revoking Open SSH on {sg_id}")
                        ec2.revoke_security_group_ingress(
                            GroupId=sg_id,
                            IpProtocol="tcp",
                            FromPort=22,
                            ToPort=22,
                            CidrIp="0.0.0.0/0"
                        )
                        remediated = True

        if remediated:
            return f"✅ REVOKED Open SSH on {sg_id}"
        else:
            return f"ℹ️ No Open SSH found on {sg_id} (False Positive?)"

    except Exception as e:
        logger.error(f"Failed to remediate SG {sg_id}: {str(e)}")
        raise e