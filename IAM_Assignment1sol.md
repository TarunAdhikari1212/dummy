# IAM ASSIGNMENT - 1 SOLUTIONS

## 1. Restrict S3 Bucket Access to Specific EC2 Instance:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow a specific EC2 instance to read and write a bucket.”
	    “Effect” : “Allow”,
	    “Action” : [	“s3:GetObject”,
                        “s3:PutObject”],
	    “Resource” : “arn:aws:s3:::sample-bucket/*”,
	    “Condition” : {
		    “StringEquals”:{
			    “aws:ResourceTag/InstanceID” : “i-043sample90l0e900”
                            }
            }
    },
    ]
}
```

## 2. Deny All EC2 Actions Except Run Instance:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow only run instance”,
	    “Effect” : “Allow”,
	    “Action” : “ec2:RunInstances”,
	    “Resource” : “arn:aws:ec2:::*”
    }
    ]
    “Statement”: [
    {
	    “Sid”: “Deny all ec2 access”,
	    “Effect” : “Deny”,
	    “Action” : “ec2:*”,
	    “Resource” : “arn:aws:ec2:::*”
    },
    ]
}
```


## 3. Deny Actions Outside of us-east-1 Region:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Effect” : “Deny”,
	    “Action” : “*”,
	    “Resource” : “*”,
        “Condition”:
        {
            “StringNotEquals”:
                {“aws:RequestedRegion”: “us-east-1”
                }
        }
    }
    ]
}
```

## 4. Enforce Tagging for Resources:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow a resource with tags to be created”
	    “Effect” : “Allow”,
	    “Action” : [“*:Create*”, “*:Run*”],
	    “Resource” : “*”,
	    “Condition”:{
		    “Null”:{
			    “aws:RequestTag/tag-key”: “true”
			    }
        }
    },
    ]
}
```

## 5. Allow Limited Access to EC2 Instances Based on Tags:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow a EC2 action only if tag is found”
	    “Effect” : “Allow”,
	    “Action” : “ec2:RunInstances”,
	    “Resource” : “arn:aws:ec2:::*”
        “Condition” : {
		    “StringEquals”:{
			    “aws:ResourceTag/Environment” : “Development”
            }
        }
    },
    ]
}
```

## 6. Grant S3 Read-Only Access for a Specific IAM User:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow S3 bucket access to a specific user”
	    “Effect” : “Allow”,
	    “Action” : [ “s3:Get*”, “s3:List*” ],
	    “Resource” : “arn:aws:s3:::*”
        “Condition”: {
            “StringEquals”:{
          		“aws:PrincipalARN”: “arn:aws:iam:::target-iam-user”
            }
        }
    },
    ]
}
```

## 7. Implement Time-Based Access Control:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow EC2 instance termination only during 1800 hrs to 2200 hrs”
	    “Effect” : “Allow”,
	    “Action” : “ec2:TerminateInstance”,
	    “Resource” : “arn:aws:ec2:::*”
        “Condition”: {
            “DateGreaterThan”: {“aws:CurrentTime” : “18:00:00Z”},
            “DateLessThan”: {“aws:CurrentTime” : “22:00:00Z”}
        }
    },
    ]
}
```

## 8. Conditional Access Based on IP Address:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow access to resources only if belonging to a specific block”
	    “Effect” : “Allow”,
	    “Action” : “*”,
	    “Resource” : “*”
        “Condition”: {
            “IpAddress”: {“aws:SourceIp” : “192.168.1.0/22”}
        }
    },
    ]
}
```

## 9. Role Assumption with MFA:

```
{
    “Version” : “2012-10-17”,
    “Statement”: [
    {
	    “Sid”: “Allow only to assume role if MFA is enabled”
	    “Effect” : “Allow”,
	    “Action” : “sts:AssumeRole”,
    	“Resource” : “*”
        “Condition”: {
            “Bool”: {“aws:MultiFactorAuthPresent” : “true”}
        }
    },
    ]
}
```

## 10. IAM Policy for Cross-Account Access:

```
{
    "Version":"2012-10-17",
    "Statement":[{
        "Sid":"Allow cross account access to a s3 bucket",
        "Effect":"Allow",
        "Principal":{
            "AWS":"arn:aws:::destinationaccountid:"
        },
        "Action":"sts:AssumeRole",
        "Resource":"arn:aws:s3:::"
    }
    ]
}
```