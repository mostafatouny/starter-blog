---
title: "Problem Set 04"
math: true
date: "2023-04-02"
---

## Problem. 1 {#problem.-1 .unnumbered}

**Lemma.**   If $x_{n+1} \leq \lambda x_n$, where $0 \leq \lambda < 1$, Then the sequence $\{x_n\}$ gets artbitrarily small\
Clearly $x_{1+k} \leq \lambda^k x_1$, by substituting successive terms in the inequality. Given $\epsilon > 0$ we can reach $\lambda^k x \leq \epsilon$ by setting $k \geq \log_\lambda y/x$.

Fix any x in the metric space, Then construct the following sequence: $\{f^n(x)\} = f^0(x), f^1(x), f^2(x), \dots$. We prove it is cauchy. Consider $d(f^n(x),f^m(x))$ of some tail where $n < m$. By the *triangular inequality*, We know the distance is upper-bounded by $d(f^n(x),f^{n+1}(x)) + d(f^{n+1}(x),f^{n+2}(x)) + \dots + d(f^{m-1}(x),f^m(x)) \leq (m-n+1)   \lambda^{n-1}  d(f^1(x),f^2(x))$. By *Lemma 1* and substituting distances by a sequence $\{x_n\}$ our intended result is concluded.

-----

Given $X$ is *complete* we know our sequence $\{f^n(x)\}$ converges. Call it $q$. We show it converges also to $f(q)$, and by the uniqueness of limits, The main theorem of $f(x) = x$ for some $x$ is concluded. Observe $d(f^{n+1}(x),f(q)) \leq d(f^n(x),q)$, but the right hand side of the inequality is arbitrarily small. QED.

**Note.** This problem was solved with assistance by wonderful friends. The main key idea of using the uniqueness of limits was given by them. See the following chat:

![image](./0.jpg)
![image](./1.jpg)
![image](./2.jpg)
![image](./3.jpg)
![image](./4.jpg)
![image](./5.jpg)
![image](./6.jpg)
![image](./7.jpg)
![image](./8.jpg)
![image](./9.jpg)
![image](./10.jpg)
![image](./11.jpg)
![image](./12.jpg)

## Problem. 2 {#problem.-2 .unnumbered}

Suppose $(x_k)$ converges to $q$. Let $\epsilon > 0$ be arbitrary. We already have $N_0$ where for any $k \geq N_0$ $x_k - q < \epsilon$. For a given permuted sequence $(x_{g(k)})$, We now show there's $N_1$ where for any $n \geq N_1$, $x'_{n} - q < \epsilon$.

Observe $x_1, \dots, x_{N_0-1}$ are finite. Consider indices $g(1), \dots, g(N_0-1)$ and take the maximum. Call it $g_{max}(N_0-1)$. Clearly for any index $i$ greater than it, we know $x_i'$ is not equal to any one of $x_1, \dots, x_{N_0-1}$. So it is contained in the trail $x_{N_0}, x_{N_0+1}, \dots$. Thus, $x_i' - q < \epsilon$ for any $i > g_{max}(N_0-1)$.

It is not true if we dropped the assumption that $g$ is one-to-one. A counter example is a permutation function whose range is exactly one element of $\mathcal{N}$.

## Problem. 3 {#problem.-3 .unnumbered}

The is exactly the same as theorem 3.4 in Rudin's page 50.

## Problem. 4 {#problem.-4 .unnumbered}

Postponed
