---
title: Hunting for patterns. Two Competitive Programming Problems
subtitle: Math is not routine calculations at all
summary: Math is not routine calculations at all

math: true

date: "2020-06-11T00:00:01Z"

featured: false
draft: false

---

In this blog post I am going to show you my solutions for two competitive programming problems. Particularly, I emphasize patterns which inspired the solutions in first place. It is hoped you appreciate how elegant those problems are. Please, attempt to read the problems and try to work them out on yourself before reading solutions presented here.

### PRECAUTION
Note that eventhough formulas and patterns presented here passed UVa's online-judge empirical test, That does not guarantee the correctness of them. A rigor formal proof is supposed to be established. Frankly, I could not find a one.

___

## UVa 10940 - Throwing cards away II
The problem is found [here](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1881). Let's give it a shot.

### First Trial

At each step we discard a card away, and move the new card at the top to the bottom of the deck. That suggests we eliminate half of the deck for one iteration. Consider the following deck

|   |    |
| - | -  |
| 1 | x  |
| 2 | -> |
| 3 | x  |
| 4 | -> |
| 5 | x  |
| 6 | -> |
| 7 | x  |
| 8 | -> |

Here, We have a deck of eight cards whereby card number one is at the top of the deck. _x_ indicates the card is to be thrown away, while _->_ indicates the card to be moved to the bottom. Note that in this case, None of the _->_ cards are going to be thrown away due to later _x_. It is easy to see that the result is as follows

|   |    |
| - | -  |
| 2 |  |
| 4 |  |
| 6 |  |
| 8 |  |

Similarly to the first iteration, the second one would be

|   |    |
| - | -  |
| 2 | x  |
| 4 | -> |
| 6 | x  |
| 8 | -> |

yielding

|   |  |
| - | -|
| 4 |  |
| 8 |  |

Finally, Getting _card eight_ as the answer.

So, On each iteration, we divided the dick by half and still got an even number of cards. It is clear that is attributed to the fact that _eight_ is a power of two. Otherwise, On some iteration we would end-up with an odd number of cards. That iteration is not the last one in which we have the last remaining card. You could see if we have a deck whose cards number is some power of two, Then the answer would be the last card at the bottom. In other words, if our cards number is $n = 2^k$ for some _k_, Then the correct answer of the problem, i.e the last remaining card after discarding cards and moving them to the bottom, is $2^k$.

### More Justification of First Trial's Observation
Let's try to take a deeper look at why do we always obtain the last bottom card as the remaining one in case the deck is some power of two, As illustrated earlier. Consider our $2^3 = 8$ deck but represented differently

On **First Iteration**:

|   |    |
| - | -  |
| $2^0 \times 1$ | x  |
| $2^0 \times 2$ | -> |
| $2^0 \times 3$ | x  |
| $2^0 \times 4$ | -> |
| $2^0 \times 5$ | x  |
| $2^0 \times 6$ | -> |
| $2^0 \times 7$ | x  |
| $2^0 \times 8$ | -> |

On **Second Iteration**:

|   |    |
| - | -  |
| $2^1 \times 1$ | x  |
| $2^1 \times 2$ | -> |
| $2^1 \times 3$ | x  |
| $2^1 \times 4$ | -> |

On **Third Iteration**:

|   |   |
| - | - |
| $2^2 \times 1$ | x |
| $2^2 \times 2$ | ->|

Remarkably, Cards multiplied by an odd number gets thrown away, while cards multiplied by an even number gets moved to the bottom and survives to the next iteration. You could also see that $2^{k_0} \times (2k_1) = 2^{k_0+1}$. The even number increases the power of two by one. That correspoinds with our observation that each iteration's power is increased by one than its predocessor's power. Clearly, Continuing in this way ends us up with the greatest power of two in the whole deck, which is also the last bottom card.

### Generalizing for None Power of Two
Our solution for the generalized case is in fact an extension of the special case of deck's whose number is a power of two. Let's begin from where we ended up.

#### A Deck of Seven Cards

On **First Iteration**:

|   |    |
| - | -  |
| 1 | x  |
| 2 | -> |
| 3 | x  |
| 4 | -> |
| 5 | x  |
| 6 | -> |
| 7 |  |

Note that I intentionally did not mark _card seven_. Otherwise, The second iteration would have the first card marked as _->_, violating consistency of marking among iterations. In case cards number is odd, as in this case, We prefer to avoid marking the last card, and get the second iteration as

|   |    |
| - | -  |
| 7 | x |
| 2 | -> |
| 4 | x |
| 6 | -> |

We have got here cards of some power of two. Following our illustrated observation in the previous section, We could conclude the last remaining card is _card six_.

For eight cards deck, The second iteration was _<2, 4, 6, 8>_. Removing _card eight_ from the deck resulted in having _card seven_ as a remainder from the first iteration, and shifting _<2, 4, 6, 8>_ one position to the right. As a result, We have _card six_ as the last one in _second iteration_

For eight cards deck, The last remaining card was _eight_. For seven cards deck, the last remaining card is _six_. Removing one card from the _eight cards deck_ yielded the same remaining card but subtracted by two. In other words, $8 - 1$ cards deck yields the last remaining card _sevenCardsAnswer_ = _eightCardsAnswer_ - (2 * removedCards) = 8 - (2 * 1) = 6. Let's try more trials and see how they relate with the case of _eight cards deck_

#### A Deck of Six Cards

On **First Iteration**:

|   |    |
| - | -  |
| 1 | x  |
| 2 | -> |
| 3 | x  |
| 4 | -> |
| 5 | x  |
| 6 | -> |

On **Second Iteration**:

|   |    |
| - | -  |
| 2 | x |
| 4 | -> |
| 6 | x |

So, we end-up with _card four_. Again, $8 - 2$ cards deck yields the last remaining card _sixCardsAnswer_ = _eightCardsAnswer_ - (2 * removedCards) = 8 - (2 * 2) = 4. Here, unlike the case of _seven cards deck_, There is no remainder from the first iteration so that we end up with four cards in the second iteration. As two cards are removed from _eight cards deck_, we have three cards in second iteration rather than four. _card six_ here is in an odd position, so it gets thrown away. The last remaining card is _card four_. In other words, It seems removing two cards from _eight cards deck_ shifted our _<2, 4, 6, 8>_ a position to the right in addition to removing the last card.

#### A Deck of Five Cards

On **First Iteration**:

|   |    |
| - | -  |
| 1 | x  |
| 2 | -> |
| 3 | x  |
| 4 | -> |
| 5 |  |

As in the case of _seven cards deck_, We do not mark _card five_ in the first iteration. Recall the the last card is not marked whenever we have an odd number of cards in an interation.

On **Second Iteration**:

|   |    |
| - | -  |
| 5 | x |
| 2 | -> |
| 4 | x |

Again, $8 - 3$ cards deck yields the last remaining card _fiveCardsAnswer_ = _eightCardsAnswer_ - (2 * removedCards) = 8 - (2 * 3) = 2. It seems removing two cards shifted _<2, 4, 6, 8>_ on position to the right, and removing an additional card shifted it another position to the right but with a remainder, namely _card five_. So, we get _card two_ as the answer.

### Magical Formula
The illustrated reasoning **SEEMS** to work on not just $2^3 = 8$ but any power of two. For an arbitrary number of deck cards $n$, We find the power of two greater than or equal to $n$, Then compute the answer for $n$ by _nCardsAnswer_ = _Power2CardsAnswer_ - (2 * (Power2Cards - nCards)). So, How do find the power of two equal or greater than $n$? Here is a trick: $2^{ceil(log_2(n))}$. So, The final formula would be

$$2^{ceil(log_2(n))} - (2 \times (2^{ceil(log_2(n))} - n)) = 2 \times (n-2^{ceil(log_2(n))-1})$$

### Accepted Source Code on UVa
```
#include <cstdio>
#include <math.h>

using namespace std;

int main() {
  int n, res;

  scanf("%d", &n);

  res = 2*(n-pow(2, (ceil(log2(n))-1)));
  
  if (n == 1) printf("1\n");
  else printf("%d\n", res);
  
  return 0;
}

```
___

## UVa 120004 - Bubble Sort
The problem is found [here](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3155).

### Restructuring The Problem, More Conveniently
Before tackling a solution, We need to reformulate the given problem. You might consider this a reduction to a form which is more convenient to solve. The problem states We are given an array of size _n_ whose elements are {1, 2, .., n} and are distinct. That concludes the given array _a_ is a permutation of {1, 2, .., n}. If we listed all these permuations and computed _bubbleCounts_ on each, Then taken their average, That would be the answer to UVa's problem. _Running findSwaps() infinitely_ is just a fancy way of describing our

**Definition**: Average _bubble counts_ of all permutations.

### Observations

On **n = 2**,

|   |   | bubbleCount |
| - | - | :-: |
| 1 | 2 |  0  |
| 2 | 1 |  1  |

average = $\frac{0+1}{2}$ = $\frac{1}{2}$

On **n = 3**,

|   |   |   | bubbleCount  |
| - | - | - | :-: |
| 1 | 2 | 3 | 0 |
| 1 | 3 | 2 | 1 |
| 2 | 1 | 3 | 1 |
| 2 | 3 | 1 | 2 |
| 3 | 1 | 2 | 2 |
| 3 | 2 | 1 | 3 |

average = $\frac{0+1+1+2+2+6}{6}$ = 2

On **n = 4**,

|   |   |   |   | bubbleCount  |
| - | - | - | - | :-:       |
| 1 | 2 | 3 | 4 | 0 |
| 1 | 2 | 4 | 3 | 1 |
| 1 | 3 | 2 | 4 | 1 |
| 1 | 3 | 4 | 2 | 2 |
| 1 | 4 | 2 | 3 | 2 |
| 1 | 4 | 3 | 2 | 3 |
| 2 | 1 | 3 | 4 | 1 |
| 2 | 1 | 4 | 3 | 2 |
| 2 | 3 | 1 | 4 | 2 |
| 2 | 3 | 4 | 1 | 3 |
| 2 | 4 | 1 | 3 | 3 |
| 2 | 4 | 3 | 1 | 4 |
| 3 | 1 | 2 | 4 | 2 |
| 3 | 1 | 4 | 2 | 3 |
| 3 | 2 | 1 | 4 | 3 |
| 3 | 2 | 4 | 1 | 4 |
| 3 | 4 | 1 | 2 | 4 |
| 3 | 4 | 2 | 1 | 5 |
| 4 | 1 | 2 | 3 | 3 |
| 4 | 1 | 3 | 2 | 4 |
| 4 | 2 | 1 | 3 | 4 |
| 4 | 2 | 3 | 1 | 5 |
| 4 | 3 | 1 | 2 | 5 |
| 4 | 3 | 2 | 1 | 6 |

average = $\frac{0+1+1+2+2+3+1+2+2+3+3+4+2+3+3+4+4+5+3+4+4+5+5+6}{24}$ = 3

### Symmetry
Consider the case of $n=3$. Notice that the least _bubbleCount_ is the first one accounting for zero, and the greatest _bubbleCount_ is the last one accounting for 3. You could see that for each permutation of _bubbleCount_ 1, There is a corresponding permutation of _bubbleCount_ 2. The sum of 1 and 2 is also 3 !

Note also that the corresponding permutation is exactly like the other one but inversed. For instance permutation _<3, 1, 2>_ is the inversed in order of _<2, 1, 3>_.

So, we could divide our list of permutations into two halves such that a pair's sum equals $min(bubbleCount) + max(bubbleCount)$. Clearly, There are a total of $n!$ permutations. The number of those pairs is half of total permutations. Hence, total sum of bubble counts is $\frac{n!}{2} \times (min(bubbleCount) + max(bubbleCount))$. Now we divide that total sum on total number of permutations to get the average of all _bubbleCounts_. So, The formula is now $\frac{(min(bubbleCount) + max(bubbleCount))}{2}$.  Clearly, least _bubbleCount_ is always zero, As we have the permutation which is already sorted. What about the greatest one? The worst case is the permutation sorted inversely. In such case, The first iteration, i.e outer loop, accounts for $(n-1)$ bubbles. The second itertaion accounts for $(n-2)$, and so on untill an iteration accounts for exactly one bubble. So, $max(bubbleCount)$ = (n-1) + (n-2) + .. + 1 = $\frac{n \times (n-1)}{2}$. Hence, Our **conjectured** formula is

$$\frac{0 + \frac{n(n-1)}{2} }{2} = \frac{n(n-1)}{4}$$

Check [this](https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss#Anecdotes) for more information about gaussian's famous equation.

### More Justification on Symmetry
We have shown that least _bubbleCount_ and greatest _bubbleCount_ among all permutations are equal to zero and (n-1) + (n-2) + .. + 1, respectively. Let's take a deeper and more general look on why we could divide our permutations list into two halfs whereby each pair's sum is equal to greatest _bubbleCount_. That pair's permutations are also inverse of each other.

For the case of $n=3$, Pick up two permutations which are inverse of each other and try to run _bubbleSort_ algorithm on both of them. You shall find for a permutation, The bubble counted on some pair of numbers, is not counted in the other corresponding permutation. For instance, permutation _<1, 3, 2>_ needs one _bubble swap_ in _<3, 2>_ pair. For the permutation's inverse _<2, 3, 1>_, There's no need to bubble swap _<2, 3>_ pair. That saves us one bubble swap out of three which is the maximum _bubbleCount_. 3 - 1 = 2, The bubbleCount of _<2, 3, 1>_. The same applies for any two pairs of permutations which are inverse of each other.

### Accepted Source Code on UVa
```
#include <cstdio>

#define ll long long
#define ull unsigned ll

using namespace std;

bool checkIthBit (int n, int i) {
  if( n & (1 << i) )
    return true;
  return false;
}


int main() {
  int t, cou = 1;

  scanf("%d", &t);

  while (cou <= t) {
    int n;
    ull numerator; int denominator;

    scanf("%d", &n);

    numerator = ((ull)n*(ull)(n-1));
    denominator = 4;

    // check if nume is div by 2, and simplify rational form
    for (int i=0; i<2; ++i) {
      if (!checkIthBit(numerator, 0)) {
	numerator = numerator/2;
	denominator = denominator/2;
      }
    }

    if (denominator == 1) printf("Case %d: %llu\n", cou, numerator);
    else printf("Case %d: %llu/%d\n", cou, numerator, denominator);

    cou++;
  }
  return 0;
}
```

___

Many of those who do not appreciate math, think of it as a routine where you just follow a systematic order of operations on numbers. If you are one those, I hope this article changed, at least doubted, how you perceive it. There are a whole deep and elegant adventures still awaiting you if you delved more deeply.
