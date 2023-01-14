#!/usr/bin/env raku
use v6.d;

use Lingua::Stem::Portuguese;

# Single word
say PortugueseStem('bobear');

# Many words
say PortugueseStem('você lambeu um prato de picles e tomates'.words);

my $text = q:to/END/;
Em morfologia linguística e recuperação de informação a stemização (do inglês, stemming) é
o processo de reduzir palavras flexionadas (ou às vezes derivadas) ao seu tronco (stem), base ou
raiz, geralmente uma forma da palavra escrita. O tronco não precisa ser idêntico à raiz morfológica
da palavra; ele geralmente é suficiente que palavras relacionadas sejam mapeadas para o mesmo
tronco, mesmo se este tronco não for ele próprio uma raiz válida. O estudo de algoritmos para
stemização tem sido realizado em ciência da computação desde a década de 60. Vários motores de
buscas tratam palavras com o mesmo tronco como sinônimos como um tipo de expansão de consulta, em
um processo de combinação.
END

my $tstart = now;
my $res = PortugueseStem($text.words>>.trim);
say $res;
say "Stemming time {now - $tstart}.";
