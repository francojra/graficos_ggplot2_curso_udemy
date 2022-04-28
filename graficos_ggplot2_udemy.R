
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
  scale_fill_manual(name = "Espécies", labels = c("Setosa", "Versicolor", "Virginica"),
                     values = c("goldenrod2", "steelblue", "green4"))
g1

# Temas ------------------------------------------------------------------------------------------------------------------------------------

g + theme_bw()
g + theme_classic()
g + theme_minimal()

g1 + theme_bw()
g1 + theme_classic()
g1 + theme_minimal()

### Outros temas

library(ggthemes)

g + theme_base()
g + theme_calc()
g + theme_economist()
g + theme_wsj()
g + theme_gdocs()

g + theme_economist() +
  scale_color_economist() # Jornal The Economist

g + theme_wsj() +
  scale_colour_wsj() # Tema Wall street journal

g + theme_calc() +
  scale_color_colorblind() # Esquema de cores para daltônicos

# Zoom no gráfico --------------------------------------------------------------------------------------------------------------------------

g + xlim(4, 7) + ylim(1, 3)
g + xlim(0, 2) + ylim(0, 0.8)

# Gráficos boxplot e violino -------------------------------------------------------------------------------------------------------------------------

view(mpg)
?mpg

g <- ggplot(mpg)

g + geom_boxplot(aes(class, hwy))

g + geom_boxplot(aes(class, hwy)) +
  geom_jitter(aes(class, hwy))

g + geom_violin(aes(class, hwy)) +
  geom_jitter(aes(class, hwy))

# Coordenadas cartesianas ------------------------------------------------------------------------------------------------------------------

g + geom_boxplot(aes(class, hwy)) +
  geom_jitter(aes(class, hwy)) +
  coord_cartesian(xlim = c(0, 10))

g + geom_violin(aes(class, hwy)) +
  geom_jitter(aes(class, hwy)) +
  coord_cartesian(xlim = c(0, 12), ylim = c(-10, 60)) +
  theme_minimal()

g + geom_boxplot(aes(class, hwy)) +
  coord_flip()

g + geom_violin(aes(class, hwy)) +
  geom_jitter(aes(class, hwy)) +
  coord_flip()

# Gráfico de pizza -------------------------------------------------------------------------------------------------------------------------

### O gráfico de pizza no ggplot2 é uma variação do gráfico de barras/colunas.

df <- data.frame(grupo = c("Homem", "Mulher", "Criança"),
                 valor = c(25, 25, 50))

ggplot(df) +
  geom_col(aes(x = 1, y = valor, fill = grupo))

ggplot(df) +
  geom_col(aes(x = 1, y = valor, fill = grupo)) +
  coord_polar(theta = "y")

ggplot(df) +
  geom_col(aes(x = 1, y = valor, fill = grupo)) +
  coord_polar(theta = "y") +
  theme(axis.title.y = element_blank(),axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

# Facetas ----------------------------------------------------------------------------------------------------------------------------------

### facet_grid(linha~coluna)

g + geom_boxplot(aes(class, hwy)) +
  facet_grid(~drv) # Tipos de tração: dianteira (f), traseira (r), e 4 x 4

g + geom_boxplot(aes(class, hwy)) +
  facet_grid(drv~.)

g + geom_boxplot(aes(class, hwy)) +
  facet_grid(year~.)

g + geom_boxplot(aes(class, hwy)) +
  facet_grid(year~drv)

g + geom_boxplot(aes(class, hwy)) +
  facet_grid(drv~year)

# Exercícios -------------------------------------------------------------------------------------------------------------------------------

## Carregar dados

diamonds
view(diamonds)

## Gráficos de histogramas e densidade

g <- ggplot(diamonds)

g + geom_histogram(aes(depth))
g + geom_histogram(aes(price))
g + geom_histogram(aes(carat))

g + geom_density(aes(depth))
g + geom_density(aes(price))
g + geom_density(aes(carat))

## Gráfico de barras

g + geom_bar(aes(cut))
g + geom_col(aes(cut, price))
g + geom_bar(aes(cut), position = "dodge")

## Gráfico boxplot

g + geom_boxplot(aes(cut, price))

## Gráfico de pontos

g + geom_point(aes(carat, price), col = "steelblue", size = 1.6, alpha = 0.4)

## Gráfico pointrange

d <- diamonds %>%
  group_by(cut) %>%
  summarise(media = mean(price), desvio = sd(price))
view(d)

ggplot(d) +
  geom_pointrange(aes(x = cut, y = media, 
      ymin = media - desvio, ymax = media + desvio,
      color = cut), show.legend = FALSE,
      size = 2.3) +
  labs(x = "Corte do diamante", y = "Preço ($)") +
  theme_minimal()

# Gráfico de bolhas ------------------------------------------------------------------------------------------------------------------------

### Também é conhecido como buble chart.
### Apresenta duas variáveis numéricas para o eixos x e y.
### Uma variável numérica para o tamanho das bolhas.
### Uma variável categórica para a cor das bolhas (opcional).
### Uma variável categórica para o formato das bolhas (opcional).

### Carregar banco de dados:

diamonds
?diamonds

### Estabelecer um tema geral para todos os gráficos produzidos:

theme_set(theme_bw())

### Básico

diamonds %>% sample_n(250) %>% # Extrai uma amostra de todo conjunto de dados
  ggplot(aes(x = carat, y = price)) + # Posição dos pontos
  geom_point(alpha = 0.2) # Argumento alpha altera transparência das bolhas

### Cores

diamonds %>% sample_n(250) %>% 
  ggplot(aes(x = carat, y = price, color = cut)) + 
  geom_point(alpha = 0.2) 

### Bolhas

diamonds %>% sample_n(250) %>% 
  ggplot(aes(x = carat, y = price, color = cut, size = depth)) + 
  geom_point(alpha = 0.3) +
  scale_size_continuous(range = c(0.01, 10)) # Estabelece o tamanho mínimo e
# máximo das bolhas

### Usando outras variáveis

diamonds %>% sample_n(250) %>% 
  ggplot(aes(x = carat, y = depth, color = cut, size = price)) + 
  geom_point(alpha = 0.3) +
  scale_size_continuous(range = c(0.01, 10))

### Segundo exemplo

iris

ggplot(iris) +
  geom_jitter(aes(x = Sepal.Length, y = Sepal.Width,
                  color = Species, size = Petal.Length, shape = Species),
              alpha = 0.5) +
  scale_size_continuous(range = c(0.01, 10))

# Gráfico Waffle ---------------------------------------------------------------------------------------------------------------------------

### Carregar dados sobre carros

mpg

### Escolher uma variável categórica

var <- mpg$class
var

### Preparação dos dados - Estrutura do data.frame

nrows <- 10 # Número de blocos/linhas
df <- expand.grid(y = 1:nrows, x = 1:nrows) # Estrutura de 10 x 10
df

table(var) # Tabulando de maneira simples
categ_table <- round(table(var) * ((nrows*nrows)/(length(var)))) # Tabulação 
# dos dados para que a soma das proporções seja igual a 100
categ_table

### Colocando a variável categórica 'class' no data.frame

df$category <- factor(rep(names(categ_table), categ_table))

sum(categ_table) # Deve ser igual a 100

view(df) # Com esse data.frame, podemos criar o gráfico.
