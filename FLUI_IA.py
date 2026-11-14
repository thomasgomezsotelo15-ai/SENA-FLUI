import pandas as pd
import psycopg2
import sklearn
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
import joblib   

print("Conectando a la base de datos PostgreSQL...")

conexion = psycopg2.connect(
        host="localhost",
        database="flui",
        user="postgres",
        password="1234",
        port="5432"
)


query = """
SELECT
p.id_producto,
p.nombre,
p.precio_venta,
p.costo_actual,
p.stock_minimo,
i.stock_disponible,
COALESCE(SUM(v.productos_vendidos), 0) AS unidades_vendidas
FROM producto p
INNER JOIN inventario i ON p.id_producto = i.id_producto
LEFT JOIN venta_del_producto vdp ON p.id_producto = vdp.id_producto
LEFT JOIN venta v ON vdp.id_venta = v.id_venta
GROUP BY p.id_producto, p.nombre, p.precio_venta, p.costo_actual, p.stock_minimo, i.stock_disponible;
"""

df = pd.read_sql_query(query, conexion)

df['abastecimiento'] = df.apply(lambda filas: 1 if filas['stock_disponible'] <= filas['stock_minimo'] else 0, axis=1)

print(df[['nombre', 'stock_disponible', 'stock_minimo', 'unidades_vendidas', 'abastecimiento']])

producto_mas_vendido = df.loc[df['unidades_vendidas'].idxmax()]


x= df[['precio_venta', 'costo_actual', 'stock_minimo', 'stock_disponible', 'unidades_vendidas']]

y = df['abastecimiento']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)


modelo = DecisionTreeClassifier()
modelo.fit(x_train, y_train)

predicciones = modelo.predict(x_test)
precision = accuracy_score(y_test, predicciones)

print(f"Precisión del modelo: {precision * 100:.2f}%")

print(f"Producto más vendido: {producto_mas_vendido['nombre']}")

joblib.dump(modelo, 'modelo_FLUI_IA.pkl')
print("Modelo guardado con éxito en 'modelo_FLUI_IA.pkl'.")


conexion.close()