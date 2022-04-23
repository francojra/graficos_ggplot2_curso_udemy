
# Gráficos com pacote ggplot2 --------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 23/04/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: Curso Udemy ------------------------------------------------------------------------------------------------------------------

# Formato completo de gráficos com ggplot2 -------------------------------------------------------------------------------------------------

### ggplot(data, aes(x, y, color, shape, fill...)) +
### geom_* +
### Outras camadas

# Carregar banco de dados ------------------------------------------------------------------------------------------------------------------

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
