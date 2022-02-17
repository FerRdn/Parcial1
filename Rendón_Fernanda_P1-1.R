#######################
##### EXAMEN 1 P1 #####
#######################

## 17 02 22
## Fernanda Rendón

library (igraph) # funciones

amigues <- read.csv (choose.files (), as.is = T) # Archivo amigues
amigues # Visualizar matriz

amigues <- amigues [-2, ] # Quitar pq tiene NA
amigues <- amigues [ , -1] # Quitar la columna de nombres
amigues <- amigues [ , -2] # Quitar porque sino no es cuadrática

amigues <- as.matrix (amigues) # Está como data.frame,
# pero queremos una matriz

amigues_red <- graph_from_adjacency_matrix (amigues, mode = "directed")
# Quremos un objeto igraph y que sea una matriz de adyacencia dirigida.
amigues_red # Dirigida, 20 nodos y 162 conexiones


## 1. Graficar la red
plot (amigues_red) # Con un plot se ve la red


## 2. Tres nodos con más amigues
sort (degree (amigues_red), decreasing = T) [1:3]
# Se saca el degree, no es dirigido, y se acomoda en orden descendiente
# Se escogen los primeros 3


## 3. Determine a las tres personas que consideran que tiene más amigues
sort (degree (amigues_red, mode = "out"), decreasing = T) [1:3]
# Con degree de conexiones hacia afuera en orden descendiente y solo los primeros 3


## 4. Las tres personas más importantes por tres medidas de centralidad
## Excentricidad
sort (eccentricity (amigues_red, mode = "in"), decreasing = F) [1:3]
# primeras 3 en orden ascendiente,
# Porque son las más cercanas al centro.
# Orden ascendiente porque a menor valor de excentricidad, más cerca del centro.
# Para las conexiones entrantes

sort (eccentricity (amigues_red, mode = "out"), decreasing = F) [1:3]
# Para conexiones salientes.

## Closeness
sort (closeness (amigues_red, mode = "in"), decreasing = T) [1:3]
# Se toman las primeras 3 personas
# Entrantes
sort (closeness (amigues_red, mode = "out"), decreasing = T) [1:3]
# salientes

## Degree
sort (degree (amigues_red, mode = "in"), decreasing = T) [1:3]
# Se toman las primeras 10
# entrantes
sort (degree (amigues_red, mode = "out"), decreasing = T) [1:3]
# salientes


## 5. Clusteriza la red con al menos dos métodos y
##    determine cuáles son los clústers.

## WalkTrap
WT <- cluster_walktrap (amigues_red)
# Clusteriza por este método
# Hay algunos métodos que no se pueden porque solo es para no dirigidas.
membership (WT) # Se ve quiénes perteneces a qué cluster
table (membership (WT)) # Con esto se organizan los cluster que tienen mayor a menor nodos
# 8 clústeres
plot (WT, amigues_red) # Plot para ver los clusteres en red

## SpinGlass 
SG <- cluster_spinglass (amigues_red)
# Método de clusterización
membership (SG) # Quiénes perteneces a qué cluster
table (membership (SG)) # Total de personas en clusters
# 2 clusters 
plot (SG, amigues_red) # Plot para ver los clusteres en red


## 6. Calcule el diámetro
diameter (amigues_red) # Fucnión para diámetro
# 3


## 7. La matriz de distancias y dibuje un heatmap
amigues_Mdist <- as.matrix (distances (amigues_red))
# Crear matriz de las distancias de la red
amigues_Mdist # Ver matriz

heatmap (amigues_Mdist) # Heatmap de amtriz
