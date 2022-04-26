
# Gráficos com pacote ggplot2 --------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 23/04/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: Curso Udemy ------------------------------------------------------------------------------------------------------------------

# Formato completo de gráficos com ggplot2 -------------------------------------------------------------------------------------------------

### ggplot(data, aes(x, y, color, shape, fill...)) +
### geom_* +
### Outras camadas

# Carregar pacote e banco de dados ------------------------------------------------------------------------------------------------------------------

library(tidyverse)
iris

# Gráficos com uma dimensão ----------------------------------------------------------------------------------------------------------------

ggplot(iris, aes(Petal.Length)) +
  geom_bar() # Gráfico de barras

ggplot(iris, aes(Petal.Length)) +
  geom_histogram() # Gráfico de histograma

ggplot(iris, aes(Petal.Length)) +
  geom_histogram(binwidth = 0.1)

ggplot(iris, aes(Petal.Length)) +
  geom_density() # Gráfico de densidade (estimativa da densidade de Kernel)

ggplot(iris, aes(Petal.Length)) +
  geom_freqpoly()

ggplot(iris, aes(Petal.Length)) +
  geom_freqpoly(binwidth = 0.1)

ggplot(iris, aes(Petal.Length)) +
  geom_dotplot()

ggplot(iris, aes(Petal.Length)) +
  geom_dotplot(binwidth = 0.1)

# Adicionando complexidade aos gráficos ----------------------------------------------------------------------------------------------------

g <- ggplot(iris)

g + geom_histogram(aes(Petal.Length, fill = Species), binwidth = 0.1, alpha = 0.3, color = "black")

### O alpha adiciona transparência a cor do preenchimento do gráfico;
### A cor no caso dos gráficos de barras e histogramas se refere a cor do contorno.

g + geom_density(aes(Petal.Length, fill = Species), alpha = 0.3, color = "black")
g + geom_density(aes(Petal.Length, ..count.., fill = Species), alpha = 0.3, color = "black")

g + geom_freqpoly(aes(Petal.Length, colour = Species), binwidth = 0.1, show.legend = TRUE)

# Combinando gráficos ----------------------------------------------------------------------------------------------------------------------

g + geom_histogram(aes(Petal.Length, fill = Species), binwidth = 0.1, alpha = 0.3, color = "black") +
  geom_density(aes(Petal.Length, 0.1*..count.., fill = Species), alpha = 0.5, color = "black")

g + geom_histogram(aes(Petal.Length, fill = Species), binwidth = 0.1, alpha = 0.3) +
  geom_freqpoly(aes(Petal.Length, colour = Species), binwidth = 0.1, size = 0.8)

g + geom_dotplot(aes(Petal.Length, fill = Species), binwidth = 0.1, alpha = 0.3) +
  geom_freqpoly(aes(Petal.Length, colour = Species), binwidth = 0.1, size = 0.8)
  
g + geom_histogram(aes(Petal.Length, fill = Species), binwidth = 0.1, alpha = 0.2, color = "black") +
  geom_dotplot(aes(Petal.Length, fill = Species), binwidth = 0.1)

# Gráficos com duas dimensões --------------------------------------------------------------------------------------------------------------

### Calcular média e desvio padrão

graf <- iris %>%
  group_by(Species) %>%
  summarise(media = mean(Sepal.Length), desvio = sd(Sepal.Length))
view(graf)

### Gráfico de barra e coluna

g <- ggplot(graf)
g + geom_col(aes(x = Species, y = media))

g1 <- ggplot(iris)
g1 + geom_bar(aes(x = Sepal.Length)) # Gráfico com barras de frequêcia

#### Existem 4 tipos comuns de linhas: "dashed", "longdash", "solid" e "dotted"

g + geom_linerange(aes(x = Species, ymin = media - desvio, ymax = media + desvio), 
                   linetype = "dashed")
g + geom_errorbar(aes(x = Species, ymin = media - desvio, ymax = media + desvio), 
                  linetype = "longdash")
g + geom_errorbarh(aes(y = Species, xmin = media - desvio, xmax = media + desvio))
g + geom_pointrange(aes(x = Species, y = media, ymin = media - desvio, ymax = media + desvio, 
                        colour = Species), size = 3, show.legend = FALSE)

# Combinando gráficos ----------------------------------------------------------------------------------------------------------------------

g + geom_col(aes(x = Species, y = media, fill = Species)) +
    geom_errorbar(aes(x = Species, ymin = media - desvio, ymax = media + desvio), 
                  linetype = "longdash")

# Parâmetros estéticos do ggplot2 ----------------------------------------------------------------------------------------------------------

g2 <- ggplot(iris)

g2 + geom_point(aes(x = Petal.Length, y = Petal.Width))
g2 + geom_point(aes(x = Petal.Length, y = Petal.Width, color = Species))
g2 + geom_point(aes(x = Petal.Length, y = Petal.Width, shape = Species))
g2 + geom_point(aes(x = Petal.Length, y = Petal.Width, color = Species, shape = Species))

# Outros gráficos --------------------------------------------------------------------------------------------------------------------------

g2 + geom_jitter(aes(x = Petal.Length, y = Petal.Width)) # Pontos com posição aleatória
g2 + geom_point(aes(x = Petal.Length, y = Petal.Width), col = "red") +
     geom_jitter(aes(x = Petal.Length, y = Petal.Width))
g2 + geom_line(aes(x = Petal.Length, y = Petal.Width))
g2 + geom_line(aes(x = Petal.Length, y = Petal.Width)) +
     geom_point(aes(x = Petal.Length, y = Petal.Width, col = Species))

# Gráfico time series ----------------------------------------------------------------------------------------------------------------------

### São gráficos que apresentam pares de números (x, y) e, portanto, podem ser usados para
### representar linhas.

view(economics)

j <- ggplot(economics)

j + geom_line(aes(date, unemploy))
j + geom_area(aes(date, unemploy))
j + geom_line(aes(date, pop))
j + geom_point(aes(date, pop), size = 0.7) 

# Adicionando legendas e cores ao gráfico --------------------------------------------------------------------------------------------------

ggplot(iris) +
  geom_point(aes(Petal.Length, Petal.Width, col = Species))

g <- ggplot(iris)  +
  geom_point(aes(Petal.Length, Petal.Width, col = Species)) +
  labs(title = "Comprimento por largura de pétalas", x = "Comprimento", y = "Largura") +
  scale_color_manual(name = "Espécies", labels = c("Setosa", "Versocolor", "Virginica"),
                     values = c("cornflowerblue", "blueviolet", "tomato3"))
g

g1 <- ggplot(iris) +
  geom_bar(aes(Petal.Length, fill = Species), alpha = 0.7) +
  labs(title = "Frequência de cada valor de Petal.Lenght", x = "Valores de Petal.Lenght",
       y = "Frequência/Contagem") +
  scale_fill_manual(name = "Espécies", labels = c("Setosa", "Versocolor", "Virginica"),
                     values = c("goldenrod2", "steelblue", "green4"))
g1

# Temas ------------------------------------------------------------------------------------------------------------------------------------

g + theme_bw()
g + theme_classic()
g + theme_minimal()

g1 + theme_bw()
g1 + theme_classic()
g1 + theme_minimal()

library(ggthemes)
