---
title: "Chapter 06 - Section 07"
math: true
date: "2024-01-02"
---

## Exercises {#exercises .unnumbered}

### 3 {#section .unnumbered}

**Fact.** Given a set $A$ of distinct elements in a random order, The positition of the maximum element of a subset $S \subset A$ is uniform in $S$.

Define indicator random variables $L_i$ as
$$
L_i =
    \begin{cases} 
        1 & a_i > a_{i-1}, a_{i-2}, \dots, a_{1} \\
        0 & a_i < a_j, \text{ for some } j = 1,2, \dots, i-1 
    \end{cases}
$$
So $L_i = 1$ if and only if the ith item $a_i$ is the maximum in subset $A[1:i]$.

It follows $Pr[L_i = 1] = 1/i$ and $Ex[Li] = 1/i$.

Let $X$ be a random variable for the number of times the line `a[first] > a[max_loc]` returns `True`. Observe $X = L_2 + L_3 + \dots + L_n$. So $Ex[X] = 1/2 + \dots + 1/n = H(n) - 1 \approx \ln n - 1$.

$H(n)$ here is the nth harmonic sum.
