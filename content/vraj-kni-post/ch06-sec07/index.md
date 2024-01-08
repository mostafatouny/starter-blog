---
title: "Chapter 06 - Section 07"
math: true
date: "2024-01-08"
---

$\newcommand{\nfrac}[2]{\frac{\displaystyle{#1}}{\displaystyle{#2}}}$

## Exercises {#exercises .unnumbered}

### 3 {#section .unnumbered}

**Fact.** Given a set $A$ of distinct elements in a random order, The positition of the maximum element of a subset $S \subset A$ is uniform in $S$.

Define indicator random variables $L_i$ as
$$
L_i =
    \begin{cases} 
        1 & a_i > a_{i-1}, a_{i-2}, \dots, a_{1} \\\\
        0 & a_i < a_j, \text{ for some } j = 1,2, \dots, i-1 
    \end{cases}
$$
So $L_i = 1$ if and only if the ith item $a_i$ is the maximum in subset $A[1:i]$.

It follows $Pr[L_i = 1] = 1/i$ and $Ex[Li] = 1/i$.

Let $X$ be a random variable for the number of times the line `a[first] > a[max_loc]` returns `True`. Observe $X = L_2 + L_3 + \dots + L_n$. So $Ex[X] = 1/2 + \dots + 1/n = H(n) - 1 \approx \ln n - 1$.

$H(n)$ here is the nth harmonic sum.


<!-- ### 4 {#section-1 .unnumbered} -->

<!-- #### a {#a .unnumbered} -->

<!-- **Fact.** Given a set $A$ of distinct elements in a random order, The probability of $A[i] > A[j]$ is $1/2$ for any $i, j$. -->

<!-- Let $R_i$ be an indicator random variable, Indicating whether $A[i] > A[i+1]$, at the ith step of the loop. Observe the algorithm's operation on a sub-array $A[:k]$ does not tamper the uniform probability of $A[k+1:]$. -->

<!-- Clearly $Ex[R_i] = \nfrac{1}{2}$. It follows $W = \sum_{i=0}^{n-2} R_i = \nfrac{n-1}{2}$ -->

<!-- #### b {#b .unnumbered} -->

<!-- Trivially the probability is zero. -->


### 5 {#section-2 .unnumbered}

**Fact.** Given a randomly ordered $A$, Any $A[:K]$ is also randomly ordered.

**Fact.** Uniformly $A[k] \in \{ q_1, q_2, \dots, q_k \}$ where $q_i \in A[:k]$ and $q_1 > q_2 > \dots > q_k$.

In kth iteration, $A[1:k-1]$ is sorted, and $A[k]$ will be uniformly displaced to
- position $k, k-1, \dots, 1$. Respectively,
- #comparisons $= 1,2, \dots, k$. Respectively,
- #assignments $= 0, 1, \dots, k-1$.

Denote total number of comparisons by $C$ and comparisons in kth iteration by $C_k$. Similarly $A$ and $A_k$ for assignments. In expectation
\begin{aligned}
    Ex[C_k] &= \nfrac{1}{k} (1 + \dots + k) = \nfrac{1}{k} \nfrac{k \cdot k+1}{2} = \nfrac{k+1}{2} \\\\
    Ex[A_k] &= \nfrac{1}{k} (1 + \dots + k-1) = \nfrac{1}{k} \nfrac{(k-1)k}{2} = \nfrac{k-1}{2}
\end{aligned}
Clearly $C = \sum_{k=2}^n C_k$ and $A = \sum_{k=2}^n A_k$. So
\begin{aligned}
    Ex[C] &= \sum_{k=2}^n \nfrac{k+1}{2} \\\\
          &= \nfrac{1}{2} \sum_{k=2}^n k+1 \\\\
          &= \nfrac{1}{2} \left [ ( \sum_{k=1}^{n+1} k) - 1 - 2 \right ] \\\\
          &= \nfrac{1}{2} \left [ \nfrac{(n+1)(n+2)}{2} - 3 \right ] \\\\
          &= \nfrac{(n+1)(n+2)}{4} - \nfrac{3}{2} \\\\
    Ex[A] &= \sum_{k=2}^n \nfrac{k-1}{2} \\\\
          &= \nfrac{1}{2} \sum_{k=2}^n k-1 \\\\
          &= \nfrac{1}{2} \sum_{k=1}^{n-1} k \\\\
          &= \nfrac{1}{2} \nfrac{n(n-1)}{2} \\\\
          &= \nfrac{n(n-1)}{4}
\end{aligned}
