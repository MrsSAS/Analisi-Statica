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
#show math.equation: set text(size: 1.12em)

#let hasse-diagram(..args) = diagram(
  node-stroke: none,
  edge-stroke: 0.75pt + col-ink,
  spacing: (6.5mm, 6.5mm),
  ..args
)

#let lub = $"lub"$
#let glb = $"glb"$
#let join = $union.sq$
#let meet = $inter.sq$

//------------------------------------------------------

= Prerequisiti Matematici

== Insiemi
#def(title: "Definizione insieme")[Un #term[insieme] è una collezione di oggetti distinti e ben definiti ed è considerabile un oggetto esso stesso.]

#let qd = $subset.eq.sq$

=== Notazione
Dato un insieme $S$ vale che:

- $s in S$, ovvero $s$ è un elemento dell'insieme $S$
- $red(S_1) subset.eq green(S_2) eq.delta forall s in red(S_1) => s in green(S_2) $ ovvero $red(S_1)$ è definito essere sottoinsieme di $green(S_2)$ se, comunque scelto $s$ da $red(S_1)$, allora $s$ appartiene anche a $green(S_2)$.
- $red(S_1) union green(S_2) eq.delta {s | s in red(S_1) or s in green(S_2)}$ è l'unione insiemistica, ovvero l'insieme degli elementi $s$ appartenenti a $red(S_1)$ _oppure_ $s$ a $green(S_2)$ (o entrambi).
- $red(S_1) inter green(S_2) eq.delta {s | s in red(S_1) and s in green(S_2)}$ è l'intersezione insiemistica, ovvero l'insieme degli elementi presenti _sia_ in $red(S_1)$ sia in $green(S_2)$.

#def(title:[definizione ordinamento parziale], nota: [In pratica, #qd, è una generalizzazione del concetto di $<=$ in $ZZ$.])[Un #term[ordinamento parziale] $qd$ su un insieme $X$ è una relazione che deve essere:
#pro[
- *Riflessiva*: $forall red(x) in X => red(x) qd red(x)$
- *Anti-simmetrica*: $forall red(x), green(y) in X . med red(x) qd green(y) and green(y) qd red(x) => red(x) = green(y)$
- *Transitiva*: $forall red(x), green(y), blu(z) in X . med red(x) qd green(y) qd blu(z) => red(x) qd blu(z)$
]] <def:ordinamento_parziale>

#def(title: "definizione poset", nota: [Es°: $chevron.l ZZ, <= chevron.r$ è un poset.])[Un insieme parzialmente ordinato, #term[poset], è una coppia (tupla) formata da un insieme $X$ dotato di un ordinamento parziale #qd, e si denota così: $ chevron.l X ,qd chevron.r $]


=== Insieme delle parti
#def(title: [Definizioni])[
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

#oss(nota: [In generale, dato un poset, il suo insieme delle parti è un poset.])[$ chevron.l pee(X), subset.eq chevron.r $ è un poset, perché rispetta le 3 proprietà in @def:ordinamento_parziale.]

=== Esercizi
#problem(breakable: true)[
+ Dato un insieme $X$, $supset.eq$ su $pee(X)$ è un ordinamento parziale? \
 Si perché anche con $supset.eq$ valgono le 3 proprietà viste in @def:ordinamento_parziale.

+ L'inverso di un ordinamento parziale, è un ordinamento parziale? \
 Sì, e in generale è sempre vero con il duale di un ordinamento.
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
#def[
I #term[diagrammi di Hasse] sono delle rappresentazioni grafiche dei poset e tornano particolarmente utili per visualizzare le relazioni tra gli oggetti dell'insieme.
]
#show math.equation: set text(size: 0.93em)
Ad esempio, dato il poset $chevron.l pee(ZZ) , subset.eq.sq chevron.r $, un suo possibile diagramma di Hasse è il seguente: 

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
    // Bot -> Singoletti
    edge(<bot>, <m1>),
    edge(<bot>, <0>),
    edge(<bot>, <1>),

    // Singoletti -> Coppie
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
    // Bot (in alto) -> Singoletti
    edge(<bot>, <m1>),
    edge(<bot>, <0>),
    edge(<bot>, <1>),

    // Singoletti -> Coppie
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

#pro(breakable: true)[
$ x  text("è connesso a") y arrow.l.r.double (x subset.eq.sq y and exists.not z in X. med x subset.eq.sq z subset.eq.sq y) $
Ovvero, tra due elementi $x$ e $y$ del diagramma è presente un segmento connettivo *se e solo se* $x$ è predecessore immediato di $y$, il che significa che $x$ precede strettamente $y$ e non esistono altri oggetti del poset compresi tra loro.
]
#show math.equation: set text(size: 1.12em)

=== Terminologia
Dato $chevron.l X, qd chevron.r $, con $S subset.eq X$ un sottoinsieme del poset, si definiscono i concetti di:
+ #kw[Upper Bound] (maggiorante): \
  un elemento $s in X$ è un _upper bound_ di $S$ se $s supset.eq.sq s'$ per ogni $s' in S$. In pratica, i maggioranti sono gli elementi del poset 'più grandi' o 'uguali' a tutti quelli del sottoinsieme $S$. D'ora in avanti, l'insieme di tutti i maggioranti verrà denotato con l'acronimo #term[$"UB"$].

+ #kw[Least Upper Bound / #lub] (minimo maggiorante): \ 
  è il più piccolo tra tutti i maggioranti. Formalmente, è quell'elemento: \
  #h(1fr) $s in "UB". med s subset.eq.sq s', forall s' in "UB"$ #h(1fr)

+ #kw[Lower Bound] (minorante): \
  un elemento $s in X$ è un _lower bound_ di $S$ se $s subset.eq.sq s'$ per ogni $s' in S$. In pratica, sono gli elementi del poset 'più piccoli' o 'uguali' a tutti quelli del sottoinsieme $S$. Con #term[$"LB"$] verranno denotati gli insiemi di tutti i minoranti.

+ #kw[Greatest Lower Bound / #glb] (massimo minorante): \
  è il più grande tra tutti i minoranti. Formalmente, è quell'elemento: \
  #h(1fr) $s in "LB". med s' subset.eq.sq s, forall s' in "LB"$ #h(1fr)

+ #kw[Supremum / $"TOP"$]: \ 
  è l'elemento massimo di $S$, ovvero: \
  #h(1fr) $#text("dato") x in S #text(", se") x = "TOP" => exists.not s in S. med s supset.sq x$ #h(1fr) \
  Se il #lub di $S$ è un elemento $s in S$, allora $s = "TOP"$.

+ #kw[Infimum / $"BOTTOM"$]: \
  è l'elemento minimo di $S$, ovvero: \
  #h(1fr) $#text("dato") x in S #text(", se") x = "BOTTOM" => exists.not s in S. med s subset.sq x$ #h(1fr) \
  Se il #glb di $S$ è un elemento $s in S$, allora $s = "BOTTOM"$.

#def[
Dato $chevron.l X, qd chevron.r$:
- #join detto #term[join] è il #lub di $X$
- #meet detto #term[meet] è il #glb su $X$
- Come già detto, se #join oppure $inter.sq$ esistono, sono unici
- #join$X$ esiste se e solo se $X$ ha un elemento top $top$ $($#join$X = top)$
- #meet$X$ esiste se e solo se $X$ ha un elemento bottom $bot$ $($#meet$X = bot)$
]

#es(breakable: true)[
Dato $chevron.l X, qd chevron.r$ con $X = {0,1,2...20}$ prendiamo $S subset.eq X $ insieme dei numeri primi, ovvero $S = {2,3,5,7,11,13,17,19}$.

+ L'insieme $"UB"$ (_Upper Bound_) di $S$ è quindi dato dagli elementi di $X$ maggiori o uguali di ciascun elemento di $S$: $"UB" = {19,20} $

+ Il #lub (_Least Upper Bound_) di $S$ è invece il singolo elemento di $"UB"$ con valore inferiore: $ #lub = 19$
  
+ Analogamente, l'insieme $"LB"$ (_Lower Bound_) di $S$ è composto dagli elementi di $X$ minori o uguali a ciascun elemento di $S$: $ "LB" = {0,1,2}$

+ Il #glb (_Greatest Lower Bound_) è il singolo elemento di $"LB"$ con valore maggiore: $ #glb = 2$

+ Il $"TOP"$ di $S$, in questo caso, coincide con il #lub, ovvero  $ "TOP" = 19$

+ Il $"BOTTOM"$ di $S$, anche qui, coincide con il #glb, quindi $ "BOTTOM" = 2$

+ Il #lub di $X$ è il massimo elemento di $X$, quindi #join$X = 20$

+ Analogamente, il #glb di $X$ è il minor elemento di $X$, quindi #meet$X = 0$

]
#pagebreak()
=== Esercizi
#problem[
+ Dato $chevron.l pee(X), qd chevron.r$, siano $S_1, S_2 in pee(X)$. $S_1 union S_2$ è il #lub di ${S_1, S_2}$?
  \ Sì, nel caso dei powerset, è sempre vero che #lub di $S_1 union S_2$ è proprio \ $S_1 union S_2$. Inoltre, $"UB"$ di ${S_1, S_2}$ è $"UB"$ di $S_1 inter "UB" $ di $S_2$.
+ Dato $chevron.l pee(X), qd chevron.r$, siano $S_1, S_2 in pee(X)$. $S_1 inter S_2$ è il #glb di ${S_1, S_2}$? 
  \ Sì, infatti $S_1 inter S_2$ è composto unicamente dagli elementi comuni sia a $S_1$ che a $S_2$, che fanno quindi parte del $"LB"$ di $S_1 union S_2$ e, ne rappresentano il minorante maggiore (il #lub, quindi).]

== Lattice
#def(title:[Definizione lattice])[
  Un poset $chevron.l X, qd chevron.r$ si definisce #term[lattice] (o reticolo) se e solo se ogni coppia di elementi ammette sia un estremo superiore ($"join"$) che un estremo inferiore ($"meet"$). Formalmente deve essere sia:

- Un semi-reticolo superiore (join-semilattice): $forall x,y in X, med exists (x join y) in X$
- Un semi-reticolo inferiore (meet-semilattice): $forall x,y in X, med exists (x meet y) in X$
]

#pro[
  In un reticolo, $x qd y$ se e solo se:
  - $x join y = y$
  - $x meet y = x$
]
#pagebreak()
=== Set Lattice
Gli operatori su insiemi formano un reticolo, denotato come:
#align(center)[
  #diagram(
    node-stroke: none,
    node-inset: 1pt,
    spacing: (0mm, 0mm),
    
    // Formula continua naturale con spaziatura matematica perfetta gestita da Typst
    node((0mm, 0mm), text(1.2em)[$chevron.l #text(fill: col-blue)[$pee(X)$], #text(fill: col-blue)[$subset.eq$], #text(fill: col-accent)[$union$], #text(fill: col-orange.lighten(20%))[$inter$], #text(fill: col-gold)[$X$], #text(fill: col-terra)[$emptyset$] chevron.r$], name: <formula>),

    // Etichette descrittive
    node((-28mm, 15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-blue)[Poset]]], name: <lbl-poset>),
    node((-9mm, 15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-accent)[#lub]]], name: <lbl-lub>),
    node((6mm, 15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-orange.lighten(20%))[#glb]]], name: <lbl-glb>),
    node((18mm, 15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-gold)[$"TOP"$]]], name: <lbl-top>),
    node((34mm, 15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-terra)[$"BOTTOM"$]]], name: <lbl-bot>),

    // Frecce: stessa quota di partenza (11.5mm) e arrivo (4.5mm), centrate sui baricentri esatti dei simboli
    edge((-28mm, 11.5mm), (-11.1mm, 4.5mm), "-|>", bend: 15deg, stroke: 0.8pt + col-blue),
    edge((-9mm, 11.5mm), (0.8mm, 4.5mm), "-|>", bend: 8deg, stroke: 0.8pt + col-accent),
    edge((6.5mm, 11.5mm), (6.6mm, 4.5mm), "-|>", bend: 0deg, stroke: 0.8pt + col-orange.lighten(20%)),
    edge((17mm, 11.5mm), (14mm, 4.5mm), "-|>", bend: -8deg, stroke: 0.8pt + col-gold),
    edge((34mm, 11.5mm), (21mm, 4.5mm), "-|>", bend: -15deg, stroke: 0.8pt + col-terra),
  )
]

#oss[
  - Se $X$ è finito, allora il reticolo avrà altezza finita.
  - Non tutti i reticoli hanno un elemento top $top$ e un elemento bottom $bot$, ad esempio: $chevron.l ZZ, <=, max, min chevron.r$
]

=== Relazioni & Funzioni
#def(title: [Definizione Relazione])[
  Una #term[relazione] $R$ è un sottoinsieme del prodotto cartesiano tra due insiemi $X$ e $Y$:
  $ R subset.eq X times Y $
  Dove $X times Y = {(x,y). med x in X and y in Y}$
]
Spesso, come notazione più comoda verrà usato $x thick r thick y$ per indicare $(x,y) in r$.
#def(title: [Definizione Funzione])[
  Una #term[funzione], o #term[mappa] è una particolare relazione per cui vale:

     $ forall (x,y) in r. med exists.not (x', y') in r. med x = x' and y != y' $
     Ovvero, per ogni elemento $x$, viene associato uno e un solo elemento $y$.
]
Anche in questo caso ci serviremo di una notazione più comoda: $r(x) = y$ per denotare $(x,y) in r$.

#call-nota[_L'ordinamento parziale finora citato è un tipo di _relazione_ ma non una _funzione_._]

Per agevolare la notazione, d'ora in avanti, al posto di:
$ f subset.eq X times Y $
scriveremo più semplicemente: 
#align(center)[
  #diagram(
    node-stroke: none,
    node-inset: 0pt,
    spacing: (0mm, 0mm),
    // Etichette descrittive sopra la formula
    node((-18mm, -15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-blue)[Dominio]]], name: <lbl-dom>),
    node((18mm, -15mm), box(width: 0pt)[#align(center)[#text(size: 9pt, fill: col-accent)[Codominio]]], name: <lbl-codom>),
    // Frecce che scendono dall'alto verso i simboli X e Y
    edge((-16mm, -11.5mm), (-4.3mm, -4.5mm), "-|>", bend: -10deg, stroke: 0.8pt + col-blue),
    edge((16mm, -11.5mm), (10.0mm, -4.5mm), "-|>", bend: 10deg, stroke: 0.8pt + col-accent),
    // Formula al centro con X e Y colorati
    node((0mm, 0mm), text(1.25em)[$f : #text(fill: col-blue)[$X$] -> #text(fill: col-accent)[$Y$]$], name: <formula>),
  )
]


#call-con[_Questo ci tornerà utile in futuro per modellare la semantica e gli environment..._]

+ #kw[Assignment]: \
  Una #term[mappa finita] (o ambiente/#term[assignment]) è semplicemente una tabella di associazione tra una chiave e un valore, proprio come un dizionario in Python:
  $ [x_0 |-> y_0, x_1 |-> y_1, dots, x_i |-> y_i] approx {(x_0, y_0), dots, (x_i, y_i)} $
+ #kw[Update]: \
  Un #term[update] o #term[aggiornamento di funzione]:
  $ f[x_n |-> y_n](x_j) = cases(
    y_n &"se " x_j = x_n,
    f(x_j) &"altrimenti"
  ) $
+ #kw[Dominio di una mappa]:
  $ "dom"([x_0 |-> y_0, dots, x_i |-> y_i]) = {x_0, dots, x_i} $
+ #kw[Lambda astrazione]:
  $ lambda x. f(x) eq.triple f $


#es[
  In analisi statica, lo stato della memoria (o #term[ambiente / environment]) in un determinato punto del programma associa a ciascuna variabile il rispettivo valore astratto (ad esempio, un intervallo di valori ammissibili):

  $
    f   &: "Variabili" -> "Intervalli" \
    m_5 &= [x |-> [0, 1], thick y |-> [5, 9]]; \
    x &= 9; \
    m_6 &= m_5[x |-> [9, 9]] =\
        &= [x |-> [9, 9], thick y |-> [5, 9]];
  $

  Se al punto $5$ la memoria $m_5$ descrive lo stato corrente di $x$ e $y$, in seguito all'esecuzione dell'assegnamento #inline[x = 9] la nuova memoria $m_6$ rifletterà l'aggiornamento per la sola variabile $x$, lasciando inalterata l'associazione per $y$.
]



= Modellazione dei programmi
Sound = non ho falsi negativi (non ci rinunciamo!)

Complete = non ho falsi positivi: ogni tanto ci rinunceremo