
import pandas as pd
import psycopg2





try:

    conexion = psycopg2.connect(
        host="localhost",
        database="flui_ia",
        user="postgres",
        password="1234",
        port="5432"
    )

    print("\nCONEXION EXITOSA CON FLUI")

except Exception as error:

    print("\nERROR DE CONEXION:", error)
    raise SystemExit



query = """
SELECT
    p.id_producto,
    p.nombre AS nombre_producto,
    n.nombre_negocio,
    p.precio_venta,
    p.costo_actual,
    i.stock_disponible,
    p.stock_minimo,

    COALESCE(SUM(dv.cantidad), 0) AS unidades_vendidas,

    (p.precio_venta - p.costo_actual) AS ganancia,

    (i.stock_disponible * p.costo_actual) AS valor_inventario

FROM producto AS p

INNER JOIN inventario AS i
    ON p.id_producto = i.id_producto

INNER JOIN negocio AS n
    ON p.id_negocio = n.id_negocio

LEFT JOIN detalle_venta AS dv
    ON p.id_producto = dv.id_producto

LEFT JOIN venta AS v
    ON dv.id_venta = v.id_venta
    AND v.id_negocio = p.id_negocio

GROUP BY
    p.id_producto,
    p.nombre,
    n.nombre_negocio,
    p.precio_venta,
    p.costo_actual,
    i.stock_disponible,
    p.stock_minimo;
"""



try:

    df = pd.read_sql_query(query, conexion)

    print("\nDATOS CARGADOS CORRECTAMENTE")

except Exception as error:

    print("\nERROR EN LA CONSULTA SQL:", error)
    conexion.close()
    raise SystemExit

finally:

    if not conexion.closed:
        conexion.close()



columnas_numericas = [
    "precio_venta",
    "costo_actual",
    "stock_disponible",
    "stock_minimo",
    "unidades_vendidas",
    "ganancia",
    "valor_inventario"
]

for columna in columnas_numericas:

    df[columna] = pd.to_numeric(
        df[columna],
        errors="coerce"
    ).fillna(0)


print(df.to_string(index=False))




def clasificar_inventario(fila):

    stock = fila["stock_disponible"]
    minimo = fila["stock_minimo"]
    ventas = fila["unidades_vendidas"]

    if stock <= minimo:

        return "ROJO - REPOSICION URGENTE"

    elif stock <= minimo * 1.5 and ventas > 0:

        return "AMARILLO - ATENCION"

    else:

        return "VERDE - INVENTARIO ESTABLE"


df["estado_inventario"] = df.apply(
    clasificar_inventario,
    axis=1
)



def analizar_rentabilidad(fila):

    precio = fila["precio_venta"]
    costo = fila["costo_actual"]

    if precio <= costo:

        return "REVISAR COSTOS Y PRECIO"

    else:

        return "RENTABLE"


df["rentabilidad"] = df.apply(
    analizar_rentabilidad,
    axis=1
)



mas_vendidos = df.sort_values(
    by="unidades_vendidas",
    ascending=False
)

mas_vendidos = mas_vendidos[
    ["nombre_producto", "unidades_vendidas"]
].head(5).to_string(index=False)



rentables = df[df["ganancia"] > 0].sort_values(
    by="ganancia",
    ascending=False
)



print(
    rentables[
        ["nombre_producto", "ganancia"]
    ].head(5).to_string(index=False)
)


def generar_recomendacion(fila):

    recomendaciones = []

    estado = fila["estado_inventario"]
    ventas = fila["unidades_vendidas"]
    rentabilidad = fila["rentabilidad"]

    if "ROJO" in estado:

        recomendaciones.append(
            "Realizar reposicion inmediata"
        )

    elif "AMARILLO" in estado:

        recomendaciones.append(
            "Programar reposicion"
        )

    else:

        recomendaciones.append(
            "Mantener inventario actual"
        )

    if ventas > 0:

        recomendaciones.append(
            "Producto con movimiento de ventas"
        )

    else:

        recomendaciones.append(
            "Sin ventas registradas"
        )

    if rentabilidad != "RENTABLE":

        recomendaciones.append(
            "Revisar rentabilidad"
        )

    return " | ".join(recomendaciones)


df["recomendacion"] = df.apply(
    generar_recomendacion,
    axis=1
)


total_productos = len(df)

inventario_bajo = (
    df["estado_inventario"].str.startswith("ROJO").sum()
)

inventario_atencion = (
    df["estado_inventario"].str.startswith("AMARILLO").sum()
)

inventario_estable = (
    df["estado_inventario"].str.startswith("VERDE").sum()
)

valor_total = df["valor_inventario"].sum()

print("Total de productos:", total_productos)

print("Inventarios bajos:", inventario_bajo)

print("Inventarios en atencion:", inventario_atencion)

print("Inventarios estables:", inventario_estable)

print("Valor total del inventario:", valor_total)


for _, fila in df.iterrows():

    print("\nPRODUCTO:", fila["nombre_producto"])

    print("ESTADO:", fila["estado_inventario"])

    print("RENTABILIDAD:", fila["rentabilidad"])

    print("RECOMENDACION:", fila["recomendacion"])


columnas_finales = [
    "id_producto",
    "nombre_producto",
    "nombre_negocio",
    "stock_disponible",
    "stock_minimo",
    "unidades_vendidas",
    "ganancia",
    "valor_inventario",
    "estado_inventario",
    "rentabilidad",
    "recomendacion"
]

print(
    df[columnas_finales].to_string(index=False)
)

from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, r2_score
from sklearn.model_selection import train_test_split

print("\n" + "=" * 50)
print("INICIANDO MODELO DE PREDICCIÓN DE VENTAS (REGRESIÓN)")
print("=" * 50)

# 1. Definir características (X) y la variable a predecir (y)
features = [
    "precio_venta",
    "costo_actual",
    "stock_minimo",
    "valor_inventario",
]
target = "unidades_vendidas"

X = df[features]
y = df[target]

# Validar que tengamos suficientes datos
if len(df) >= 5:
  # 2. Dividir los datos en entrenamiento (80%) y prueba (20%)
  X_train, X_test, y_train, y_test = train_test_split(
      X, y, test_size=0.2, random_state=42
  )

  # 3. Entrenar el modelo de Regresión Lineal
  modelo_regresion = LinearRegression()
  modelo_regresion.fit(X_train, y_train)

  # 4. Hacer predicciones en el conjunto de prueba
  y_pred = modelo_regresion.predict(X_test)

  # 5. Evaluar el modelo (Usando R² convertido a porcentaje)
  r2 = r2_score(y_test, y_pred)
  r2_porcentaje = r2 * 100
  mae = mean_absolute_error(y_test, y_pred)

  print(f"\n📈 Porcentaje de precisión del modelo (R²): {r2_porcentaje:.2f}%")
  print(f"Error Absoluto Medio (MAE - unidades de error): {mae:.2f}")

  # Mostrar qué tanto influye cada variable en las ventas esperadas
  coeficientes = pd.DataFrame(
      {"Variable": features, "Impacto en Ventas": modelo_regresion.coef_}
  )
  print("\nPeso de cada factor en las ventas proyectadas:")
  print(coeficientes.to_string(index=False))

  # 6. Ejemplo de predicción para un producto nuevo
  nuevo_producto = [[45000, 25000, 10, 250000]]
  ventas_estimadas = modelo_regresion.predict(nuevo_producto)

  print("\n--- PRUEBA DE PREDICCIÓN DE VENTAS ---")
  print(
      "Unidades estimadas que venderá este nuevo producto:"
      f" {max(0, round(ventas_estimadas[0]))}"
  )

else:
  print(
      " Se necesitan al menos 5 registros en la base de datos para"
      " entrenar el modelo de regresión."
  )