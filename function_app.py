import azure.functions as func
import datetime
import json
import logging
import os

from azure.cosmosdb.table.tableservice import TableService
from azure.cosmosdb.table.models import Entity

app = func.FunctionApp()

@app.function_name(name="update_counter")
@app.route(route="update_counter", auth_level=func.AuthLevel.FUNCTION)
def update_counter(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    connection_string = os.environ['AZURE_TABLES_CONNECTION_STRING']
    table_service = TableService(connection_string=connection_string)
    table_name = "visitorCounts"

    partition_key = "VisitorCounter"
    row_key = "Counter"

    try:
        # Retrieve the entity
        entity = table_service.get_entity(table_name, partition_key, row_key)
        # Increment the count
        entity['Count'] += 1
        # Update the entity
        table_service.update_entity(table_name, entity)
    except Exception as e:
        logging.info(f"Entity not found or other error: {e}")
        # Create a new entity if not exists
        entity = Entity()
        entity.PartitionKey = partition_key
        entity.RowKey = row_key
        entity.Count = 1
        table_service.insert_entity(table_name, entity)

    return func.HttpResponse(str(entity['Count']), status_code=200)