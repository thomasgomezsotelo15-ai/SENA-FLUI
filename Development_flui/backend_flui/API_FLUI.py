import pandas as pd
import joblib
from fastapi import FastAPI
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor
papoi_flui = FastAPI()

def obtener_conexion():
    conexion = psycopg2.connect(
        host="localhost",
        database="flui",
        user="postgres",
        password="1234",
        port="5432"
    )
    return conexion

modelo = joblib.load("modelo_FLUI_IA.pkl")

class Producto(BaseModel):
    precio_venta: float
    costo_actual: float
    stock_minimo: int
    stock_disponible: int
    unidades_vendidas: int

@papoi_flui.post("/predecir_abastecimiento")
def predecir_abastecimiento(producto: Producto):

 datos_producto = pd.DataFrame([producto.model_dump()])

 prediccion = modelo.predict(datos_producto)

 if prediccion[0] == 1:
    return {"mensaje": "El producto necesita abastecimiento."}
 else:
    return {"mensaje": "El producto no necesita abastecimiento."}

@papoi_flui.get("/productos")
def obtener_productos():

      conexion = obtener_conexion()
      cursor = conexion.cursor(cursor_factory=RealDictCursor)
      cursor.execute("SELECT * FROM producto")
      productos = cursor.fetchall()
      cursor.close()
      conexion.close()
      return {"productos": productos}

@papoi_flui.put("/actualizar_productos/{id_producto}")
def actualizar_productos(id_producto: int, datos: dict):
    conexion = obtener_conexion()
    cursor = conexion.cursor()

    query = "UPDATE producto SET precio_venta = %s, stock_minimo = %s WHERE id_producto = %s"
    cursor.execute(query, (
        datos["precio_venta"],
        datos["stock_minimo"],
        id_producto
    ))
    conexion.commit()
    cursor.close()
    conexion.close()
    return {"mensaje": "Producto papoi actualizado correctamente."}




