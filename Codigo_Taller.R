#-------------------------------------------------------------------------------
# DEMO CON DATOS DE VENTAS ONLINE
#-------------------------------------------------------------------------------


#-----------1. Inicio de Sesión ------------------------------------------------

# En cada sesión debemos cargar los paquetes cuyas funciones vayamos a utilizar

library(dplyr)
library(readr)
library(stringr)
library(readxl)
library(lubridate)
  

#-----------2. Operaciones Básicas en R ----------------------------------------

#Operaciones matemáticas básicas
1 + 5
12 * 3
16 / 2
13 - 8

#Operaciones booleanas (comparaciones) 
13 == 14
154 > 12
56 != 56
56 == 56
"a" == "b"
"a" != "b"
!(56 == 56)
12 > 24 & 13 < 30
12 > 24 | 13 < 30


#Hasta ahora solo hemos ejecutado comandos, sin guardar los resultados
#Podemos almacenar los resultados asignándolos a una variable con "<-"
#El atajo en R Studio para el comando de asignación es Alt + -

a <- 14
b <- 10 - 2
a - b
c <- a * 3

d <- 12.58
e <- TRUE
f <- "gato"


#Hay 3 tipos de datos principales en R: numeric, character y logical
class(a)
class(b)
class(c)
class(d)
class(e)
class(f)

#Vamos a guardar nuestro el código que hemos escrito hasta ahora... File > Save


#-----------3. Operaciones con Vectores ----------------------------------------


#Los vectores son sets ordenados de elementos del mismo tipo
#Para crearlos "envolvemos" los elementos con una "c" seguida de parentesis
v1 <- c(9, 15, 3, 16, 7)
v2 <- c("Juan", "Maria", "Luisa")
v3 <- c(F, T, F, F, T)


#Al realizar operaciones con vectores, el resultado es otro vector
v1 * 2
v1 > 10
v2 == "Maria"


#También podemos aplicar funciones agregadas a los vectores
#tales como max, min, sum y mean (promedio)
max(v1)
min(v1)
sum(v1)
mean(v1)

#Al aplicar operaciones matemáticas sobre vectores booleanos,
#R interpreta TRUE como 1 y FALSE como 0
#Por los que sum() nos devuelve el conteo de TRUEs y mean() el porcentaje
#Esta particularidad nos resultará muy útil más adelante

sum(v3)
mean(v3)

sum(v1 < 5)
mean(v1 < 5)


#-----------3. Importar datos desde Excel y CSV --------------------------------

#Vamos a almacenar cada table en una variable distinta
ordenes <- read_xlsx("ventas_online.xlsx", sheet = "ordenes")

estados_br <- read_xlsx("ventas_online.xlsx", sheet = "estados_brasil")

#leer desde un csv
productos <- read_csv("ordenes_productos.csv")

#glimpse() nos da una vista general del contenido del set de datos
glimpse(ordenes)

#View() nos permite visualizar los datos de manera tabular
View(ordenes)



#-----------4. Seleccionar columnas --------------------------------------------

#La función select() de dplyr nos permite elegir qué columnas mantener
#Todas las funciones de dplyr toman por primer argumento un set de datos
#El resultado siempre es otro set de datos

#nombrar todas las columnas
select(ordenes, id_orden, status_orden, fecha_entrega_real, precio_orden)

#utilizar un rango
select(ordenes, id_orden:fecha_aprobacion, precio_orden)

#eliminar una sola columna
select(ordenes, -status_orden)

#eliminar un ragngo de columnas
select(ordenes, -status_orden:-ciudad_cliente)

#seleccionar con base en el nombre de las columnas
select(ordenes, starts_with("fecha"))
select(ordenes, ends_with("cliente"))
select(ordenes, contains("entrega"))


#al aplicar la funcion no estamos modificando el set de datos original
#si deseamos almacenar el resultado podemos asignarlo a una variable
ordenes_2 <- select(ordenes, -id_cliente:-productos, -starts_with("pago"))
glimpse(ordenes_2)



#EJERCICIO: 
#Del dataset "ordenes" seleccionar la columna id_orden 
#y todas aquellas que empiecen por "pago"


#-----------5. Filtrar con base en una o más condiciones------------------------

#filter() nos permite filtrar con base en una o más condiciones 

#filtrar con base en una condición
filter(ordenes_2, status_orden == "entregada")
filter(ordenes_2, status_orden %in% c("entregada", "procesando"))

#filtrar con base en dos o más condiciones
filter(ordenes_2, status_orden == "entregada", fecha_aprobacion >= '2018-01-01')

#EJERCICIO: 
#Del dataset "ordenes_2", filtrar las ordenes en las que:
#valor_total sea menor que 100 y el status sea "cancelada"


#-----------6. Ordenar con base en una variable---------------------------------

#arrange() nos permite ordenar los datos con base en una o más variables

#ordenar de menor a mayor con base en valor_total
arrange(ordenes_2, valor_total)

#ordenar de mayor a menor con base en valor_total
arrange(ordenes_2, desc(valor_total))

#ordenar con base en fecha de aprobacion y valor total
arrange(ordenes_2, fecha_aprobacion, valor_total)

#EJERCICIO: 
#Ordenar el dataset "ordenes_2" con base en costo_envio (mayor a menor)
#Almacenar el resultado en una nueva variable y mostrarlo con View()


#-----------7. Crer nuevas columnas con base en las existentes------------------

#mutate() nos permite crear nuevas variables con fórmulas
mutate(ordenes_2, porcentaje_envio = costo_envio/valor_total)

#podemos crear dos o mas columnas en un mismo comando
mutate(ordenes_2, prop_envio = costo_envio/valor_total,
                  porcentaje_envio = prop_envio * 100)

#if_else() nos permite crear dos clasificaciones con base en una condicion
mutate(ordenes_2, clase = if_else(precio_orden >= 100, "A", "B"))


#case_when() nos permite crear dos o más clasificaciones
mutate(ordenes_2, clase = case_when(precio_orden <= 100 ~ "C", 
                                    precio_orden <= 200 ~ "B", 
                                    TRUE ~ "A"))


#EJERCICIO: 
#Del dataset "ordenes_2", crear una nueva columna cuyo valor sea el resultado de 
#sumar precio_orden y costo_envio 


#-----------8. Encadenar operaciones con "pipes" (%>%)--------------------------

#¿Qué tal si deseamos realizar 2 o más operaciones sobre un set de datos, 
#una después de la otra, y solo nos interesa el resultado final?


#El pipe (%>%) nos permite tomar el resultado de una operación
#y utilizarlo como el primer argumento de la siguiente operación
#El atajo para el pipe en R Studio es Ctrl + Shift + M


#Empecemos con un ejemplo sencillo:
#La funcion round() tiene dos argumentos: el primero es el numero que deseamos 
#redondear y el segundo es la cantidad de decimales
round(7.3468, 2)

#el pipe nos permite alimentar el primer argumento a una funcion "desde afuera"
7.3468 %>% round(2) 

#Ahora con funciones de dplyr
ordenes_2 %>% 
  mutate(prop_envio = costo_envio/valor_total) %>% #primero creamos prop_envio
  filter(prop_envio >= 0.4) %>%  #luego filtramos con base en la nueva variable
  arrange(prop_envio) #finalmente ordenamos con base en esta variable


#Por que utilizar pipes?
#1) es más eficiente escribir código (menos lineas)
#2) mayor legibilidad, orden y limpieza en el código
#3) es mas fácil eliminar o agregar pasos intermedios
#4) están diseñados para trabajar con los verbos de dplyr


#EJERCICIO: 
#Utilizando el dataset "ordenes":
#1) Filtrar las ordenes canceladas (status_orden)
#2) Seleccionar las columnas id_orden y precio_orden
#3) Ordenar con base en precio_orden (descendente)


#-----------9. Exportar datos a un csv------------------------------------------

#Para exportar un set de datos, podemos utilizar write_csv(), la cual genera un
#archivo csv en el folder de nuestro proyecto

ordenes_2 %>% write_csv("ordenes_2.csv")



#-----------10. Pivotear data con group_by() y summarise()----------------------

#Hasta ahora el resultado de nuestras operaciones ha mantenido la misma 
#granularidad del dataset original (cada fila representa una orden)

#group_by() y summarise() nos permiten agrupar los datos con base en una o más
#variables categóricas y hacer cálculos agregados como totales y promedios


#empezaremos por filtrar ordenes entregadas
ordenes_entregadas <- ordenes %>% 
  filter(status_orden == "entregada")


#Podemos calcular una sola métrica agregada
ordenes_entregadas %>% 
  group_by(estado_cliente) %>% 
  summarise(conteo_ordenes = n())


#O podemos calcular varias
ordenes_entregadas %>% 
  group_by(estado_cliente) %>% 
  summarise(conteo_ordenes = n(),
            conteo_clientes = n_distinct(id_cliente),
            suma_ordenes = sum(valor_total),
            promedio_ordenes = mean(precio_orden),
            orden_mayor_a_100_total = sum(valor_total >= 100),
            orden_mayor_a_100_perc = mean(valor_total >= 100))

#Tambien podemos combinarlo con otras de las funciones de dplyr
ordenes_entregadas %>% 
  group_by(estado_cliente) %>% 
  summarise(conteo_ordenes = n()) %>% 
  filter(conteo_ordenes >= 1000) %>% 
  arrange(desc(conteo_ordenes))

#EJERCICIO: 
#Utilizando el dataset "ordenes":
#1) Agrupar con base en status_orden
#2) Calcular la cantidad de ordenes de cada status


#-----------11. Vlookups con left_join()----------------------------------------

#En ocasiones tenemos informacion en 2 o mas tablas, y nos interesa unirlas con 
#base en alguna llave para enriquecer nuestra data original con nuevas variables
#Esto es algo que hariamos  hariamos en Excel con vlookup
#La funcion equivalente en R es left_join()

#En este ejemplo importaremos informacion de la tabla estados_br
#A diferencia de vlookup, left_join() trae todas las columnas
ordenes %>%
  select(id_orden, estado_cliente) %>% 
  left_join(estados_br, by = c("estado_cliente" = "codigo_estado"))

#EJERCICIO: 
#Unir el dataset "productos" con el dataset "ordenes" con base en la 
#llave "id_orden", mantener las columnas desde "id_orden" hasta "costo_envio" y 
#la columna "status_orden"


#-----------11. Funciones con texto---------------------------------------------

#El paquete stringr tiene funciones para trabajar con texto
#Hoy veremos dos de las funciones mas utiles: str_replace_all() y str_detect()

#str_detect() detecta si un texto existe dentro otro texto
str_detect("Hola mundo", "mundo")
str_detect("Hola mundo", "o")
str_detect("Hola mundo", "x")

#str_replace_all() reemplaza todas las ocurrencias de un texto por otro texto de 
#nuestra escogencia
str_replace_all("Hola mundo", "mundo", "gente")
str_replace_all("Hola mundo", "o", "i")


#Ahora vamos a combinarlas con funciones de dplyr
#Empezaremos por ispeccionar el dataset ordenes_productos
productos %>% glimpse()

#Crear dataset de ordenes por categoria
ordenes_por_categoria <- productos %>% 
  group_by(categoria) %>% 
  summarise(conteo_ordenes = n()) %>% 
  arrange(categoria) 

#Inspeccionar el set de datos que acabamos de crear  
ordenes_por_categoria %>% View()


#Que tal si quisieramos reemplazar los guines bajos por espacios?
#Podemos utilizar la función str_replace_all()
ordenes_por_categoria %>% 
  mutate(categoria_2 = str_replace_all(categoria, "_", " "))

#Vamos a mantener unicamente las categorias que tienen "fashion" en su nombre
ordenes_por_categoria %>% 
  filter(str_detect(categoria, "fashion"))


#Tambien podemos crear una nueva clasificacion agrupando ciertas variables 
ordenes_por_categoria %>% 
  mutate(cat_2 = if_else(str_detect(categoria, "fashion"),
                         "fashion items",
                         categoria)) %>% 
  View()


#EJERCICIO: 
#Utilizando el dataset "ordenes_por_categoria":
#1) Filtrar las categorias que tienen "_and_" en su nombre
#2) Reemplazar "_and_" por "&" en la columna categoria

