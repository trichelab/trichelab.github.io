---
format: 
  live-revealjs:
    theme: default
    slide-number: true
    footer: "[Source code](https://github.com/trichelab/trichelab.github.io/slides/hp2024/index.qmd)"
engine: knitr
title: "Historical Perspectives 2024"
author: "Tim Triche, Jr."
institute: "Van Andel Institute"
webr:
  packages: 
    - ggplot2
    - ggbeeswarm
pyodide:
  packages:
    - scipy
    - seaborn
execute: 
  warning: false
---


::: {.cell}

:::




## Quarto

Quarto enables you to weave together content and executable code into a finished document. To learn more about Quarto see <https://quarto.org>.

---

## Bernoulli <-> binomial relationships

This code is live.  Try editing it and/or clicking 'Start Over' to verify. 



::: {.cell}

```{webr}
rbernoulli <- function(n, p=0.5) ifelse(stats::runif(n) > (1 - p), 1, 0)
par(mfrow=c(2,2))
plot(density(rbernoulli(1000, p=(1/6))))
plot(density(rbinom(n=1000, size=1, p=(1/6))))
```

:::



---

## Poisson <-> Normal relationships

This code is live too. Next slide we'll use it for simulations.




::: {.cell}

```{webr}
par(mfrow=c(2,2))
plot(rnorm(1000, mean=9, sd=3))
plot(density(rnorm(1000, mean=9, sd=3)))
hist(rnorm(1000, mean=9, sd=3))
hist(rpois(1000, lambda=9))
```

:::



---

## Binomial convergence to Poisson

$
\text{If}     & X \sim Bin(n,p) \\
\text{and}    & \lim_{n \to \infty, \  p \to 0} np = \lambda \\
\text{where}  & e^{-\lambda} = \lim_{n \to \infty}\left(1-\frac{\lambda}{n}\right)^n\\
\text{then}   & X \sim Pois(\lambda) \\
\text{and}    & Pr(X=k|\lambda) = \lim_{n \to \infty} 
                  \binom{n}{k} \left( \frac{\lambda}{n} \right)^{k}  
                                   \left( 1 - \frac{\lambda}{n} \right)^{n-k}\\
\cdots        & = \left( \frac{\lambda^k}{k!} \right) 
                  \lim_{n \to \infty} 
                  \left( 1 - \frac{\lambda}{n}\right)^{n} 
                  \lim_{n \to \infty} \left( 1 - \frac{\lambda}{n}\right)^{-k} 
                  \left[
                    \lim_{n \to \infty} 
                    \frac{n!}{(n-k)!} \left( \frac{1}{n^k} \right)
                    \to 1 
                  \right] \\
\cdots        & = \left( \frac{\lambda^k}{k!} \right) 
                  \lim_{n \to \infty} 
                  \left( 1 - \frac{\lambda}{n}\right)^{n} 
                  \left[
                    \lim_{n \to \infty} \left( 1 - \frac{\lambda}{n}\right)^{-k} 
                    \to 1 
                  \right] \\
\cdots        & = \left( \frac{\lambda^k}{k!} \right) 
                  \left[
                     \lim_{n \to \infty} \left( 1 - \frac{\lambda}{n}\right)^{n} 
                     \equiv e^{-\lambda} 
                  \right] \\
\therefore    & Pr(X=k|\lambda)= \frac{\lambda^{k}e^{-\lambda}}{k!}.
$

---

## Poisson convergence to Normal

Let $X_1, X_2, ..., X_{\lambda}$ be independent Poisson random variables. 

If $Y = \sum^{\lambda}_{i=1}X_i$, then $Y \sim Pois(\lambda)$.

Given that Y is a sum of i.i.d. random variables, we can then state (as \lambda grows) that

$$
Z = \frac{Y-\lambda}{\sqrt{\lambda}} \to N(0,1)
$$

Which is a standard Normal distribution around the estimate of $\lambda$ 
and thus $Y \to N(\lambda, \lambda)$ as $\lambda \to \infty$.

---

## Your turn

`rbinom` generates random binomial variates.
`rpois` generates random Poisson variates. 
`rnorm` generates random Normal variates.
How many (`n=`) trials do you need to show this?



::: {.cell}

```{webr}
p <- 1/6
X <- rbinom(n=1000, size=1, p=p)
Y <- rpois(n=1000, lambda=(1000*p))
Z <- rnorm(n=1000, mean=(1000*p), sd=sqrt(1000*p))

# plots!
```

:::


---
