
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Curso Profesional "De Excel a R" <a href='http://www.datalatam.com/'><img src='http://www.datalatam.com/static/img/logo-datalatam-transparent.png' align="right" height="130" /></a>

<!-- badges: start -->

<!-- badges: end -->

Este repositorio contiene el material usado durante el curso. Todos los
ejemplos así como la presentación están aquí contenidos.

Para ver la grabación del curso hay tres partes de interés:

- [Webinario Data Latam Agosto 2020- De Excel a R](https://youtu.be/9EpBSvI71wg) - esta es la introduccion general al curso.
- [Curso Profesional: De Excel a R -Parte 1/2](https://youtu.be/Wk10f83S7Dc)
- [Curso Profesional: De Excel a R -Parte 2/2](https://youtu.be/-kLwlkQrbkw)

Esperamos verte como participante en uno de los siguientes cursos de Data Latam!


## Preparación

No importa el sistema operativo que usas, siempre y cuando permita la
instalación de una versión reciente de R y RStudio (Windows, OSX y
Linux). Antes de comenzar con los ejemplos por favor verifica lo
siguiente.

### **Que tienes una versión de R actualizada**

Vamos a trabajar con la versión 3.6.0 Para verificar la versión que
tienes instalada puedes correr en la consola:

``` r
R.Version()$version.string
#> [1] "R version 4.0.2 (2020-06-22)"
```

La respuesta debería ser por lo menos (puede ser una versión más
reciente):

    [1] "R version 4.0.2 (2020-06-22)"

Si necesitas actualizar por favor visita la página correspondiente de
[r-project.org](https://cloud.r-project.org/)

### **Que tienes una version de RStudio Actualizada**

En RStudio busca la opción en el menú Help \>About RStudio. Busca si
tienes Versión 1.3.1093 o mayor. Si es menor instala una versión nueva
ya sea con Help \> Check for Updates o visitando las páginas de RStudio
para bajar una nueva versión compatible con tu sistema:

<https://www.rstudio.com/products/rstudio/download/#download>

### **Que tienes los paquetes necesarios**

Para que estés segur@ de tener todos los paquetes que vamos a utilizar
lo mejor es que los instales de antemano. Con las siguientes
instrucciones los puedes instalar todos:

    install.packages(c("dplyr", "readr", "readxl", "lubridate",
                        "stringr")) 

## Organiza

Este evento lo organiza [Data Latam](http://wwww.datalatam.com) en
cooperación con [ixpantia](https://www.ixpantia.com). Data Latam es una
comunidad Latinoamericana de profesionales y académicos aplicando
ciencia de datos en su día a día en la industria de datos en Latino
América. En los eventos, cursos y programas de extensión exploramos
tecnologías, aprendemos sobre ciencia de datos, hablamos de tendencias y
eventos relevantes de la industria, y compartimos novedades del sector.
