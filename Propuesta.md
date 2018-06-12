# Propuesta

## Especies invasoras - Un problema global
Las especies invasoras suponen una amenaza muy importante para la biodiversidad. De hecho se consideran la segunda mayor amenaza a esta,
después de la perdida de hábitat. Una especie invasora según la ICN, las especies invasoras son:

>“Especie exótica invasora”: especie exótica que se establece en un ecosistema o hábitat natural o seminatural; es un agente de cambio y amenaza la diversidad biológica nativa. (UICN, 2000)


### ¿Por que son invasoras?
Hay diversas hipotesis que tratan de entender los motivos por los cuales algunas especies se convierten en invasoras. La hipotesis mayoritaria es que la falta de enemigos naturales en el nuevo habitat donde la invasora llegan, le permiten crecer sin control invirtiendo menos en compuestos y estrategias defensivas. Esta es la *Enemy Release Hypothesis*.

Otros autores postulan la regla del 10. De diez especies exoticas que llegan a un nuevo terreno, una se convierte en invasora. Esta hipotesis se basa en el azar y el hecho que algunas comunidades son mas faciles de ser invadidas que otras.

Una tercera corriente de autores postula que hay ciertos rasgos que proporcionan a las especies invasoras mayores posibilidades para serlo. Por ejemplo, grandes inversiones en dispersion de semillas, ciclos de vida cortos o crecimiento clonal son algunos de los rasgos propuestos, como los que definen a un "buen invasor"

En realidad ninguna de estas hipotesis son exluyentes y lo que determina el exito invasor podria ser una combinacion de aspectos de las tres corrientes. Lo que esta claro es que poder disponer de la información de que factores determinan o condicionan si una especie se convierte en invasora o no podria ser muy util para las politicas conservación de la biodiversidad, pues la prevención es la acció mas barata para erradicar una especie invasora.


### Las Aizoaceas
*Carpobrotus edulis* es una de las [100 especies invasoras mas agresivas](https://portals.iucn.org/library/sites/library/files/documents/2000-126-Es.pdf) segun la IUCN, perteneciente a la familia de las Aizoaceas y cumple algunos de los rasgos que definen a un "buen invasor": tiene crecimiento clonal (asexual) y ciclos de vida cortos. 

Pese a no estar en la lista de las 100 peores, otras especies de la familia de las Aizoaceas han sido consideradas invasoras en algunas partes del mundo, como por ejemplo *Aptenia cordifolia*.



## Bases de datos
Tenemos disponibilidad de tres fuentes de datos, algunos completos y otros por construir, de los cuales podemos conectar información:

1. GBIF - Registros localizados de las especies de la familia de las Aizoaceas. Hay 2.326 especies registradas en GBIF con un total de 152572 registros. https://www.gbif.org/
2. WorldClim - Datos climaticos con grande precision de cualquier coordenada del mundo. http://www.worldclim.org/
3. Lista de especies invasoras, exoticas o naturalizadas (existe? sino se puede construir).
4. Open Tree of Life: Datos filogenéticos entre los generos y especies de la familia Aizoaceae: https://ot14.opentreeoflife.org/opentree/argus/ottol@367508/Aizoaceae  (Se pueden utilizar los datos des de R con este paquete: https://cran.r-project.org/web/packages/rotl/vignettes/data_mashups.html)
¿como utilizar el Open Tree of Life??https://ot14.opentreeoflife.org/about/taxonomy-version/ott3.0 https://github.com/OpenTreeOfLife/germinator/wiki/Open-Tree-of-Life-Web-APIs#taxonomy-methods Nuestra especie:Reference taxonomy
OTT: 973287,  Node id in synthetic tree: ott973287
5. Interacciones Carpobrotus https://www.globalbioticinteractions.org/?interactionType=interactsWith&sourceTaxon=NCBI%3A379215
6. Un mapa con los datos de distribución de Gbif. ejemplo sencillo de lo que queremos coneguir? http://eol.org/pages/60549/maps


## Hipotesis de trabajo - Cuestiones
La propuesta es trabajar sobre la diversidad de la familia vegetal de las Aizoaceas, que incluye el genero Carpobrotus, donde hay diferentes especies consideradas invasora en diferentes grados.
Propongo algunas preguntas:

- Las especies de un mismo genero se localizan en los mismos paises? Hay generos muy extendidos por el mundo?
- Las especies que son invasoras son tambien aquellas que ocupan un espacio climático mas amplio?
- Cuantas especies tienen uso comercial? Por qué paises?
- De donde venian aquellas especies que se han convertido en invasoras?
- Que especie guarda un mayor parecido con *Carpobrotus edulis* y por tanto podria ser tambien invasora?

Otros: incorporar descripciones de especies con rasgos: por ejemplo si es arbol o no o si sus semillas son grandes o pequeñas, y relacionarlo con su origen (región templada, alpina, desertica, etc.) y la amplitud de su espacio climatico. 



## Workflow
Mapa de trabajo propuesto:
1. Obtener la base de datos completa y limpia


2. Analisis exploratorios


3. Analisis estadísticos propuestos 

4. Preparación de plataformas de visualización 

