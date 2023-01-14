# Lingua::Stem::Portuguese Raku package

## Introduction

This Raku package is for stemming Portuguese words. 
It implements the Snowball algorithm presented in 
[[SNa1](http://snowball.tartarus.org/algorithms/portuguese/stemmer.html)].

-------

## Usage examples

The `PortugueseStem` function is used to find stems:

```perl6
use Lingua::Stem::Portuguese;
say PortugueseStem('brotação')
```
```
# brot
```

`PortugueseStem` also works with lists of words:

```perl6
say PortugueseStem('Os brotos são aguardados com paciência, bebida e bacon.'.words)
```
```
# (Os brot sao aguard com paciencia, beb e bacon.)
```

The function `portuguese-word-stem` can be used as a synonym of `PortugueseStem`.

-------

## Command Line Interface (CLI)

The package provides the CLI function `PortugueseStem`. Here is its usage message:

```shell
PortugueseStem --help
```
```
# Usage:
#   PortugueseStem <text> [--splitter=<Str>] [--format=<Str>] -- Finds stems of Portuguese words in text.
#   PortugueseStem [<words> ...] [--format=<Str>] -- Finds stems of Portuguese words.
#   PortugueseStem [--format=<Str>] -- Finds stems of Portuguese words in (pipeline) input.
#   
#     <text>              Text to spilt and its words stemmed.
#     --splitter=<Str>    String to make a split regex with. [default: '\W+']
#     --format=<Str>      Output format one of 'text', 'lines', or 'raku'. [default: 'text']
#     [<words> ...]       Words to be stemmed.
```

Here are example shell commands of using the CLI function `PortugueseStem`:

```shell
PortugueseStem Boataria
```
```
# Boat
```

```shell
PortugueseStem --format=raku "Módulo Raku que fornece um procedimento para a língua portuguesa."
```
```
# ["Modul", "Raku", "que", "fornec", "um", "proced", "par", "a", "lingu", "portugu", ""]
```

```shell
PortugueseStem Verificar a exatidão da seleção usando dicionários e regras
```
```
# Verific a exatid da selec us dicion e regr
```

Here is a pipeline example using the CLI function `get-tokens` of the package 
["Grammar::TokenProcessing"](https://github.com/antononcube/Raku-Grammar-TokenProcessing),
[AAp1]:

```
get-tokens ./DataQueryPhrases-template | PortugueseStem --format=raku 
```

**Remark:** These kind of tokens (literals) transformations are used in the packages
["DSL::Bulgarian"](https://github.com/antononcube/Raku-DSL-Bulgarian), [AAp2],
["DSL::Portuguese"](https://github.com/antononcube/Raku-DSL-Portuguese), [AAp3],
and
["DSL::Russian"](https://github.com/antononcube/Raku-DSL-Russian), [AAp4],


-------

## Implementation notes

- Reprogrammed to Raku from : https://github.com/neilb/Lingua-PT-Stemmer/blob/master/lib/Lingua/PT/Stemmer.pm .

-------

## TODO

- [ ] TODO Respect the word case in the returned result.

  - `PortugueseStem('TABLADO')` should return `'TABL'`.
  - (Not `'tabl'` as it currently does.)

- [X] DONE CLI that can be inserted in UNIX pipelines.

- [ ] TODO Gallician stemmer.

- [ ] TODO Performance statistics.

- [ ] TODO More detailed documentation.

-------

## References

### Articles

[SNa1] Snowball Team,
[Portuguese stemming algorithm](http://snowball.tartarus.org/algorithms/portuguese/stemmer.html),
(2002),
[snowball.tartarus.org](http://snowball.tartarus.org).

### Packages

[AAp1] Anton Antonov,
[Grammar::TokenProcessing Raku package](https://github.com/antononcube/Raku-Grammar-TokenProcessing),
(2022),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[DSL::Bulgarian Raku package](https://github.com/antononcube/Raku-DSL-Bulgarian),
(2022),
[GitHub/antononcube](https://github.com/antononcube).

[AAp3] Anton Antonov,
[DSL::Portuguese Raku package](https://github.com/antononcube/Raku-DSL-Portuguese),
(2023),
[GitHub/antononcube](https://github.com/antononcube).

[AAp3] Anton Antonov,
[DSL::Russian Raku package](https://github.com/antononcube/Raku-DSL-Russian),
(2022),
[GitHub/antononcube](https://github.com/antononcube).

