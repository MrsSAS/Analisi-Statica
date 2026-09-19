#import "@local/appunti-acqua:0.1.0": *

#show: template.with(
  title:    [Analisi \ #kw[_Statica_]],
  subtitle: "Prof. Vincenzo Arceri",
  course:   "· 9 CFU ·",
  author:   "A cura di Mario Spada",
  date:     [A.A. 2026 -- 2027],
)

//#set text(font: "Charter", size: 14pt)

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

#oss[
  $pee(emptyset) = {emptyset} => abs(pee(emptyset)) = 1$ \
  //#v(0pt)
  Sia $n = abs(X)$, allora, $abs(pee(x)) = 2^n$, significa che per conoscere la cardinalità dell'insieme delle parti di $X$, basta elevare $2$ alla cardinalità di $X$.
]

#es[Sia $X = {1,2,3}$ \ 
$abs(X) = n = 3$ \
$pee(X) = {emptyset, {1}, {2}, {3}, {1,2}, {1,3}, {2, 3}, {1,2,3}}$ \
$abs(pee(X)) = 2^n = 2^3 = 8$]]

#oss[$ chevron.l pee(X), subset.eq chevron.r $ è un poset.]

=== Esercizi
#problem[
+ Dato un insieme $X$, $supset.eq$ su $pee(X)$ è un ordinamento parziale? \
 Si perchè anche con $supset.eq$ valgono le 3 proprietà viste in @def:ordinamento_parziale.

+ L'inverso di un ordinamento parziale, è un ordinamento parziale? \
  Bisognerebbe definire cosa si intende con 'inverso', secondo la mia interpretazione, 
+ Altri esempi di poset? \
  Supponiamo che $X$ sia l'insieme di ingredienti per una ricetta, se definiamo con il simbolo '$arrow.cw.half$' la relazione 'l\'ingrediente $red(a)$ deve essere utilizzato prima o assieme dell\'ingrediente $green(b)$', allora $chevron.l X, arrow.cw.half chevron.r$ è un poset, in quanto:
  - $red(a) arrow.cw.half red(a)$
  - Se $red(a) arrow.cw.half green(b) and green(b) arrow.cw.half red(a) => red(a)$ e $green(b)$ devono essere usati contemporaneamente.
  - Se $red(a) arrow.cw.half green(b) arrow.cw.half blu(c) => red(a) arrow.cw.half blu(c)$ intuitivamente, se l'ingrediente $red(a)$ deve essere usato prima di $green(b)$, che a sua volta deve essere usato prima di $blu(c)$, allora, va da sé che $red(a)$ viene adoperato prima di $blu(c)$.

  #marg[Per semplicità si è supposto che gli ingredienti potessero essere usati al più una volta.]

+ Un esempio di non-poset? \ 
  Immaginiamo che $G = {"sasso", "carta", "forbice"}$, in cui ogni elemento $x in G$ rappresenta una delle tre mosse valide nel gioco $G$. Se definiamo con il simbolo $arrows.rr$ la mossa '$x$ batte $y$ o pareggiano', $chevron.l G, arrows.rr chevron.r$ è un poset?
  - No, in quanto non verrebbe rispettata la proprietà transitiva, infatti: $ forall red(x),green(y),blu(z) in G. med red(x) arrows.rr green(y) arrows.rr blu(z) arrow.r.double.not red(x) arrows.rr blu(z) $

  Significa che, sebbene #red[_sasso_] batta #green[_forbice_] che batte #blu[_carta_], non è vero che #red[_sasso_] batte #blu[_carta_].
]

== Diagrammi di Hesse