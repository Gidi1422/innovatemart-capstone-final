import json

def handler(event, context):
    # Extract the bucket and file name from the S3 event
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        print(f"Image received: {key} from bucket: {bucket}")
    
    return {
        'statusCode': 200,
        'body': json.dumps('Log processed successfully')
    }