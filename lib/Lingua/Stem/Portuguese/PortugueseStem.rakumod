use v6.d;

=head1 PortugueseStem implementation
=begin para
Follows the Portuguese stemming implementation of:
=item http://snowball.tartarus.org/algorithms/portuguese/stemmer.html
=item https://github.com/neilb/Lingua-PT-Stemmer
=end para

unit module Lingua::Stem::Portuguese;

#| The Portuguese stemming rules
my %rule;

%rule<plural> = {
    "ns" => [1, "m"],
    "ões" => [3, "ão"],
    "ães" => [1, "ão"],
    "ais" => [1, "al"],
    "éis" => [2, "el"],
    "eis" => [2, "el"],
    "óis" => [2, "ol"],
    "is" => [2, "il"],
    "les" => [2, "l"],
    "res" => [3, "r"],
    "s" => [2, ""],
};

%rule<femin> = {
    "ona" => [3, "ão"],
    "ã" => [2, "ão"],
    "ora" => [3, "or"],
    "na" => [4, "no"],
    "inha" => [3, "inho"],
    "esa" => [3, "ês"],
    "osa" => [3, "oso"],
    "íaca" => [3, "íaco"],
    "ica" => [3, "ico"],
    "ada" => [3, "ado"],
    "ida" => [3, "ido"],
    "ída" => [3, "ido"],
    "ima" => [3, "imo"],
    "iva" => [3, "ivo"],
    "eira" => [3, "eiro"],
};

%rule<augment> = {
    "díssimo" => [5, ''],
    "abilíssimo" => [5, ''],
    "íssimo" => [3, ''],
    "ésimo" => [3, ''],
    "érrimo" => [4, ''],
    "zinho" => [2, ''],
    "quinho" => [4, "c"],
    "uinho" => [4, ''],
    "adinho" => [3, ''],
    "inho" => [3, ''],
    "alhão" => [4, ''],
    "uça" => [4, ''],
    "aço" => [4, ''],
    "adão" => [4, ''],
    "ázio" => [3, ''],
    "arraz" => [4, ''],
    "arra" => [3, ''],
    "zão" => [2, ''],
    "ão" => [3, ''],
};


%rule<noun> = {
    "encialista" => [4, ''],
    "alista" => [5, ''],
    "agem" => [3, ''],
    "iamento" => [4, ''],
    "amento" => [3, ''],
    "imento" => [3, ''],
    "alizado" => [4, ''],
    "atizado" => [4, ''],
    "izado" => [5, ''],
    "ativo" => [4, ''],
    "tivo" => [4, ''],
    "ivo" => [4, ''],
    "ado" => [2, ''],
    "ido" => [3, ''],
    "ador" => [3, ''],
    "edor" => [3, ''],
    "idor" => [4, ''],
    "atória" => [5, ''],
    "or" => [2, ''],
    "abilidade" => [5, ''],
    "icionista" => [4, ''],
    "cionista" => [5, ''],
    "ional" => [4, ''],
    "ência" => [3, ''],
    "ância" => [4, ''],
    "edouro" => [3, ''],
    "queiro" => [3, 'c'],
    "eiro" => [3, ''],
    "oso" => [3, ''],
    "alizaç" => [5, ''],
    "ismo" => [3, ''],
    "izaç" => [5, ''],
    "aç" => [3, ''],
    "iç" => [3, ''],
    "ário" => [3, ''],
    "ério" => [6, ''],
    "ês" => [4, ''],
    "eza" => [3, ''],
    "ez" => [4, ''],
    "esco" => [4, ''],
    "ante" => [2, ''],
    "ástico" => [4, ''],
    "ático" => [3, ''],
    "ico" => [4, ''],
    "ividade" => [5, ''],
    "idade" => [5, ''],
    "oria" => [4, ''],
    "encial" => [5, ''],
    "ista" => [4, ''],
    "quice" => [4, 'c'],
    "ice" => [4, ''],
    "íaco" => [3, ''],
    "ente" => [4, ''],
    "inal" => [3, ''],
    "ano" => [4, ''],
    "ável" => [2, ''],
    "ível" => [5, ''],
    "ura" => [4, ''],
    "ual" => [3, ''],
    "ial" => [3, ''],
    "al" => [4, ''],
};


%rule<verb> = {
    "aríamo" => [2, ''],
    "eria" => [3, ''],
    "ássemo" => [2, ''],
    "ermo" => [3, ''],
    "eríamo" => [2, ''],
    "esse" => [3, ''],
    "êssemo" => [2, ''],
    "este" => [3, ''],
    "iríamo" => [3, ''],
    "íamo" => [3, ''],
    "íssemo" => [3, ''],
    "iram" => [3, ''],
    "áramo" => [2, ''],
    "íram" => [3, ''],
    "árei" => [2, ''],
    "irde" => [2, ''],
    "aremo" => [2, ''],
    "irei" => [3, ''],
    "ariam" => [2, ''],
    "irem" => [3, ''],
    "aríei" => [2, ''],
    "iria" => [3, ''],
    "ássei" => [2, ''],
    "irmo" => [3, ''],
    "assem" => [2, ''],
    "isse" => [3, ''],
    "ávamo" => [2, ''],
    "iste" => [4, ''],
    "êramo" => [3, ''],
    "amo" => [2, ''],
    "eremo" => [3, ''],
    "ara" => [2, ''],
    "eriam" => [3, ''],
    "ará" => [2, ''],
    "eríei" => [3, ''],
    "are" => [2, ''],
    "êssei" => [3, ''],
    "ava" => [2, ''],
    "essem" => [3, ''],
    "emo" => [2, ''],
    "íramo" => [3, ''],
    "era" => [3, ''],
    "iremo" => [3, ''],
    "erá" => [3, ''],
    "iriam" => [3, ''],
    "ere" => [3, ''],
    "iríei" => [3, ''],
    "iam" => [3, ''],
    "íssei" => [3, ''],
    "íei" => [3, ''],
    "issem" => [3, ''],
    "imo" => [3, ''],
    "ando" => [2, ''],
    "ira" => [3, ''],
    "endo" => [3, ''],
    "irá" => [3, ''],
    "indo" => [3, ''],
    "ire" => [3, ''],
    "ondo" => [3, ''],
    "omo" => [3, ''],
    "aram" => [2, ''],
    "ai" => [2, ''],
    "arde" => [2, ''],
    "am" => [2, ''],
    "arei" => [2, ''],
    "ear" => [4, ''],
    "arem" => [2, ''],
    "ar" => [2, ''],
    "aria" => [2, ''],
    "uei" => [3, ''],
    "armo" => [2, ''],
    "ei" => [3, ''],
    "asse" => [2, ''],
    "em" => [2, ''],
    "aste" => [2, ''],
    "er" => [2, ''],
    "avam" => [2, ''],
    "eu" => [3, ''],
    "ávei" => [2, ''],
    "ia" => [3, ''],
    "eram" => [3, ''],
    "ir" => [3, ''],
    "erde" => [3, ''],
    "iu" => [3, ''],
    "erei" => [3, ''],
    "ou" => [3, ''],
    "êrei" => [3, ''],
    "i" => [3, ''],
    "erem" => [3, ''],
};

%rule<accent> = { :ã("a"), :õ("o"), :é("e"), :â("a"), :ó("o"), :ú("u"), :ê("e"), :ç("c"), :á("a"), :í("i") };

#============================================================
# The code in these functions is very close to the original Perl code in
# https://github.com/neilb/Lingua-PT-Stemmer/blob/master/lib/Lingua/PT/Stemmer.pm

#| Strip
sub strip($cmd, $word is copy) {
    if $cmd eq 'accent' {
        for %rule<accent>.kv -> $a, $v {
            $word ~~ s/$a/$v/;
        }
    } elsif $cmd eq 'adv' {
        $word ~~ s/ (. ** 4..*) mente /$0/;
    } elsif $cmd eq 'vowel' {
        for <a e o> -> $c {
            $word ~~ s/ (. ** 3..*) $c $ /$0/
        };
    } else {
        my %cmdref = %rule{$cmd};
        for %cmdref.keys.sort({ -$_.chars }) -> $k {
            my $patt = / ^ (. ** { %cmdref{$k}[0] }..*) $k $/;
            if $word ~~ $patt {
                $word = $word.subst( $patt, { "$0" ~ (%cmdref{$k}[1])});
                last;
            }
        }
    }
    return $word;
}

#| PortugueseStem
proto PortugueseStem($wordSpec) is export {*}

#| PortugueseStem
multi PortugueseStem(@words --> List) {
    return @words.map({ PortugueseStem($_) }).List;
}

#| PortugueseStem
multi PortugueseStem(Str:D $word is copy --> Str) {

    $word = strip('plural', $word) if $word ~~ /s $/;
    $word = strip('femin', $word) if $word ~~ /a $/;
    for <augment adv noun verb vowel accent> -> $op {
        $word = strip($op, $word);
    }

    #return $word.substr(0, $start.chars) ~ $word.substr($start.chars, $RV.Str.chars);
    return $word;
}

#| Synonym of PortugueseStem
sub portuguese-word-stem($arg) is export {
    return PortugueseStem($arg);
}
