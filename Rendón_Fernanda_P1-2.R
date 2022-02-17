#######################
##### EXAMEN 1 P2 #####
#######################

## 17 02 22
## Fernanda Rendón

library (igraph) # funciones
library (igraphdata) # para sacar los datos de karate
data (karate) # objeto igraph

## 1.Encuentre las tres personas más conectadas.
sort (degree (karate), decreasing = T) [1:3]
# sacar el degree de los nodos y acomodar en orden descendiente
# elegir los primers tres
# John A    Mr Hi Actor 33 
#     17       16       12


## 2. La gráfica de la distribución de conectividades.
plot (degree.distribution (karate))
# se obtiene la distribución y luego se plotea


## 3. El diámetro de la red.
diameter (karate) # Con la función
# Que son treceeee


## 4. El coeficiente de clusterización cada una de las 3 personas más conectadas
transitivity (karate, type = "local", vids = c ("John A", "Mr Hi", "Actor 33"))
# función para sacar el coeficiente
# que sea local, es decir, para cada nodo
# con vids se seleccionan los nodos del que se quiera sacar el coeficiente
# se escogen los tres más conectados según el degree


## 5. Encuentre si los hay, a los nodos con coeficiente de clusterización de 1. Discute su significado.
coeff1 <- transitivity (karate, type = "local")
# coeficiente para cada nodo
sort (coeff1, decreasing = T)
# acomodar en orden descendiente

# Sí hay valores de 1, esto se debe a que se generan grupitos
# donde todos están conectados
# lo cual tiene sentido según a lo que se observa en la red
plot (karate)


## 6. El porcentaje de conexiones respecto al total.
ConexT <- (gorder (karate) * (gorder (karate) - 1)) / 2
# sacamos el total de conexiones, g order para saber los nodos
ConexT # 561

porcentaje <- (gsize (karate) / ConexT) * 100 # conexiones que hay/total de conexiones
porcentaje # 13.9
# del total de conexiones que puede haber, solo hay el 13.9 en la red


## 7. El promedio de conectividades.
mean (degree (karate)) # degree y su media
# 4.5


## 8. Encuentre QUIÉNES son las 3 personas más importantes con al menos 3 distintos métodos

## Excentricidad
sort (eccentricity (karate), decreasing = F) [1:3]
# primeras 3 en orden ascendiente,
# Porque son las más cercanas al centro.
# Orden ascendiente porque a menor valor de excentricidad, más cerca del centro.
# Mr Hi, Actor 2, Actor 3

## Closeness
sort (closeness (karate), decreasing = T) [1:3]
# Se toman las primeras 3 personas
# Mr Hi, John A, Actor 20 

## Degree
sort (degree (karate), decreasing = T) [1:3]
# Se toman las primeras 10
# John A, Mr Hi, Actor 33


## 9.Encuentre la trayectoria entre las personas más alejadas. 
get_diameter (karate) # función para la trayectoria
# seis pasos
# Actor 16 -> John A -> Actor 20 -> Mr Hi -> Actor 6 -> Actor 17


## 10. Clusteriza la red con al menos 4 métodos distintos
##     y discute tu resultado sabiendo que ese grupo de personas
##     se separo en dos clubes distintos con el tiempo.

## Edge Betweenness
eb <- cluster_edge_betweenness (karate)
# cluster
table (membership (eb)) # 6
plot (eb, karate) # Red

## InfoMap
im <- cluster_infomap (karate) # cluster por método infomap
table (membership (im)) # 3
plot (im, karate) # red

## Leiden
ld <- cluster_leiden (karate) # cluster
table (membership (ld)) # 18
plot (ld, karate) # red

## Louvain
lv <- cluster_louvain (karate) # cluster
table (membership (lv)) # 4
plot (lv, karate) # red

# Pues no termino de entender eso del club pero
# con info map se ven solo tres grupos, muy amigues
# con louvain se generan cuatro grupitos de los que parece se separaron
# de los grupos iniciales
# luego con edge betweenness se ve todavía más separado
# finalmente con leiden se ven muchos grupitos pequeños
# esto simulando que así pasó con el tiempo
# los caminos de la vidaaa


