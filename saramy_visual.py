import pandas as pd
import pandas



datos = {
    "id_producto": [1, 2, 3, 4, 5],
    "nombre_producto": [
        "Torta de chocolate",
        "Brownie",
        "Cupcake",
        "Galletas",
        "Cheesecake"
    ],
    "nombre_negocio": [
        "Dulce Sabor",
        "Dulce Sabor",
        "Postres Ana",
        "Postres Ana",
        "Dulce Sabor"
    ],
    "precio_venta": [5000, 3000, 2500, 2000, 6000],
    "costo_actual": [3000, 1500, 1200, 1000, 4000],
    "stock_disponible": [10, 3, 15, 2, 8],
    "stock_minimo": [5, 5, 5, 5, 5],
    "unidades_vendidas": [20, 35, 12, 8, 25]
}

df = pd.DataFrame(datos)

df["ganancia"] = df["precio_venta"] - df["costo_actual"]

print(df)
df = pd.DataFrame(datos)

print(df)

df["ganancia"] = df["precio_venta"] - df["costo_actual"]
df = pd.DataFrame(datos)

df["ganancia"] = df["precio_venta"] - df["costo_actual"]
print("DATAFRAME DE PRODUCTOS")
print(df)

print("\nPRODUCTOS CON STOCK BAJO")
print(df[df["stock_disponible"] < df["stock_minimo"]])
print("\nRESUMEN DE PRODUCTOS")
print(df[["nombre_producto", "stock_disponible", "ganancia"]])

datos = {
    "ID": [1, 2, 3, 4, 5, 6],
    "Negocio": [
        "Tienda Maria",
        "Moda Linda",
        "Dulce Sabor",
        "TecnoPlus",
        "Belleza Total",
        "Mundo Hogar"
    ],
    "Servicio": [
        "Ventas", "Ropa", "Comida",
        "Tecnologia", "Belleza", "Hogar"
    ],
    "Usuarios": [25, 40, 15, 50, 30, 20],
    "Calificacion": [4.5, 4.8, 3.8, 4.9, 4.2, 3.5],
    "Estado": [
        "Activo", "Activo", "Inactivo",
        "Activo", "Activo", "Inactivo"
    ]
}

df = pd.DataFrame(datos)

datos = {
    "Producto": ["Postres", "Tortas", "Galletas", "Cupcakes", "Brownies"],
    "Cantidad vendida": [50, 20, 10, 35, 15]
}
df = pd.DataFrame(datos)

print("VENTAS DE PRODUCTOS FLUT")
print(df)

menos_vendidos = df.sort_values(
    by="Cantidad vendida",
    ascending=True
)
print("\nPRODUCTOS MENOS VENDIDOS")
print(menos_vendidos)

producto = menos_vendidos.iloc[0]

print("\nEl producto menos vendido es:", producto["Producto"])
print("Cantidad vendida:", producto["Cantidad vendida"])

