from typing import Annotated

import pandas
from fastapi import FastAPI, UploadFile


app = FastAPI()

@app.post("/convert_xlsx/")
async def create_upload_file(file: UploadFile):
    excel_data_df = pandas.read_excel(file.file)
    json_str = excel_data_df.to_json(orient='records')
    return json_str
