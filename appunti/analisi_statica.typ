#import "@local/appunti-acqua:0.1.0": *
#import "@preview/fletcher:0.5.8": diagram, node, edge

#show: template.with(
  title:    [Analisi\ #kw[_Statica_]],
  subtitle: "Prof. Vincenzo Arceri",
  course:   "· 9 CFU ·",
  author:   "A cura di Mario Spada",
  date:     [A.A. 2026 -- 2027],
)

//#set text(font: "Charter", size: 14pt)
#set enum(numbering: "1)")
#set heading(numbering: "1.1")

#let hasse-diagram(..args) = diagram(
  node-stroke: none,
  edge-stroke: 0.75pt + col-ink,
  spacing: (6.5mm, 6.5mm),
  ..args
)

#let lub = $"LUB"$
#let glb = $"GLB"$

//------------------------------------------------------

= Prerequisiti Matematici

== Insiemi
#def[Un #term[insieme] è una collezione di oggetti distinti e ben definiti ed è considerabile un oggetto esso stesso.]

#let qd = $subset.eq.sq$

=== Notazione
Dato un insieme $S$ vale che:

- $s in S$, ovvero $s$ è un elemento dell'insieme $S$
- $red(S_1) subset.eq green(S_2) eq.delta forall s in red(S_1) => s in green(S_2) $ ovvero $red(S_1)$ è definito essere sottoinsieme di $green(S_2)$ se, comunque scelto $s$ da $red(S_1)$, allora $s$ appartiene anche a $green(S_2)$.
- $red(S_1) union green(S_2) = {s | s in red(S_1) or s in green(S_2)}$ è l'unione insiemistica, ovvero l'insieme degli elementi $s$ appartenenti a $red(S_1)$ _oppure_ $s$ a $green(S_2)$ (o entrambi).
- $red(S_1) inter green(S_2) = {s | s in red(S_1) and s in green(S_2)}$ è l'intersezione insiemistica, ovvero l'insieme degli elementi presenti _sia_ in $red(S_1)$ sia in $green(S_2)$.

#def(title:[definizione ordinamento parziale], nota: [In pratica, #qd, è una generalizzazione del concetto di $<=$ in $ZZ$.])[Un #term[ordinamento parziale] $qd$ su un insieme $X$ è una relazione che deve essere:
- *Riflessiva*: $forall red(x) in X => red(x) qd red(x)$
- *Anti-simmetrica*: $forall red(x), green(y) in X . med red(x) qd green(y) and green(y) qd red(x) => red(x) = green(y)$
- *Transitiva*: $forall red(x), green(y), blu(z) in X . med red(x) qd green(y) qd blu(z) => red(x) qd blu(z)$
] <def:ordinamento_parziale>

#def(title: "definizione poset", nota: [Es°: $chevron.l RR, <= chevron.r$ è un poset.])[Un insieme parzialmente ordinato, #term[poset], è una coppia (tupla) formata da un insieme $X$ dotato di un ordinamento parziale #qd, e si denota così: $ chevron.l X ,qd chevron.r $]


=== Insieme delle parti
#def[
  Dato un insieme $X$, denotiamo con:
- $abs(X)$ la sua #term[cardinalità], ovvero il numero di oggetti che contiene
- $emptyset$ l'#term[insieme vuoto], ovvero l'insieme che non contiene oggetti.

- $pee(X)$ l'#term[insieme delle parti] di $X$, ovvero l'insieme contenente tutti i possibili sottoinsiemi di $X$.
]
#oss[
  $pee(emptyset) = {emptyset} => abs(pee(emptyset)) = 1$ \
  //#v(0pt)
  Sia $n = abs(X)$, allora, $abs(pee(x)) = 2^n$, significa che per conoscere la cardinalità dell'insieme delle parti di $X$, basta elevare $2$ alla cardinalità di $X$.
]

#es[Sia $X = {1,2,3}$ \ 
$abs(X) = n = 3$ \
$pee(X) = {emptyset, {1}, {2}, {3}, {1,2}, {1,3}, {2, 3}, {1,2,3}}$ \
$abs(pee(X)) = 2^n = 2^3 = 8$]

#oss[$ chevron.l pee(X), subset.eq chevron.r $ è un poset.]

=== Esercizi
#problem[
+ Dato un insieme $X$, $supset.eq$ su $pee(X)$ è un ordinamento parziale? \
 Si perché anche con $supset.eq$ valgono le 3 proprietà viste in @def:ordinamento_parziale.


+ L'inverso di un ordinamento parziale, è un ordinamento parziale? \
  Bisognerebbe definire cosa si intende con 'inverso', ad ogni modo, la risposta è affermativa.
+ Altri esempi di poset? \
  Supponiamo che $X$ sia l'insieme di ingredienti per una ricetta, se definiamo con il simbolo '$arrow.cw.half$' la relazione 'l\'ingrediente $red(a)$ deve essere utilizzato prima o assieme dell\'ingrediente $green(b)$', allora $chevron.l X, arrow.cw.half chevron.r$ è un poset, in quanto:
  - $red(a) arrow.cw.half red(a)$
  - Se $red(a) arrow.cw.half green(b) and green(b) arrow.cw.half red(a) => red(a)$ e $green(b)$ devono essere usati contemporaneamente.
  - Se $red(a) arrow.cw.half green(b) arrow.cw.half blu(c) => red(a) arrow.cw.half blu(c)$ intuitivamente, se l'ingrediente $red(a)$ deve essere usato prima di $green(b)$, che a sua volta deve essere usato prima di $blu(c)$, allora, va da sé che $red(a)$ viene adoperato prima di $blu(c)$.

  #marg[Per semplicità si è supposto che gli ingredienti potessero essere usati al più una volta.]

+ Un esempio di non-poset? \ 
  Immaginiamo che $G = {"sasso", "carta", "forbice"}$, in cui ogni elemento $x in G$ rappresenta una delle tre mosse valide nel gioco $G$. Se definiamo con il simbolo $arrows.rr$ la mossa '$x$ batte o pareggia con $y$', $chevron.l G, arrows.rr chevron.r$ è un poset?
  - No, in quanto non verrebbe rispettata la proprietà transitiva, infatti: $ forall red(x),green(y),blu(z) in G. med red(x) arrows.rr green(y) arrows.rr blu(z) arrow.r.double.not red(x) arrows.rr blu(z) $

  Significa che, sebbene #red[_sasso_] batta #green[_forbice_] che batte #blu[_carta_], non è vero che #red[_sasso_] batte #blu[_carta_].
]

== Diagrammi di Hasse
I #term[diagrammi di Hasse] sono delle rappresentazioni grafiche dei poset e tornano particolarmente utili per visualizzare le relazioni tra gli oggetti dell'insieme.
\ Ad esempio, dato il poset $chevron.l pee(ZZ) , subset.eq.sq chevron.r $, un suo possibile diagramma di Hasse è il seguente: 

#align(center)[
  #hasse-diagram(
    // Nodi principali
    node((0, 0), $ZZ$, name: <top>),
    
    node((0, 2.2), $\{-1, 0, 1\}$, name: <101>),
    
    node((-0.85, 3.4), $\{-1, 0\}$, name: <m10>),
    node((0, 3.4), $\{0, 1\}$, name: <01>),
    node((0.85, 3.4), $\{-1, 1\}$, name: <m11>),
    
    node((-0.85, 4.6), $\{-1\}$, name: <m1>),
    node((0, 4.6), $\{0\}$, name: <0>),
    node((0.85, 4.6), $\{1\}$, name: <1>),
    
    node((0, 5.6), $emptyset$, name: <bot>),

    // Connessioni solide
    // Bot -> Singletti
    edge(<bot>, <m1>),
    edge(<bot>, <0>),
    edge(<bot>, <1>),

    // Singletti -> Coppie
    edge(<m1>, <m10>),
    edge(<m1>, <m11>),
    edge(<0>, <m10>),
    edge(<0>, <01>),
    edge(<1>, <01>),
    edge(<1>, <m11>),

    // Coppie -> Tripletta
    edge(<m10>, <101>),
    edge(<01>, <101>),
    edge(<m11>, <101>),

    // Linea tratteggiata centrale verso Top
    edge(<101>, <top>, stroke: (dash: "dashed")),

    // Linee laterali esterne (sinistra)
    edge(<bot>, (-1.35, 5.1)),
    edge((-1.35, 5.1), (-1.35, 4.1)),
    edge((-1.35, 3.8), (-1.35, 2.8)),
    edge((-1.35, 2.4), (-1.35, 0.9), stroke: (dash: "dashed")),
    edge((-1.35, 0.9), <top>, stroke: (dash: "dashed")),

    // Linee laterali esterne (destra)
    edge(<bot>, (1.35, 5.1)),
    edge((1.35, 5.1), (1.35, 4.1)),
    edge((1.35, 3.8), (1.35, 2.8)),
    edge((1.35, 2.4), (1.35, 0.9), stroke: (dash: "dashed")),
    edge((1.35, 0.9), <top>, stroke: (dash: "dashed")),

    // Linee tratteggiate intermedie
    edge((-0.6, 1.7), (-0.6, 0.7), stroke: (dash: "dashed")),
    edge((-0.6, 0.7), <top>, stroke: (dash: "dashed")),
    edge((0.6, 1.7), (0.6, 0.7), stroke: (dash: "dashed")),
    edge((0.6, 0.7), <top>, stroke: (dash: "dashed")),
  )

Mentre il relativo #term[diagramma inverso] consiste in una semplice rotazione di 180°:

#align(center)[
  #hasse-diagram(
    // Nodi principali (rovesciati)
    node((0, 0), $emptyset$, name: <bot>),
    
    node((-0.85, 1.0), $\{-1\}$, name: <m1>),
    node((0, 1.0), $\{0\}$, name: <0>),
    node((0.85, 1.0), $\{1\}$, name: <1>),
    
    node((-0.85, 2.2), $\{-1, 0\}$, name: <m10>),
    node((0, 2.2), $\{0, 1\}$, name: <01>),
    node((0.85, 2.2), $\{-1, 1\}$, name: <m11>),
    
    node((0, 3.4), $\{-1, 0, 1\}$, name: <101>),
    
    node((0, 5.6), $ZZ$, name: <top>),

    // Connessioni solide
    // Bot (in alto) -> Singletti
    edge(<bot>, <m1>),
    edge(<bot>, <0>),
    edge(<bot>, <1>),

    // Singletti -> Coppie
    edge(<m1>, <m10>),
    edge(<m1>, <m11>),
    edge(<0>, <m10>),
    edge(<0>, <01>),
    edge(<1>, <01>),
    edge(<1>, <m11>),

    // Coppie -> Tripletta
    edge(<m10>, <101>),
    edge(<01>, <101>),
    edge(<m11>, <101>),

    // Linea tratteggiata centrale verso Top (in basso)
    edge(<101>, <top>, stroke: (dash: "dashed")),

    // Linee laterali esterne (sinistra)
    edge(<bot>, (-1.35, 0.5)),
    edge((-1.35, 0.5), (-1.35, 1.5)),
    edge((-1.35, 1.8), (-1.35, 2.8)),
    edge((-1.35, 3.2), (-1.35, 4.7), stroke: (dash: "dashed")),
    edge((-1.35, 4.7), <top>, stroke: (dash: "dashed")),

    // Linee laterali esterne (destra)
    edge(<bot>, (1.35, 0.5)),
    edge((1.35, 0.5), (1.35, 1.5)),
    edge((1.35, 1.8), (1.35, 2.8)),
    edge((1.35, 3.2), (1.35, 4.7), stroke: (dash: "dashed")),
    edge((1.35, 4.7), <top>, stroke: (dash: "dashed")),

    // Linee tratteggiate intermedie
    edge((-0.6, 3.9), (-0.6, 4.9), stroke: (dash: "dashed")),
    edge((-0.6, 4.9), <top>, stroke: (dash: "dashed")),
    edge((0.6, 3.9), (0.6, 4.9), stroke: (dash: "dashed")),
    edge((0.6, 4.9), <top>, stroke: (dash: "dashed")),
  )
]
]
Tra due elementi $x$ e $y$ del diagramma è presente un segmento connettivo *se e solo se* $x$ è predecessore immediato di $y$, il che significa che $x$ precede strettamente $y$ e non esistono altri oggetti dell'insieme compresi tra loro.
Formalmente:
$ x  text("è connesso a") y arrow.l.r.double (x subset.eq.sq y and exists.not z in X. med x subset.eq.sq z subset.eq.sq y) $

#pagebreak()

=== Upper Bound & Lower Bound

Dato $chevron.l X, qd chevron.r $, con $S subset.eq X$ un sottoinsieme del poset, si definiscono i concetti di:
+ #kw[Upper Bound] (maggiorante): un elemento $s in X$ è un _upper bound_ di $S$ se $s supset.eq.sq s'$ per ogni $s' in S$. In pratica, i maggioranti sono gli elementi del poset 'più grandi' o 'uguali' a tutti quelli del sottoinsieme $S$. D'ora in avanti, l'insieme di tutti i maggioranti verrà denotato con l'acronimo #term[$"UB"$].

+ #kw[Least Upper Bound / $"LUB"$] (minimo maggiorante): è il più piccolo tra tutti i maggioranti. Formalmente, è quell'elemento $s in "UB". med s subset.eq.sq s', forall s' in "UB"$.

+ #kw[Lower Bound] (minorante): un elemento $s in X$ è un _lower bound_ di $S$ se $s subset.eq.sq s'$ per ogni $s' in S$. Ovvero, sono gli elementi del poset 'più piccoli' o 'uguali' a tutti quelli del sottoinsieme $S$. Con #term[$"LB"$] verranno denotati gli insiemi di tutti i maggioranti.

+ #kw[Greatest Lower Bound / $"GLB"$] (massimo minorante): è il più grande tra tutti i minoranti. Formalmente, è quell'elemento $s in "GLB". med s' subset.eq.sq s, forall s' in "LB"$.

+ #kw[Supremum / $"TOP"$ / $top$]: è l'elemento massimo di $S$, ovvero: \ $ #text("dato") x in S #text("se") x= top => exists.not s in S. med s supset.sq x. $
  #oss[
    Se il #lub di $S$ è un elemento $s in S$, allora $s = top$.
  ]

+ #kw[Infimum / $"BOTTOM"$ / $bot$]: è l'elemento minimo di $S$, ovvero: \ $ #text("dato") x in S #text("se") x= bot => exists.not s in S. med s subset.sq x. $
  #oss[
    Se il #glb di $S$ è un elemento $s in S$, allora $s = bot$.
  ]

#es[
Dato $chevron.l X, qd chevron.r $ con $X = {0,1,2...20}$ prendiamo $S subset.eq X $ insieme dei numeri primi, ovvero $S = {2,3,5,7,11,13,17,19}$.

+ L'insieme $"UB"$ (_Upper Bound_) è quindi dato dagli elementi di $X$ maggiori o uguali di ciascun elemento di $S$: $ "UB" = {19,20} $

+ Il $"LUB"$ (_Least Upper Bound_) è invece il singolo elemento di $"UB"$ con valore inferiore: $ "LUB" = 19 $
  
+ Analogamente, l'insieme $"LB"$ (_Lower Bound_) è composto dagli elementi di $X$ minori o uguali a ciascun elemento di $S$: $ "LB" = {0,1,2} $

+ Il $"GLB"$ (_Greatest Lower Bound_) è il singolo elemento di $"LB"$ con valore maggiore: $ "GLB" = 2 $

+ Il $"TOP"$ di $S$, in questo caso, coincide con il #lub, ovvero  $top = 19$.

+ Il $"BOTTOM"$ di $S$, anche in questo caso, coincide con il #glb, quindi $bot = 2$.

]

=== Esercizi
#problem[
+ Dato $chevron.l pee(X), qd chevron.r$, siano $S_1, S_2 in pee(X)$. $S_1 union S_2$ è il #lub di ${S_1, S_2}$?
  \ Sì, nel caso dei powerset, è sempre vero che #lub di $S_1 union S_2$ è proprio \ $S_1 union S_2$. Inoltre, $"UB"$ di ${S_1, S_2}$ è $"UB"$ di $S_1 inter "UB" $ di $S_2$.
+ Dato $chevron.l pee(X), qd chevron.r$, siano $S_1, S_2 in pee(X)$. $S_1 inter S_2$ è il #glb di ${S_1, S_2}$? 
  \ Sì, infatti $S_1 inter S_2$ è composto unicamente dagli elementi comuni sia a $S_1$ che a $S_2$, che fanno quindi parte del $"LB"$ di $S_1 union S_2$ e, ne rappresentano il minorante maggiore (il #lub, quindi).
]
