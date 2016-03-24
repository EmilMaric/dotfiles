import boto3
import datetime
import logging
import json

ORDER_STATUS_KEY = 'Order_Status'
ORDER_ID_KEY = 'OrderID'
DELIVERER_ID_KEY = 'DelivererID'
USER_ID_KEY = 'UserID'
USER_PROFILE_NAME_KEY = 'user_profile_name'
USER_PROFILE_DATASET_NAME = 'user_profile_dataset'
USER_ENDPOINT_ARN_KEY = 'user_endpoint_arn'
RESTAURANT_KEY = 'Restaurant'
DESTINATION_KEY = 'Destination'

logger = logging.getLogger()
logger.setLevel(logging.INFO)

order_table = boto3.resource('dynamodb').Table('Orders')
sns_client = boto3.client('sns')
cognito_sync_client = boto3.client('cognito-sync')


def get_db_entry_attribute_value(entry, key):
    try:
        return entry[key]
    except:
        return None


def get_order_entry(order_id):
    try:
        response = order_table.get_item(
            Key={
                ORDER_ID_KEY: order_id
            }
        )
        return response['Item']
    except:
        return {}


def get_buyer_endpoint_arn(buyer_id):
    endpoint_arn = ""
    try:
        buyer_dataset = cognito_sync_client.list_records(
            IdentityPoolId='us-east-1:113538ee-5f7b-4639-87bc-52395a10bbfa',
            IdentityId=buyer_id,
            DatasetName=USER_PROFILE_DATASET_NAME
        )
        buyer_dataset_records = buyer_dataset['Records']
        for buyer_dataset_record in buyer_dataset_records:
            for k, v in buyer_dataset_record.iteritems():
                if isinstance(v, datetime.datetime):
                    buyer_dataset_record[k] = v.strftime(
                        '%m/%d/%Y-%H:%M:%S.%f')
            if buyer_dataset_record['Key'] == USER_ENDPOINT_ARN_KEY:
                endpoint_arn = buyer_dataset_record['Value']
        logger.debug("Dataset Records: " +
                     json.dumps(buyer_dataset_records, indent=2))
        return endpoint_arn
    except KeyError:
        return ""


def get_deliverer_info(deliverer_id):
    deliverer_info = {
        'id': deliverer_id
    }
    try:
        deliverer_dataset = cognito_sync_client.list_records(
            IdentityPoolId='us-east-1:113538ee-5f7b-4639-87bc-52395a10bbfa',
            IdentityId=deliverer_id,
            DatasetName=USER_PROFILE_DATASET_NAME
        )
        deliverer_dataset_records = deliverer_dataset['Records']
        for deliverer_dataset_record in deliverer_dataset_records:
            key = deliverer_dataset_record['Key']
            value = deliverer_dataset_record['Value']
            deliverer_info[key] = value
        if USER_PROFILE_NAME_KEY not in deliverer_info:
            deliverer_info[USER_PROFILE_NAME_KEY] = "A deliverer"
        return deliverer_info
    except:
        return deliverer_info


def send_push_notification(message, endpoint_arn):
    sns_client.publish(
        TargetArn=endpoint_arn,
        Message=json.dumps(message)
    )


def deliverer_assigned(order_id, deliverer_info, endpoint_arn):
    try:
        order_status = "Accepted"
        order_table.update_item(
            Key={
                ORDER_ID_KEY: order_id
            },
            UpdateExpression='SET ' + DELIVERER_ID_KEY + ' = :id,' +
                             ORDER_STATUS_KEY + ' = :os',
            ExpressionAttributeValues={
                ':id': deliverer_info[DELIVERER_ID_KEY],
                ':os': order_status
            }
        )
        logger.info(deliverer_info["USER_PROFILE_NAME_KEY"] +
                    " assigned for order " + order_id)

        message = deliverer_info["USER_PROFILE_NAME_KEY"] +\
            " has been assigned to your order!"
        message = {
            'Title': 'Deliverer Assigned',
            'Message': message,
            'Type': 0,
            'OrderID': order_id,
            'OrderAssignmentInfo': {
                'DelivererInfo': deliverer_info,
                'OrderStatus': order_status
            }
        }
        send_push_notification(message, endpoint_arn)
    except Exception as e:
        return {'Error': e}


def deliverer_unassigned(order_id, endpoint_arn):
    try:
        order_status = "Pending"
        order_table.update_item(
            Key={
                ORDER_ID_KEY: order_id
            },
            UpdateExpression='REMOVE ' + DELIVERER_ID_KEY + ' SET ' +
                             ORDER_STATUS_KEY + ' = :os',
            ExpressionAttributeValues={
                ':os': order_status
            }
        )
        logger.info("Deliverer unassigned from order " + order_id)

        message = {
            'Title': 'Deliverer Unassigned',
            'Message': 'Your deliverer was unassigned. ' +
                       'We are searching for another deliverer.',
            'Type': 1,
            'OrderID': order_id,
            'OrderAssignmentInfo': {
                'DelivererInfo': {
                    'Name': 'Unassigned',
                    'Phone': '',
                    'ImageURL': '',
                    'DelivererID': ''
                },
                'OrderStatus': 'Pending'
            }
        }
        send_push_notification(message, endpoint_arn)
    except Exception as e:
        return {'Error': e}


def order_status_update(order_id, order_status, deliverer_name,
                        restaurant, destination, endpoint_arn):
    try:
        order_table.update_item(
            Key={
                ORDER_ID_KEY: order_id
            },
            UpdateExpression='SET ' + ORDER_STATUS_KEY + ' = :os',
            ExpressionAttributeValues={
                ':os': order_status
            }
        )
        logger.info("Order " + order_id + " updated to " + order_status)

        if order_status == "In Progress":
            message = deliverer_name + " is on-route to " + restaurant + "."
        elif order_status == "Purchased":
            message = deliverer_name + " has purchased your order and is " +\
                "on-route to " + destination + "."
        elif order_status == "Completed":
            message = "Your order has been completed. Enjoy your food!"
        elif order_status == "Cancelled":
            message = "Your order has been cancelled."

        message = {
            'Title': 'Delivery Update',
            'Message': message,
            'Type': 2,
            'OrderID': order_id,
            'OrderAssignmentInfo': {
                'OrderStatus': order_status
            }
        }
        send_push_notification(message, endpoint_arn)
    except Exception as e:
        return {'Error': e}


def update_order_request(event, context):
    if ORDER_ID_KEY not in event:
        return {'Error': ORDER_ID_KEY + ' was not supplied'}
    order_id = event[ORDER_ID_KEY]
    order_entry = get_order_entry(order_id)

    buyer_id = get_db_entry_attribute_value(order_entry, USER_ID_KEY)
    buyer_endpoint_arn = get_buyer_endpoint_arn(buyer_id)

    old_order_status = get_db_entry_attribute_value(order_entry,
                                                    ORDER_STATUS_KEY)
    old_deliverer_id = get_db_entry_attribute_value(order_entry,
                                                    DELIVERER_ID_KEY)
    new_order_status = event[ORDER_STATUS_KEY] \
        if ORDER_STATUS_KEY in event else None
    new_deliverer_id = event[DELIVERER_ID_KEY] \
        if DELIVERER_ID_KEY in event else None

    if new_deliverer_id is not None and new_deliverer_id != old_deliverer_id:
        if new_deliverer_id:
            # deliverer assigned
            deliverer_info = get_deliverer_info(new_deliverer_id)
            error = deliverer_assigned(order_id, deliverer_info,
                                       buyer_endpoint_arn)
        else:
            error = deliverer_unassigned(order_id, buyer_endpoint_arn)
    elif new_order_status is not None and new_order_status != old_order_status:
        deliverer_info = get_deliverer_info(old_deliverer_id)
        deliverer_name = deliverer_info[USER_PROFILE_NAME_KEY]
        restaurant = get_db_entry_attribute_value(order_entry, RESTAURANT_KEY)
        destination = get_db_entry_attribute_value(order_entry,
                                                   DESTINATION_KEY)
        error = order_status_update(order_id, new_order_status, deliverer_name,
                                    restaurant, destination,
                                    buyer_endpoint_arn)
    return {"Error": error}
