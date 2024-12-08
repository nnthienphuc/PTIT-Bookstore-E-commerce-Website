import pyodbc 
from typing import Union
import pickle
import pandas as pd
from sklearn.preprocessing import LabelEncoder,MinMaxScaler
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import collections, numpy
import numpy as np
import pyodbc
# pip install SQLAlchemy
from sqlalchemy.engine import URL
from sqlalchemy import create_engine
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
sv='RUFFA'
db='OnlineBookStore'
pwd="123456"

server='RUFFA,1433'
database = 'OnlineBookStore'
username = 'sa' 
password = '123456' 

connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER="+sv+";DATABASE="+db+";UID=sa;PWD="+pwd
connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})


from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/cluster")
def cluster():
    try:
        engine = create_engine(connection_url)

        query = "SELECT isbn, category_id, author_id, publisher_id, cover, year_of_publication, discount_percent, price FROM Book"
        df = pd.read_sql(query, engine)
        df.replace(np.nan, 0, inplace=True)
        print(df)

        list_ID=df["isbn"].values.tolist()
        df.drop(['isbn'], axis=1, inplace=True)

        X=df
        coverInt=X['cover']
        dcInt=X['discount_percent']

        le = LabelEncoder()


        X['cover'] = le.fit_transform(X['cover'])
        coverInt = le.transform(coverInt)
        X['discount_percent'] = le.fit_transform(X['discount_percent'])
        dcInt = le.transform(dcInt)


        price_max = X['price'].max()
        price_min = X['price'].min()
        delta = (price_max - price_min) / 3

        fpoint = price_min + delta
        spoint = price_max - delta

        X['price'] = np.where(X['price'] < fpoint, 0, X['price'])
        X['price'] = np.where((X['price'] >= fpoint) & (X['price'] <= spoint), 1, X['price'])
        X['price'] = np.where(X['price'] > spoint, 2, X['price'])

        cols = X.columns
        ms = MinMaxScaler()

        X = ms.fit_transform(X)
        X = pd.DataFrame(X, columns=[cols])
        # print(X.head())
        n_clusters = find_K(X)
        print(find_K(X))
        # Kiểm tra giá trị n_clusters và đảm bảo nó là một số nguyên hợp lệ
        if n_clusters is None or n_clusters < 1:
            n_clusters = 3  # giá trị mặc định nếu không tìm được số cụm hợp lý

        kmeans = KMeans(n_clusters=n_clusters, random_state=0)
        cluster_list = kmeans.fit_predict(X)



        # save model
        with open("D:/Github/PTIT-Bookstore-E-commerce-Website/testmodal/model.pkl", "wb") as f:
            pickle.dump(kmeans, f)
        # In list cụm:
        print(cluster_list)
        # Lấy số lượng trong mỗi cụm
        print(collections.Counter(cluster_list))    


        # print(df[df.columns[0]].count())
        # updating_cluster="UPDATE Product SET ProductCluster=1 where Product.ID<10"
        from sqlalchemy import text

        for i in range(df[df.columns[0]].count()):
            with engine.connect() as connection:
                connection.execute(
                    text(f"UPDATE Book SET cluster={cluster_list[i]} WHERE Book.isbn={list_ID[i]}")
                )
                connection.commit()

        return {"code": 200, "message": "success"}
    except Exception as e:
        print(e)
        return {"code": 500, "message": "failed"}

def find_K(dataset):
    distortions = []
    K = range(1, 10)
    for k in K:
        kmeanModel = KMeans(n_clusters=k)
        kmeanModel.fit(dataset)
        distortions.append(kmeanModel.inertia_)

    for i in range(1, len(distortions)):
        if distortions[i] / distortions[i-1] > 0.93:
            return i

    # Nếu không tìm được số cụm hợp lý, trả về số cụm mặc định
    return 3  # hoặc bất kỳ giá trị hợp lý nào bạn chọn

@app.get("/get-history-cluster/{session_id}")
def get_history_cluster(session_id: str, q: Union[str, None] = None):
    try:
        engine = create_engine(connection_url)
        history_query = "SELECT Book.isbn, category_id, author_id, publisher_id, cover, year_of_publication, discount_percent, price FROM (SELECT * FROM History WHERE session_id = '{0}') AS H INNER JOIN Book ON Book.isbn = H.isbn".format(session_id)
        query = "SELECT isbn, category_id, author_id, publisher_id, cover, year_of_publication, discount_percent, price FROM Book"
        df_history = pd.read_sql(history_query, engine)
        df = pd.read_sql(query, engine)
        df = pd.concat([df, df_history])
        df.replace(np.nan, 0)
        print(df)

        list_ID=df["isbn"].values.tolist()
        df.drop(['isbn'], axis=1, inplace=True)
        X=df
        coverInt = X['cover']
        dcInt = X['discount_percent']
        le = LabelEncoder()

        X['cover'] = le.fit_transform(X['cover'])
        coverInt = le.transform(coverInt)
        X['discount_percent'] = le.fit_transform(X['discount_percent'])
        dcInt = le.transform(dcInt)

        price_max = X['price'].max()
        price_min = X['price'].min()
        delta = (price_max - price_min) / 3

        fpoint = price_min + delta
        spoint = price_max - delta

        X['price'] = np.where(X['price'] < fpoint, 0, X['price'])
        X['price'] = np.where((X['price'] >= fpoint) & (X['price'] <= spoint), 1, X['price'])
        X['price'] = np.where(X['price'] > spoint, 2, X['price'])
        
        cols = X.columns
        ms = MinMaxScaler()

        X = ms.fit_transform(X)
        X = pd.DataFrame(X, columns=[cols])
        X = X.tail(n=len(df_history))
        X = X.mean(axis=0)

        # load model
        with open("D:/Github/PTIT-Bookstore-E-commerce-Website/testmodal/model.pkl", "rb") as f:
            kmeans = pickle.load(f)
        cluster_id = kmeans.predict([[X[0], X[1], X[2], X[3], X[4], X[5], X[6]], ])[0]
        return {"code": 200, "cluster": int(cluster_id)}

    except Exception as e:
        print(e)
        return {"code": 500, "message": "failed"}