from typing import Annotated

import pandas
from fastapi import FastAPI, UploadFile, HTTPException


app = FastAPI()

@app.post("/convert_xlsx/")
async def convert_excel_to_json(file: UploadFile):
    try:
        excel_data_df = pandas.read_excel(file.file)
        json_str = excel_data_df.to_json(orient='records')
        return json_str
    except:
        raise HTTPException(status_code=422, detail="Conversion was not succesfull")
