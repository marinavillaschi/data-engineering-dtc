import pandas as pd
import os
from sqlalchemy import create_engine
from time import time
from decouple import config

DATABASE_URL=config("DATABASE_URL")
TABLE_NAME=config("TABLE_NAME")
DATA_FILE_NAME=config("DATA_FILE_NAME")
# DATA_URL=config("DATA_URL")


def main():

    print('downloading data...')

    # try:
    #     os.system(f"wget {DATA_URL} -O {DATA_FILE_NAME}")
    #     csv_filename=DATA_FILE_NAME
    # except:
        # DATA_FILE_NAME = DATA_URL.split('/')[0]
        # print(DATA_FILE_NAME)
    
    engine = create_engine(DATABASE_URL)
    engine.connect()

    df = pd.read_csv(DATA_FILE_NAME, nrows=10)

    print(f'creating table {TABLE_NAME} on db...')
    df.head(0).to_sql(name=TABLE_NAME, con=engine, if_exists='replace')

    with pd.read_csv(DATA_FILE_NAME, chunksize=100000) as iter_df:
        
        for df_chunk in iter_df:

            t_start = time()

            try:
                df_chunk.tpep_pickup_datetime = pd.to_datetime(df_chunk.tpep_pickup_datetime)
                df_chunk.tpep_dropoff_datetime = pd.to_datetime(df_chunk.tpep_dropoff_datetime)

            except:
                pass

            df_chunk.to_sql(name=TABLE_NAME, con=engine, if_exists='append')

            t_end = time()

            print(f'chunk done in {t_end-t_start} seconds')
    
    print('\nall done ingesting data!')


if __name__ == "__main__":
    main()