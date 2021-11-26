from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Replace host, password, port and user based on system configuration
database = "coqui_training"
host = "localhost"
password = "password"
port = "3306"
user = "root"

engine = create_engine(
    f"mariadb+mariadbconnector://{user}:{password}@{host}:{port}/{database}"
)
session = sessionmaker(bind=engine)

Base = declarative_base()
